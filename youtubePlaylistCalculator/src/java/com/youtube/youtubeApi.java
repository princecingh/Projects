

package com.youtube;

/**
 *
 * @author princ
 */
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import java.util.*;
import java.util.regex.*;


public class youtubeApi extends HttpServlet {
    // 1) your Google-issued key; enable YouTube Data API v3
    private static final String API_KEY = "AIzaSyBNsRrGNqKBz3xZl6K115nyHRSTZ6JhIv8";
    // 2) YouTube playlists endpoint
    private static final String API_URL =
      "https://www.googleapis.com/youtube/v3/playlists";
    // 3) regex to pull “list=PL…” from full URL
    private static final Pattern LIST_ID =
      Pattern.compile("(?:[?&]list=)([A-Za-z0-9_-]+)");
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
                         throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        // ─── 1. Get raw URL param ────────────────────────────────────────────
        String rawUrl = req.getParameter("playlistUrl");
//        if (rawUrl == null) {
//            req.setAttribute("error", "Missing playlistUrl parameter");
//            req.getRequestDispatcher("/index.jsp").forward(req, resp);
//            return;
//        }
        // ─── 2. Extract playlistId ─────────────────────────────────────────
        Matcher m = LIST_ID.matcher(rawUrl);
// ─── 2. Extract playlistId ─────────────────────────────────────────

if (!m.find()) {
    req.setAttribute("error", "Invalid YouTube playlist URL");
    req.getRequestDispatcher("/playlistInfo.jsp").forward(req, resp);
    return;
}

        String playlistId = m.group(1);
        // ─── 3. Build API URL ──────────────────────────────────────────────
        String urlStr = String.format(
            "%s?part=snippet,contentDetails&id=%s&key=%s",
            API_URL, URLEncoder.encode(playlistId, "UTF-8"), API_KEY
        );
        // ─── 4. Call YouTube and read JSON into a String ───────────────────
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        try (InputStream in = conn.getInputStream();
             Scanner scanner = new Scanner(in, "UTF-8")) {
            StringBuilder jsonSb = new StringBuilder();
            while (scanner.hasNextLine()) {
                jsonSb.append(scanner.nextLine());
            }
            // ─── 5. Parse with Gson ───────────────────────────────────────
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
                String thumbUrl    = snippet
                                      .getAsJsonObject("thumbnails")
                                      .getAsJsonObject("default")
                                      .get("url").getAsString();
                // ─── 6. Set JSP attributes ───────────────────────────────
                req.setAttribute("playlistId", playlistId);
                req.setAttribute("title", title);
                req.setAttribute("description", description);
                req.setAttribute("itemCount", itemCount);
                req.setAttribute("thumbnail", thumbUrl);
            }
        } catch (IOException e) {
            req.setAttribute("error", "Error fetching playlist: " + e.getMessage());
        } finally {
            conn.disconnect();
        }
        // ─── 7. Forward to JSP ───────────────────────────────────────────
        req.getRequestDispatcher("/playlistInfo.jsp")
           .forward(req, resp);
    }
}