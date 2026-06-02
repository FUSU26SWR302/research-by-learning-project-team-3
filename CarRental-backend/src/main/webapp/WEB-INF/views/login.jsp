<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Sign in to the Car Rental Platform to manage your rentals or car listings.">
    <title>Sign In – Car Rental Platform</title>

    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">
    <!-- Google Font: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <style>
        :root {
            --primary:     #4f46e5;
            --primary-dark:#3730a3;
            --accent:      #06b6d4;
            --bg-dark:     #0f0f1a;
            --card-bg:     rgba(255,255,255,0.05);
            --border:      rgba(255,255,255,0.12);
        }

        * { box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            background: var(--bg-dark);
            background-image:
                radial-gradient(ellipse at 80% 50%, rgba(79,70,229,.25) 0%, transparent 60%),
                radial-gradient(ellipse at 20% 20%, rgba(6,182,212,.20) 0%, transparent 55%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }

        .auth-card {
            width: 100%;
            max-width: 420px;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 1.5rem;
            padding: 2.5rem 2rem;
            box-shadow: 0 25px 60px rgba(0,0,0,.5);
            animation: fadeUp .45s ease both;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .brand-logo {
            width: 52px; height: 52px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.6rem; color: #fff;
            margin: 0 auto 1.25rem;
            box-shadow: 0 4px 20px rgba(79,70,229,.4);
        }

        h1.auth-title {
            color: #fff;
            font-size: 1.6rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: .25rem;
        }

        .auth-subtitle {
            color: rgba(255,255,255,.55);
            font-size: .875rem;
            text-align: center;
            margin-bottom: 1.75rem;
        }

        .form-label {
            color: rgba(255,255,255,.75);
            font-size: .8125rem;
            font-weight: 500;
            margin-bottom: .35rem;
        }

        .form-control {
            background: rgba(255,255,255,.07);
            border: 1px solid var(--border);
            color: #fff;
            border-radius: .75rem;
            padding: .65rem 1rem;
            font-size: .9rem;
            transition: border-color .2s, box-shadow .2s;
        }

        .form-control:focus {
            background: rgba(255,255,255,.10);
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79,70,229,.3);
            color: #fff;
            outline: none;
        }

        .form-control::placeholder { color: rgba(255,255,255,.3); }

        .input-group-text {
            background: rgba(255,255,255,.07);
            border: 1px solid var(--border);
            border-right: none;
            color: rgba(255,255,255,.5);
            border-radius: .75rem 0 0 .75rem;
        }

        .input-group .form-control {
            border-left: none;
            border-radius: 0 .75rem .75rem 0;
        }

        .btn-toggle-pw {
            background: rgba(255,255,255,.07);
            border: 1px solid var(--border);
            border-left: none;
            color: rgba(255,255,255,.5);
            border-radius: 0 .75rem .75rem 0;
            cursor: pointer;
            transition: background .2s;
        }

        .btn-toggle-pw:hover { background: rgba(255,255,255,.12); }

        .btn-signin {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border: none;
            color: #fff;
            font-weight: 600;
            border-radius: .75rem;
            padding: .75rem;
            font-size: 1rem;
            width: 100%;
            transition: opacity .2s, transform .15s;
            letter-spacing: .01em;
        }

        .btn-signin:hover  { opacity: .9; transform: translateY(-1px); }
        .btn-signin:active { transform: translateY(0); }

        /* Alert variants */
        .alert-custom {
            border-radius: .75rem;
            padding: .75rem 1rem;
            font-size: .875rem;
            display: flex;
            align-items: flex-start;
            gap: .5rem;
        }

        .alert-error {
            background: rgba(239,68,68,.12);
            border: 1px solid rgba(239,68,68,.4);
            color: #fca5a5;
        }

        .alert-success {
            background: rgba(34,197,94,.12);
            border: 1px solid rgba(34,197,94,.4);
            color: #86efac;
        }

        .alert-info {
            background: rgba(59,130,246,.12);
            border: 1px solid rgba(59,130,246,.4);
            color: #93c5fd;
        }

        .divider {
            border-top: 1px solid var(--border);
            margin: 1.5rem 0;
        }

        .link-subtle { color: rgba(255,255,255,.55); font-size: .875rem; text-align: center; }
        .link-subtle a { color: var(--accent); text-decoration: none; font-weight: 500; }
        .link-subtle a:hover { text-decoration: underline; }

        .remember-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.25rem;
        }

        .remember-row label {
            color: rgba(255,255,255,.6);
            font-size: .8125rem;
            cursor: pointer;
        }

        .remember-row input[type="checkbox"] {
            accent-color: var(--primary);
            margin-right: .35rem;
        }

        .forgot-link {
            color: var(--accent);
            font-size: .8125rem;
            text-decoration: none;
        }

        .forgot-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="auth-card">

    <!-- Brand -->
    <div class="brand-logo"><i class="bi bi-car-front-fill"></i></div>
    <h1 class="auth-title">Welcome back</h1>
    <p class="auth-subtitle">Sign in to your Car Rental account</p>

    <%-- ── Success message after registration (PRG pattern) ─────────── --%>
    <c:if test="${param.registered eq 'true'}">
        <div class="alert-custom alert-success mb-3" role="alert">
            <i class="bi bi-check-circle-fill mt-1"></i>
            <span>Account created successfully! Please sign in below.</span>
        </div>
    </c:if>

    <%-- ── Success message after logout ─────────────────────────────── --%>
    <c:if test="${param.logout eq 'true'}">
        <div class="alert-custom alert-info mb-3" role="alert">
            <i class="bi bi-info-circle-fill mt-1"></i>
            <span>You have been successfully signed out.</span>
        </div>
    </c:if>

    <%-- ── Account disabled message from filter redirect ───────────── --%>
    <c:if test="${param.error eq 'account_disabled'}">
        <div class="alert-custom alert-error mb-3" role="alert">
            <i class="bi bi-slash-circle-fill mt-1"></i>
            <span>Your account has been disabled. Please contact support.</span>
        </div>
    </c:if>

    <%-- ── Login error from LoginServlet ────────────────────────────── --%>
    <c:if test="${not empty error}">
        <div class="alert-custom alert-error mb-3" role="alert" id="loginErrorAlert">
            <i class="bi bi-exclamation-triangle-fill mt-1"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- Login Form -->
    <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" novalidate>

        <!-- Email -->
        <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                <input type="email" id="email" name="email" class="form-control"
                       placeholder="you@example.com"
                       value="${not empty email ? email : ''}"
                       required autofocus>
            </div>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input type="password" id="password" name="password" class="form-control"
                       placeholder="Your password" required>
                <button type="button" class="btn-toggle-pw" id="togglePwd" aria-label="Toggle password visibility">
                    <i class="bi bi-eye" id="eyeIcon"></i>
                </button>
            </div>
        </div>

        <!-- Remember + Forgot -->
        <div class="remember-row">
            <label>
                <input type="checkbox" id="rememberMe" name="rememberMe">
                Remember me
            </label>
            <%-- Placeholder link – implement "forgot password" UC in future sprint --%>
            <a href="#" class="forgot-link">Forgot password?</a>
        </div>

        <button type="submit" class="btn-signin" id="signinBtn">
            <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
        </button>

    </form>

    <div class="divider"></div>

    <p class="link-subtle">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register">Create one for free</a>
    </p>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ── Toggle password visibility ──────────────────────────────────
    document.getElementById('togglePwd').addEventListener('click', function () {
        const pwd = document.getElementById('password');
        const eye = document.getElementById('eyeIcon');
        if (pwd.type === 'password') {
            pwd.type = 'text';
            eye.className = 'bi bi-eye-slash';
        } else {
            pwd.type = 'password';
            eye.className = 'bi bi-eye';
        }
    });

    // ── Basic client-side validation ────────────────────────────────
    document.getElementById('loginForm').addEventListener('submit', function (e) {
        const email = document.getElementById('email').value.trim();
        const pwd   = document.getElementById('password').value.trim();
        if (!email || !pwd) {
            e.preventDefault();
            alert('Please enter both email and password.');
        }
    });

    // ── Auto-dismiss the error alert after 8 seconds ────────────────
    const errAlert = document.getElementById('loginErrorAlert');
    if (errAlert) {
        setTimeout(() => {
            errAlert.style.transition = 'opacity .5s';
            errAlert.style.opacity    = '0';
            setTimeout(() => errAlert.remove(), 500);
        }, 8000);
    }
</script>
</body>
</html>
