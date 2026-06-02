<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Renter Dashboard – Car Rental Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter',sans-serif; background:#0f0f1a; color:#fff; margin:0; min-height:100vh; }
        .layout { display:flex; min-height:100vh; }
        .sidebar {
            width:230px; flex-shrink:0;
            background:rgba(255,255,255,.04); border-right:1px solid rgba(255,255,255,.08);
            padding:1.5rem 1rem; display:flex; flex-direction:column; gap:.3rem;
        }
        .sidebar-label { font-size:.7rem; letter-spacing:.1em; text-transform:uppercase;
            color:rgba(255,255,255,.3); font-weight:600; padding:.75rem .75rem .25rem; }
        .sidebar a {
            display:flex; align-items:center; gap:.65rem; padding:.6rem .75rem;
            border-radius:.625rem; color:rgba(255,255,255,.6); text-decoration:none;
            font-size:.875rem; font-weight:500; transition:background .2s, color .2s;
        }
        .sidebar a:hover, .sidebar a.active { background:rgba(79,70,229,.18); color:#a5b4fc; }
        .main { flex:1; display:flex; flex-direction:column; }
        .main-content { flex:1; padding:2rem; }
        .page-header { margin-bottom:2rem; }
        .page-header h1 { font-size:1.5rem; font-weight:700; margin-bottom:.25rem; }
        .page-header p  { color:rgba(255,255,255,.5); font-size:.875rem; margin:0; }
        .card-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:1.25rem; margin-bottom:2rem; }
        .info-card {
            background:rgba(255,255,255,.05); border:1px solid rgba(255,255,255,.09);
            border-radius:1rem; padding:1.5rem; transition:border-color .2s, transform .2s;
        }
        .info-card:hover { border-color:rgba(79,70,229,.4); transform:translateY(-2px); }
        .info-card .ic-icon {
            width:42px; height:42px; border-radius:.7rem;
            display:flex; align-items:center; justify-content:center; font-size:1.25rem; margin-bottom:.75rem;
        }
        .info-card .ic-val { font-size:1.5rem; font-weight:700; }
        .info-card .ic-lbl { color:rgba(255,255,255,.45); font-size:.8rem; margin-top:.2rem; }
        .section-card { background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.08); border-radius:1rem; padding:1.5rem; }
        .section-card h2 { font-size:1rem; font-weight:600; margin-bottom:1.25rem; }
        .trip-item {
            display:flex; align-items:center; gap:1rem;
            padding:.85rem 0; border-bottom:1px solid rgba(255,255,255,.06);
        }
        .trip-item:last-child { border-bottom:none; }
        .trip-thumb {
            width:56px; height:56px; background:rgba(79,70,229,.15);
            border-radius:.75rem; display:flex; align-items:center;
            justify-content:center; font-size:1.5rem; flex-shrink:0;
        }
        .trip-info { flex:1; }
        .trip-info .car-name  { font-weight:600; font-size:.9rem; }
        .trip-info .trip-date { color:rgba(255,255,255,.45); font-size:.8rem; margin-top:.15rem; }
        .badge-pill { display:inline-block; padding:.2rem .6rem; border-radius:100px; font-size:.72rem; font-weight:600; }
        .pill-upcoming  { background:rgba(79,70,229,.15);  color:#a5b4fc; }
        .pill-completed { background:rgba(34,197,94,.15);  color:#86efac; }
        .pill-cancelled { background:rgba(239,68,68,.15);  color:#fca5a5; }
        .btn-book {
            background:linear-gradient(135deg,#4f46e5,#06b6d4); border:none; color:#fff;
            border-radius:.7rem; padding:.5rem 1.2rem; font-size:.875rem; font-weight:600;
            text-decoration:none; transition:opacity .2s;
        }
        .btn-book:hover { opacity:.88; color:#fff; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/includes/_navbar.jsp" %>

<div class="layout">
    <aside class="sidebar">
        <span class="sidebar-label">My Account</span>
        <a href="#" class="active"><i class="bi bi-grid-1x2"></i> Dashboard</a>
        <a href="#"><i class="bi bi-search"></i> Find a Car</a>
        <a href="#"><i class="bi bi-calendar-check"></i> My Bookings</a>
        <a href="#"><i class="bi bi-star"></i> Reviews</a>
        <span class="sidebar-label">Settings</span>
        <a href="#"><i class="bi bi-person-circle"></i> Profile</a>
        <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </aside>

    <main class="main">
        <div class="main-content">
            <div class="page-header">
                <h1>&#128663; My Dashboard</h1>
                <p>Welcome back, <strong>${sessionScope.loggedInUser.fullName}</strong> – ready for your next trip?</p>
            </div>

            <div class="card-grid">
                <div class="info-card">
                    <div class="ic-icon" style="background:rgba(79,70,229,.2);color:#818cf8;">
                        <i class="bi bi-calendar-check"></i>
                    </div>
                    <div class="ic-val">3</div>
                    <div class="ic-lbl">Total Bookings</div>
                </div>
                <div class="info-card">
                    <div class="ic-icon" style="background:rgba(6,182,212,.2);color:#67e8f9;">
                        <i class="bi bi-arrow-clockwise"></i>
                    </div>
                    <div class="ic-val">1</div>
                    <div class="ic-lbl">Upcoming Trips</div>
                </div>
                <div class="info-card">
                    <div class="ic-icon" style="background:rgba(34,197,94,.2);color:#86efac;">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <div class="ic-val">2</div>
                    <div class="ic-lbl">Completed Trips</div>
                </div>
            </div>

            <div class="section-card">
                <h2><i class="bi bi-clock-history me-2"></i>Recent Trips</h2>

                <div class="trip-item">
                    <div class="trip-thumb">&#128664;</div>
                    <div class="trip-info">
                        <div class="car-name">Toyota Camry 2023</div>
                        <div class="trip-date">Jun 10 – Jun 13, 2026 &nbsp;·&nbsp; Hanoi</div>
                    </div>
                    <span class="badge-pill pill-upcoming">Upcoming</span>
                </div>

                <div class="trip-item">
                    <div class="trip-thumb">&#128665;</div>
                    <div class="trip-info">
                        <div class="car-name">Honda CR-V 2022</div>
                        <div class="trip-date">May 15 – May 18, 2026 &nbsp;·&nbsp; HCM City</div>
                    </div>
                    <span class="badge-pill pill-completed">Completed</span>
                </div>

                <div class="trip-item">
                    <div class="trip-thumb">&#128663;</div>
                    <div class="trip-info">
                        <div class="car-name">Mazda CX-5 2023</div>
                        <div class="trip-date">Apr 02 – Apr 04, 2026 &nbsp;·&nbsp; Da Nang</div>
                    </div>
                    <span class="badge-pill pill-completed">Completed</span>
                </div>

                <p style="color:rgba(255,255,255,.35);font-size:.78rem;margin:1rem 0 0;">
                    ⚙️ Prototype stub – wire up <code>BookingDAO.getBookingsByUser(userId)</code> to populate.
                </p>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
