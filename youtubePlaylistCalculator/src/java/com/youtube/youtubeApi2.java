/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.youtube;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import java.time.Duration;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class youtubeApi2 extends HttpServlet {
    // Your Google-issued key; enable YouTube Data API v3
    private static final String API_KEY = "AIzaSyBNsRrGNqKBz3xZl6K115nyHRSTZ6JhIv8";
    // Endpoints for playlists and videos
    private static final String PLAYLIST_API_URL =
        "https://www.googleapis.com/youtube/v3/playlists";
    private static final String PLAYLIST_ITEMS_API_URL =
        "https://www.googleapis.com/youtube/v3/playlistItems";
    private static final String VIDEOS_API_URL =
        "https://www.googleapis.com/youtube/v3/videos";
    
    // Regex to pull “list=PL…” from full URL
    private static final Pattern LIST_ID = Pattern.compile("(?:[?&]list=)([A-Za-z0-9_-]+)");
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
                         throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        
        // 1. Get raw URL param
        String rawUrl = req.getParameter("playlistUrl");
        if (rawUrl == null) {
//            req.setAttribute("error", "Missing playlistUrl parameter");
//            req.getRequestDispatcher("/index.jsp").forward(req, resp);
           out.println("Invalid url");
            return;
        }
        
        // 2. Extract playlistId
        Matcher m = LIST_ID.matcher(rawUrl);
        if (!m.find()) {
//            req.setAttribute("error", "Invalid YouTube playlist URL");
//            req.getRequestDispatcher("/playlistInfo.jsp").forward(req, resp);
              out.println("Invalid url");
              return;
        }
        String playlistId = m.group(1);
        
        // 3. Build API URL to fetch playlist details
        String urlStr = String.format(
            "%s?part=snippet,contentDetails&id=%s&key=%s",
            PLAYLIST_API_URL, URLEncoder.encode(playlistId, "UTF-8"), API_KEY
        );
        
        // 4. Call YouTube and read JSON into a String for playlist details
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        try (InputStream in = conn.getInputStream();
             Scanner scanner = new Scanner(in, "UTF-8")) {
            StringBuilder jsonSb = new StringBuilder();
            while (scanner.hasNextLine()) {
                jsonSb.append(scanner.nextLine());
            }
            Gson gson = new Gson();
            JsonObject root = gson.fromJson(jsonSb.toString(), JsonObject.class);
            JsonArray items = root.getAsJsonArray("items");
            if (items.size() == 0) {
                req.setAttribute("error", "No playlist found for ID " + playlistId);
            } else {
                JsonObject playlist = items.get(0).getAsJsonObject();
                JsonObject snippet = playlist.getAsJsonObject("snippet");
                JsonObject contentDetails = playlist.getAsJsonObject("contentDetails");
                String title       = snippet.get("title").getAsString();
                String description = snippet.get("description").getAsString();
                int    itemCount   = contentDetails.get("itemCount").getAsInt();
                String thumbUrl    = snippet.getAsJsonObject("thumbnails")
                                           .getAsJsonObject("default")
                                           .get("url").getAsString();
                
                // Set basic playlist attributes
                req.setAttribute("playlistId", playlistId);
                req.setAttribute("title", title);
                req.setAttribute("description", description);
                req.setAttribute("itemCount", itemCount);
                req.setAttribute("thumbnail", thumbUrl);
                
                // Now calculate video duration metrics
                VideoDurationMetrics metrics = fetchDurationMetrics(playlistId, itemCount);
                req.setAttribute("totalDuration", metrics.totalDuration);
                req.setAttribute("minDuration", metrics.minDuration);
                req.setAttribute("maxDuration", metrics.maxDuration);
            }
        } catch (IOException e) {
            req.setAttribute("error", "Error fetching playlist: " + e.getMessage());
        } finally {
            conn.disconnect();
        }
        
        // 7. Forward to JSP
        req.getRequestDispatcher("/playlistInfo.jsp")
           .forward(req, resp);
    }
    
    /**
     * A helper method that retrieves video IDs from a playlist and then calculates:
     * - total duration (sum of all videos' durations in seconds),
     * - minimum video duration (in seconds), and
     * - maximum video duration (in seconds).
     */
    private VideoDurationMetrics fetchDurationMetrics(String playlistId, int totalVideos) throws IOException {
        List<String> videoIds = new ArrayList<>();
        String nextPageToken = "";
        Gson gson = new Gson();
        
        // Retrieve video IDs from the playlist (handle pagination if needed)
        do {
            String playlistItemsUrl = String.format(
                "%s?part=contentDetails&maxResults=50&playlistId=%s&key=%s%s",
                PLAYLIST_ITEMS_API_URL,
                URLEncoder.encode(playlistId, "UTF-8"),
                API_KEY,
                nextPageToken.isEmpty() ? "" : "&pageToken=" + nextPageToken
            );
            HttpURLConnection piConn = (HttpURLConnection) new URL(playlistItemsUrl).openConnection();
            piConn.setRequestMethod("GET");
            try (InputStream piIn = piConn.getInputStream();
                 Scanner scanner = new Scanner(piIn, "UTF-8")) {
                StringBuilder piJson = new StringBuilder();
                while (scanner.hasNextLine()) {
                    piJson.append(scanner.nextLine());
                }
                JsonObject piRoot = gson.fromJson(piJson.toString(), JsonObject.class);
                JsonArray itemsArr = piRoot.getAsJsonArray("items");
                for (JsonElement item : itemsArr) {
                    JsonObject itemObj = item.getAsJsonObject();
                    JsonObject contentDet = itemObj.getAsJsonObject("contentDetails");
                    videoIds.add(contentDet.get("videoId").getAsString());
                }
                nextPageToken = (piRoot.has("nextPageToken"))
                                  ? piRoot.get("nextPageToken").getAsString() : "";
            } finally {
                piConn.disconnect();
            }
        } while (!nextPageToken.isEmpty());
        
        // Initialise duration metrics
        long totalDuration = 0;
        long minDuration = Long.MAX_VALUE;
        long maxDuration = 0;
        
        // YouTube API for videos allows up to 50 video IDs per request.
        for (int i = 0; i < videoIds.size(); i += 50) {
            List<String> batch = videoIds.subList(i, Math.min(i + 50, videoIds.size()));
            String joinedVideoIds = String.join(",", batch);
            String videosUrl = String.format(
                "%s?part=contentDetails&id=%s&key=%s",
                VIDEOS_API_URL,
                joinedVideoIds,
                API_KEY
            );
            HttpURLConnection vidConn = (HttpURLConnection) new URL(videosUrl).openConnection();
            vidConn.setRequestMethod("GET");
            try (InputStream vidIn = vidConn.getInputStream();
                 Scanner scanner = new Scanner(vidIn, "UTF-8")) {
                StringBuilder vidJson = new StringBuilder();
                while (scanner.hasNextLine()) {
                    vidJson.append(scanner.nextLine());
                }
                JsonObject vidRoot = gson.fromJson(vidJson.toString(), JsonObject.class);
                JsonArray vidItems = vidRoot.getAsJsonArray("items");
                for (JsonElement vidItem : vidItems) {
                    JsonObject vidObj = vidItem.getAsJsonObject();
                    JsonObject details = vidObj.getAsJsonObject("contentDetails");
                    String isoDuration = details.get("duration").getAsString();
                    // Parse the ISO 8601 duration string (e.g., "PT2M45S") into seconds.
                    long durationSeconds = Duration.parse(isoDuration).getSeconds();
                    totalDuration += durationSeconds;
                    if (durationSeconds < minDuration) {
                        minDuration = durationSeconds;
                    }
                    if (durationSeconds > maxDuration) {
                        maxDuration = durationSeconds;
                    }
                }
            } finally {
                vidConn.disconnect();
            }
        }
        
        // In case the playlist is empty, adjust minDuration.
        if (minDuration == Long.MAX_VALUE) {
            minDuration = 0;
        }
        
        return new VideoDurationMetrics(totalDuration, minDuration, maxDuration);
    }
    
    // A helper class to bundle our duration metrics.
    private static class VideoDurationMetrics {
        long totalDuration;   // in seconds
        long minDuration;     // in seconds
        long maxDuration;     // in seconds
        
        public VideoDurationMetrics(long total, long min, long max) {
            this.totalDuration = total;
            this.minDuration = min;
            this.maxDuration = max;
        }
    }
}