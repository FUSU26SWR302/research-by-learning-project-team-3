<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Rental Platform – Find Your Perfect Ride</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5; --accent: #06b6d4;
            --bg: #0f0f1a; --card-bg: rgba(255,255,255,.05);
            --border: rgba(255,255,255,.1);
        }
        * { box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: #fff; margin: 0; }

        /* NAV */
        nav {
            position: fixed; top: 0; left: 0; right: 0; z-index: 100;
            backdrop-filter: blur(16px); -webkit-backdrop-filter: blur(16px);
            background: rgba(15,15,26,.7);
            border-bottom: 1px solid var(--border);
            display: flex; align-items: center; justify-content: space-between;
            padding: .9rem 2rem;
        }
        .nav-brand {
            display: flex; align-items: center; gap: .6rem;
            font-size: 1.15rem; font-weight: 700; color: #fff; text-decoration: none;
        }
        .nav-brand .logo-icon {
            width: 36px; height: 36px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 9px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.1rem;
        }
        .nav-actions { display: flex; gap: .75rem; align-items: center; }
        .btn-ghost {
            background: transparent; border: 1px solid var(--border);
            color: rgba(255,255,255,.8); border-radius: .6rem;
            padding: .45rem 1rem; font-size: .875rem; text-decoration: none;
            transition: border-color .2s, background .2s;
        }
        .btn-ghost:hover { border-color: var(--primary); background: rgba(79,70,229,.15); color: #fff; }
        .btn-cta {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: #fff; border: none; border-radius: .6rem;
            padding: .45rem 1.1rem; font-size: .875rem; font-weight: 600;
            text-decoration: none; transition: opacity .2s;
        }
        .btn-cta:hover { opacity: .88; color: #fff; }

        /* HERO */
        .hero {
            min-height: 100vh;
            display: flex; align-items: center; justify-content: center;
            text-align: center; padding: 6rem 1.5rem 3rem;
            background-image:
                radial-gradient(ellipse at 30% 60%, rgba(79,70,229,.3) 0%, transparent 55%),
                radial-gradient(ellipse at 75% 25%, rgba(6,182,212,.25) 0%, transparent 55%);
        }
        .hero-badge {
            display: inline-flex; align-items: center; gap: .4rem;
            background: rgba(79,70,229,.15); border: 1px solid rgba(79,70,229,.4);
            color: #a5b4fc; border-radius: 100px;
            padding: .3rem .85rem; font-size: .8rem; font-weight: 500;
            margin-bottom: 1.5rem;
        }
        .hero h1 {
            font-size: clamp(2.2rem, 6vw, 4rem); font-weight: 800;
            line-height: 1.15; margin-bottom: 1.25rem;
            background: linear-gradient(135deg, #fff 40%, #818cf8 100%);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .hero p {
            font-size: 1.1rem; color: rgba(255,255,255,.6);
            max-width: 520px; margin: 0 auto 2.25rem; line-height: 1.7;
        }
        .hero-actions { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }
        .btn-primary-lg {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: #fff; border: none; border-radius: .875rem;
            padding: .875rem 2rem; font-size: 1rem; font-weight: 600;
            text-decoration: none; transition: opacity .2s, transform .15s;
            display: inline-flex; align-items: center; gap: .5rem;
        }
        .btn-primary-lg:hover { opacity: .9; transform: translateY(-2px); color: #fff; }
        .btn-outline-lg {
            background: transparent; border: 1.5px solid var(--border);
            color: rgba(255,255,255,.8); border-radius: .875rem;
            padding: .875rem 2rem; font-size: 1rem; font-weight: 500;
            text-decoration: none; transition: border-color .2s, background .2s;
            display: inline-flex; align-items: center; gap: .5rem;
        }
        .btn-outline-lg:hover { border-color: var(--primary); background: rgba(79,70,229,.1); color: #fff; }

        /* FEATURES */
        .features { padding: 5rem 1.5rem; }
        .section-label {
            text-align: center; color: var(--accent); font-weight: 600;
            font-size: .8125rem; letter-spacing: .12em; text-transform: uppercase;
            margin-bottom: .5rem;
        }
        .section-title {
            text-align: center; font-size: clamp(1.6rem, 4vw, 2.2rem);
            font-weight: 700; margin-bottom: 3rem;
        }
        .feature-grid {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 1.5rem; max-width: 1100px; margin: 0 auto;
        }
        .feature-card {
            background: var(--card-bg); border: 1px solid var(--border);
            border-radius: 1.25rem; padding: 1.75rem;
            transition: border-color .25s, transform .25s;
        }
        .feature-card:hover { border-color: rgba(79,70,229,.5); transform: translateY(-4px); }
        .feature-icon {
            width: 46px; height: 46px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: .75rem; display: flex; align-items: center;
            justify-content: center; font-size: 1.3rem; color: #fff;
            margin-bottom: 1rem;
        }
        .feature-card h3 { font-size: 1rem; font-weight: 600; margin-bottom: .5rem; }
        .feature-card p  { color: rgba(255,255,255,.55); font-size: .875rem; line-height: 1.6; margin: 0; }

        /* USER PANEL (when logged in) */
        .user-panel {
            background: var(--card-bg); border: 1px solid var(--border);
            border-radius: 1.25rem; padding: 1.5rem 2rem;
            display: flex; align-items: center; gap: 1.25rem;
            max-width: 560px; margin: 0 auto;
        }
        .user-avatar {
            width: 52px; height: 52px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 50%; display: flex; align-items: center;
            justify-content: center; font-size: 1.4rem; flex-shrink: 0;
        }
        .user-info { flex: 1; }
        .user-info .name   { font-weight: 600; font-size: 1rem; }
        .user-info .role   { font-size: .8rem; color: var(--accent); font-weight: 500; }
        .user-info .status { font-size: .78rem; color: rgba(255,255,255,.45); }

        /* FOOTER */
        footer {
            border-top: 1px solid var(--border);
            padding: 1.5rem 2rem; text-align: center;
            color: rgba(255,255,255,.35); font-size: .8125rem;
        }
    </style>
</head>
<body>

<!-- ── Navigation ─────────────────────────────────────────────────── -->
<nav>
    <a href="${pageContext.request.contextPath}/" class="nav-brand">
        <span class="logo-icon"><i class="bi bi-car-front-fill"></i></span>
        CarRental
    </a>
    <div class="nav-actions">
        <c:choose>
            <c:when test="${not empty sessionScope.loggedInUser}">
                <%-- User is logged in: show dashboard link and logout --%>
                <a href="${pageContext.request.contextPath}/<c:choose>
                    <c:when test='${sessionScope.loggedInUser.role == "ADMIN"}'>admin/dashboard</c:when>
                    <c:when test='${sessionScope.loggedInUser.role == "STAFF"}'>staff/dashboard</c:when>
                    <c:when test='${sessionScope.loggedInUser.role == "CAR_OWNER"}'>owner/dashboard</c:when>
                    <c:otherwise>renter/dashboard</c:otherwise>
                </c:choose>" class="btn-ghost">
                    <i class="bi bi-grid me-1"></i>Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="btn-ghost">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login"    class="btn-ghost">Sign In</a>
                <a href="${pageContext.request.contextPath}/register" class="btn-cta">Get Started</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<!-- ── Hero Section ──────────────────────────────────────────────── -->
<section class="hero">
    <div>
        <div class="hero-badge"><i class="bi bi-stars"></i> Self-Drive Car Rental Platform</div>
        <h1>Drive on<br>Your Own Terms</h1>
        <p>Rent from verified owners across Vietnam. Flexible pick-up, transparent pricing, and fully insured trips.</p>

        <c:choose>
            <c:when test="${not empty sessionScope.loggedInUser}">
                <%-- Logged-in view: show welcome panel --%>
                <div class="user-panel">
                    <div class="user-avatar"><i class="bi bi-person-fill"></i></div>
                    <div class="user-info">
                        <div class="name">Welcome, ${sessionScope.loggedInUser.fullName}!</div>
                        <div class="role"><i class="bi bi-shield-check me-1"></i>${sessionScope.loggedInUser.role}</div>
                        <div class="status">Account: ${sessionScope.loggedInUser.status}</div>
                    </div>
                    <a href="${pageContext.request.contextPath}/<c:choose>
                        <c:when test='${sessionScope.loggedInUser.role == "ADMIN"}'>admin/dashboard</c:when>
                        <c:when test='${sessionScope.loggedInUser.role == "STAFF"}'>staff/dashboard</c:when>
                        <c:when test='${sessionScope.loggedInUser.role == "CAR_OWNER"}'>owner/dashboard</c:when>
                        <c:otherwise>renter/dashboard</c:otherwise>
                    </c:choose>" class="btn-primary-lg">
                        <i class="bi bi-grid-3x3-gap"></i> My Dashboard
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <%-- Guest view: call-to-action buttons --%>
                <div class="hero-actions">
                    <a href="${pageContext.request.contextPath}/register" class="btn-primary-lg">
                        <i class="bi bi-person-plus"></i> Start for Free
                    </a>
                    <a href="${pageContext.request.contextPath}/login" class="btn-outline-lg">
                        <i class="bi bi-box-arrow-in-right"></i> Sign In
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- ── Features Section ──────────────────────────────────────────── -->
<section class="features">
    <p class="section-label">Why CarRental?</p>
    <h2 class="section-title">Everything you need to hit the road</h2>
    <div class="feature-grid">
        <div class="feature-card">
            <div class="feature-icon"><i class="bi bi-shield-check"></i></div>
            <h3>Verified Owners</h3>
            <p>All car owners and vehicles are verified by our support staff before listing.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon"><i class="bi bi-geo-alt"></i></div>
            <h3>Flexible Locations</h3>
            <p>Pick up and drop off at hundreds of locations nationwide.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon"><i class="bi bi-currency-exchange"></i></div>
            <h3>Transparent Pricing</h3>
            <p>No hidden fees. See the full cost breakdown before you book.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon"><i class="bi bi-headset"></i></div>
            <h3>24/7 Support</h3>
            <p>Our customer service team is available around the clock to help you.</p>
        </div>
    </div>
</section>

<!-- ── Footer ────────────────────────────────────────────────────── -->
<footer>
    &copy; 2026 CarRental Platform &mdash; SWP391 Project &mdash; All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
