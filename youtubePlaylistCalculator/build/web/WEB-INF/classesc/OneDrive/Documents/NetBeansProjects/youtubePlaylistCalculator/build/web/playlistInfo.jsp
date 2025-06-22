


<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Playlist Info</title>
    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
      rel="stylesheet"
    />
    <!-- FontAwesome -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <style>
      body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #2c3e50, #4ca1af);
        margin: 0;
        padding: 0;
        color: #333;
      }
      /* Center the main content with full-page height */
      .main-container {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        padding: 20px;
      }
      /* Glassmorphism effect on the card */
      .playlist-card {
        width: 100%;
        max-width: 900px;
        background: rgba(255, 255, 255, 0.85);
        border-radius: 15px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        overflow: hidden;
        animation: fadeInUp 1s ease-out;
      }
      @keyframes fadeInUp {
        from {
          opacity: 0;
          transform: translateY(50px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
      .card-header {
        background: #ff6f61;
        color: #fff;
        text-align: center;
        padding: 20px;
        font-size: 1.75rem;
        font-weight: 600;
        text-transform: uppercase;
      }
      .card-body {
        padding: 25px;
      }
      .thumbnail-img {
        border-radius: 10px;
        border: 3px solid #ff6f61;
      }
      .info-list li {
        margin-bottom: 10px;
        font-size: 1.1rem;
      }
      .list-group-item {
        background-color: #f8f9fa;
        border: none;
        padding: 10px 15px;
        font-size: 1.1rem;
      }
      .metrics-title,
      .playback-title {
        margin-bottom: 15px;
        text-decoration: underline;
      }
      .back-btn {
        margin: 20px auto;
        display: block;
        border-radius: 50px;
        font-size: 1.1rem;
        background: #ff6f61;
        color: #fff;
        padding: 10px 25px;
        border: none;
        transition: background-color 0.3s ease;
      }
      .back-btn:hover {
        background: #e65b50;
      }
      /* Ensure compact layout on tall screens */
      @media (max-height: 800px) {
        .card-header,
        .card-body {
          padding: 0.75rem 1rem;
          font-size: 0.9rem;
        }
      }
    </style>
  </head>
  <body>
    <div class="container main-container">
      <div class="playlist-card">
        <!-- Error Message -->
<!--        <c:if test="${not empty error}">
          <div class="alert alert-danger text-center m-3" role="alert">
            <i class="fas fa-exclamation-triangle"></i> ${error}
          </div>
        </c:if>-->
        <!-- Playlist Details and Metrics -->
        <c:if test="${empty error}">
          <div class="card-header">
            ${title}
          </div>
          <div class="card-body">
            <div class="row">
              <div class="col-md-4 text-center">
                <img
                  src="${thumbnail}"
                  alt="Thumbnail"
                  class="img-fluid thumbnail-img mb-3"
                />
              </div>
              <div class="col-md-8">
                <ul class="list-unstyled info-list">
                  <li>
                    <i class="fas fa-id-badge"></i>
                    <strong>ID: </strong>${playlistId}
                  </li>
                  <li>
                    <i class="fas fa-video"></i>
                    <strong>Videos: </strong>${itemCount}
                  </li>
                  <li>
                    <i class="fas fa-align-left"></i>
                    <strong>Description: </strong>${description}
                  </li>
                </ul>
              </div>
            </div>
            <hr />
            <% 
              // Retrieve durations (in seconds) from attributes
              long totalDuration = (Long) request.getAttribute("totalDuration")!=null?(Long) request.getAttribute("totalDuration"):0;
              long minDuration   = (Long) request.getAttribute("minDuration")!=null?(Long) request.getAttribute("minDuration"):0;
              long maxDuration   = (Long) request.getAttribute("maxDuration")!=null?(Long) request.getAttribute("maxDuration"):0;
             
              // Total duration conversion
              long totalHours   = totalDuration / 3600;
              long totalMinutes = (totalDuration % 3600) / 60;
              long totalSeconds = totalDuration % 60;
              String totalFormatted = totalHours + " hr " + totalMinutes + " min " + totalSeconds + " sec";

              // Minimum video duration conversion
              long minHours   = minDuration / 3600;
              long minMinutes = (minDuration % 3600) / 60;
              long minSeconds = minDuration % 60;
              String minFormatted = minHours + " hr " + minMinutes + " min " + minSeconds + " sec";

              // Maximum video duration conversion
              long maxHours   = maxDuration / 3600;
              long maxMinutes = (maxDuration % 3600) / 60;
              long maxSeconds = maxDuration % 60;
              String maxFormatted = maxHours + " hr " + maxMinutes + " min " + maxSeconds + " sec";

              // Playback speeds and corresponding effective duration calculations
              double speeds[] = {2.0, 1.75, 1.5, 1.25};
              Map<Double, String> speedResults = new LinkedHashMap<>();
              for (double speed : speeds) {
                  long effectiveDuration = (long) Math.ceil(totalDuration / speed);
                  long eHours = effectiveDuration / 3600;
                  long eMinutes = (effectiveDuration % 3600) / 60;
                  long eSeconds = effectiveDuration % 60;
                  String conversion = eHours + " hr " + eMinutes + " min " + eSeconds + " sec";
                  speedResults.put(speed, conversion);
              }
            %>
            <div class="row">
              <div class="col-md-6">
                <h4 class="metrics-title text-primary">
                  <i class="fas fa-stopwatch"></i> Duration Metrics
                </h4>
                <ul class="list-group">
                  <li class="list-group-item">
                    <strong>Total Duration:</strong> <%= totalFormatted %>
                  </li>
                  <li class="list-group-item">
                    <strong>Shortest Video:</strong> <%= minFormatted %>
                  </li>
                  <li class="list-group-item">
                    <strong>Longest Video:</strong> <%= maxFormatted %>
                  </li>
                </ul>
              </div>
              <div class="col-md-6">
                <h4 class="playback-title text-success">
                  <i class="fas fa-play"></i> Playback Speeds
                </h4>
                <ul class="list-group">
                  <% for (Map.Entry<Double, String> entry : speedResults.entrySet()) { %>
                  <li class="list-group-item">
                    At <strong><%= entry.getKey() %>x</strong>:
                    <%= entry.getValue() %>
                  </li>
                  <% } %>
                </ul>
              </div>
            </div>
          </div>
        </c:if>
        <button class="btn back-btn" onclick="location.href='index.html'">
          <i class="fas fa-arrow-left"></i> Back
        </button>
      </div>
    </div>
    <!-- Bootstrap Bundle with Popper -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
    ></script>
  </body>
</html>