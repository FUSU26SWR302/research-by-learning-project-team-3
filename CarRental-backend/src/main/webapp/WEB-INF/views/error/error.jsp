<%@ page contentType="text/html;charset=UTF-8" language="java"
         isErrorPage="true"
         import="java.io.PrintWriter, java.io.StringWriter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 – Something Went Wrong | Car Rental Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root { --primary:#4f46e5; --accent:#06b6d4; }
        * { box-sizing:border-box; }
        body {
            font-family:'Inter',sans-serif; background:#0f0f1a; color:#fff; margin:0;
            min-height:100vh; display:flex; align-items:center; justify-content:center;
            background-image:
                radial-gradient(ellipse at 70% 30%, rgba(239,68,68,.15) 0%, transparent 60%),
                radial-gradient(ellipse at 20% 70%, rgba(79,70,229,.12) 0%, transparent 55%);
        }
        .error-card {
            text-align:center; max-width:540px; width:100%; padding:3rem 2rem;
            background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.09);
            border-radius:1.5rem; box-shadow:0 25px 60px rgba(0,0,0,.5);
            animation:fadeUp .5s ease both;
        }
        @keyframes fadeUp {
            from { opacity:0; transform:translateY(20px); }
            to   { opacity:1; transform:translateY(0); }
        }
        .error-code {
            font-size:6rem; font-weight:800; line-height:1;
            background:linear-gradient(135deg,#8b5cf6,#ec4899);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text; margin-bottom:.5rem;
        }
        .error-icon { font-size:3rem; margin-bottom:1rem; display:block; }
        h1 { font-size:1.4rem; font-weight:700; margin-bottom:.6rem; }
        p  { color:rgba(255,255,255,.55); font-size:.9rem; line-height:1.7; margin-bottom:1.5rem; }
        .btn-home {
            background:linear-gradient(135deg,var(--primary),var(--accent));
            border:none; color:#fff; border-radius:.75rem;
            padding:.7rem 1.75rem; font-size:.9rem; font-weight:600;
            text-decoration:none; display:inline-flex; align-items:center; gap:.5rem;
            transition:opacity .2s;
        }
        .btn-home:hover { opacity:.88; color:#fff; }

        /* Collapsible stack trace – dev aid only, remove in production */
        details {
            margin-top:1.5rem; text-align:left;
            background:rgba(0,0,0,.3); border:1px solid rgba(255,255,255,.08);
            border-radius:.75rem; overflow:hidden;
        }
        summary {
            padding:.65rem 1rem; cursor:pointer; font-size:.8125rem;
            color:rgba(255,255,255,.5); font-weight:500;
            list-style:none; user-select:none;
        }
        summary::-webkit-details-marker { display:none; }
        summary::before { content:"▶  "; font-size:.7rem; }
        details[open] summary::before { content:"▼  "; }
        pre {
            margin:0; padding:1rem;
            font-size:.75rem; color:#f87171;
            overflow-x:auto; white-space:pre-wrap; word-break:break-word;
            max-height:260px;
        }
    </style>
</head>
<body>
<div class="error-card">
    <span class="error-icon">&#9889;</span>
    <div class="error-code">500</div>
    <h1>Something Went Wrong</h1>
    <p>
        An unexpected server error occurred. Our team has been notified.<br>
        Please try again or return to the homepage.
    </p>

    <a href="${pageContext.request.contextPath}/" class="btn-home">
        <i class="bi bi-house-fill"></i>&nbsp;Return to Home
    </a>

    <%-- ── Dev-only: collapsible stack trace ─────────────────────── --%>
    <%
        // Only expose stack trace in development/local environment
        // Remove this block before deploying to production
        String showTrace = application.getInitParameter("showErrorTrace");
        if ("true".equals(showTrace) && exception != null) {
            StringWriter sw = new StringWriter();
            exception.printStackTrace(new PrintWriter(sw));
            String trace = sw.toString();
    %>
    <details>
        <summary><i class="bi bi-bug me-1"></i> Developer Details (dev mode only)</summary>
        <pre><%= trace %></pre>
    </details>
    <% } %>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
