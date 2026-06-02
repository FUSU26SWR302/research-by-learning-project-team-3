<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 – Access Denied | Car Rental Platform</title>
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
                radial-gradient(ellipse at 20% 50%, rgba(239,68,68,.2) 0%, transparent 60%),
                radial-gradient(ellipse at 80% 20%, rgba(79,70,229,.15) 0%, transparent 55%);
        }
        .error-card {
            text-align:center; max-width:460px; width:100%; padding:3rem 2rem;
            background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.09);
            border-radius:1.5rem;
            box-shadow:0 25px 60px rgba(0,0,0,.5);
            animation:fadeUp .5s ease both;
        }
        @keyframes fadeUp {
            from { opacity:0; transform:translateY(20px); }
            to   { opacity:1; transform:translateY(0); }
        }
        .error-code {
            font-size:6rem; font-weight:800; line-height:1;
            background:linear-gradient(135deg,#ef4444,#f97316);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text; margin-bottom:.5rem;
        }
        .error-icon {
            font-size:3rem; margin-bottom:1rem;
            display:block; animation:shake 1s ease both;
        }
        @keyframes shake {
            0%,100% { transform:translateX(0); }
            20%,60%  { transform:translateX(-6px); }
            40%,80%  { transform:translateX(6px); }
        }
        h1 { font-size:1.4rem; font-weight:700; margin-bottom:.6rem; }
        p  { color:rgba(255,255,255,.55); font-size:.9rem; line-height:1.7; margin-bottom:2rem; }
        .btn-home {
            background:linear-gradient(135deg,var(--primary),var(--accent));
            border:none; color:#fff; border-radius:.75rem;
            padding:.7rem 1.75rem; font-size:.9rem; font-weight:600;
            text-decoration:none; display:inline-flex; align-items:center; gap:.5rem;
            transition:opacity .2s, transform .15s;
        }
        .btn-home:hover { opacity:.88; transform:translateY(-1px); color:#fff; }
        .btn-back {
            background:transparent; border:1px solid rgba(255,255,255,.15);
            color:rgba(255,255,255,.6); border-radius:.75rem;
            padding:.7rem 1.75rem; font-size:.9rem; font-weight:500;
            text-decoration:none; display:inline-flex; align-items:center; gap:.5rem;
            transition:border-color .2s, background .2s; margin-left:.75rem;
        }
        .btn-back:hover { border-color:rgba(255,255,255,.35); background:rgba(255,255,255,.06); color:#fff; }
        .user-hint {
            margin-top:1.75rem; padding:.75rem 1rem;
            background:rgba(239,68,68,.08); border:1px solid rgba(239,68,68,.2);
            border-radius:.75rem; font-size:.8125rem; color:rgba(255,255,255,.5);
        }
    </style>
</head>
<body>
<div class="error-card">
    <span class="error-icon">&#128274;</span>
    <div class="error-code">403</div>
    <h1>Access Denied</h1>
    <p>
        You don't have permission to view this page.<br>
        Your account role (<strong>${sessionScope.loggedInUser.role}</strong>) is not
        authorised to access this area.
    </p>

    <a href="${pageContext.request.contextPath}/" class="btn-home">
        <i class="bi bi-house-fill"></i> Go to Home
    </a>
    <a href="javascript:history.back()" class="btn-back">
        <i class="bi bi-arrow-left"></i> Go Back
    </a>

    <c:if test="${not empty sessionScope.loggedInUser}">
        <div class="user-hint">
            Logged in as <strong>${sessionScope.loggedInUser.email}</strong> ·
            Role: <strong>${sessionScope.loggedInUser.role}</strong> ·
            <a href="${pageContext.request.contextPath}/logout"
               style="color:#f87171;text-decoration:none;font-weight:500;">
                Switch account
            </a>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
