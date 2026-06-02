<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Owner Dashboard – Car Rental Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter',sans-serif; background:#0f0f1a; color:#fff; margin:0; min-height:100vh; }
        .layout { display:flex; min-height:100vh; }
        .sidebar {
            width:230px; flex-shrink:0; background:rgba(255,255,255,.04);
            border-right:1px solid rgba(255,255,255,.08);
            padding:1.5rem 1rem; display:flex; flex-direction:column; gap:.3rem;
        }
        .sidebar-label { font-size:.7rem; letter-spacing:.1em; text-transform:uppercase;
            color:rgba(255,255,255,.3); font-weight:600; padding:.75rem .75rem .25rem; }
        .sidebar a {
            display:flex; align-items:center; gap:.65rem; padding:.6rem .75rem;
            border-radius:.625rem; color:rgba(255,255,255,.6); text-decoration:none;
            font-size:.875rem; font-weight:500; transition:background .2s, color .2s;
        }
        .sidebar a:hover, .sidebar a.active { background:rgba(6,182,212,.15); color:#67e8f9; }
        .main { flex:1; display:flex; flex-direction:column; }
        .main-content { flex:1; padding:2rem; }
        .page-header { margin-bottom:2rem; }
        .page-header h1 { font-size:1.5rem; font-weight:700; margin-bottom:.25rem; }
        .page-header p  { color:rgba(255,255,255,.5); font-size:.875rem; margin:0; }
        .stat-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(200px,1fr)); gap:1.25rem; margin-bottom:2rem; }
        .stat-card {
            background:rgba(255,255,255,.05); border:1px solid rgba(255,255,255,.09);
            border-radius:1rem; padding:1.25rem 1.5rem;
            display:flex; align-items:center; gap:1rem;
            transition:border-color .2s, transform .2s;
        }
        .stat-card:hover { border-color:rgba(6,182,212,.4); transform:translateY(-2px); }
        .stat-icon { width:44px; height:44px; border-radius:.75rem; display:flex; align-items:center; justify-content:center; font-size:1.25rem; }
        .stat-val { font-size:1.5rem; font-weight:700; }
        .stat-lbl { color:rgba(255,255,255,.45); font-size:.8rem; margin-top:.2rem; }
        .section-card { background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.08); border-radius:1rem; padding:1.5rem; }
        .section-card h2 { font-size:1rem; font-weight:600; margin-bottom:1.25rem; }
        .vehicle-row {
            display:flex; align-items:center; gap:1rem;
            padding:.85rem 0; border-bottom:1px solid rgba(255,255,255,.06);
        }
        .vehicle-row:last-child { border-bottom:none; }
        .veh-thumb {
            width:56px; height:56px; background:rgba(6,182,212,.12);
            border-radius:.75rem; display:flex; align-items:center;
            justify-content:center; font-size:1.6rem; flex-shrink:0;
        }
        .veh-info { flex:1; }
        .veh-info .veh-name  { font-weight:600; font-size:.9rem; }
        .veh-info .veh-meta  { color:rgba(255,255,255,.45); font-size:.8rem; margin-top:.15rem; }
        .badge-pill { display:inline-block; padding:.2rem .6rem; border-radius:100px; font-size:.72rem; font-weight:600; }
        .pill-available { background:rgba(34,197,94,.15); color:#86efac; }
        .pill-rented    { background:rgba(6,182,212,.15);  color:#67e8f9; }
        .pill-pending   { background:rgba(251,191,36,.15); color:#fde68a; }
        .btn-add {
            background:linear-gradient(135deg,#4f46e5,#06b6d4); border:none; color:#fff;
            border-radius:.7rem; padding:.5rem 1.2rem; font-size:.875rem; font-weight:600;
            text-decoration:none; display:inline-flex; align-items:center; gap:.4rem;
            transition:opacity .2s;
        }
        .btn-add:hover { opacity:.88; color:#fff; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/includes/_navbar.jsp" %>

<div class="layout">
    <aside class="sidebar">
        <span class="sidebar-label">Manage</span>
        <a href="#" class="active"><i class="bi bi-grid-1x2"></i> Dashboard</a>
        <a href="#"><i class="bi bi-car-front"></i> My Vehicles</a>
        <a href="#"><i class="bi bi-calendar3"></i> Booking Requests</a>
        <a href="#"><i class="bi bi-cash-stack"></i> Earnings</a>
        <span class="sidebar-label">Settings</span>
        <a href="#"><i class="bi bi-person-circle"></i> Profile</a>
        <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </aside>

    <main class="main">
        <div class="main-content">
            <div class="page-header" style="display:flex;align-items:flex-start;justify-content:space-between;flex-wrap:wrap;gap:1rem;">
                <div>
                    <h1>&#128273; Owner Dashboard</h1>
                    <p>Manage your fleet, <strong>${sessionScope.loggedInUser.fullName}</strong></p>
                </div>
                <a href="#" class="btn-add"><i class="bi bi-plus-lg"></i> Add New Vehicle</a>
            </div>

            <div class="stat-grid">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(6,182,212,.2);color:#67e8f9;"><i class="bi bi-car-front-fill"></i></div>
                    <div><div class="stat-val">4</div><div class="stat-lbl">My Vehicles</div></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(251,191,36,.2);color:#fde68a;"><i class="bi bi-hourglass-split"></i></div>
                    <div><div class="stat-val">2</div><div class="stat-lbl">Pending Requests</div></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(34,197,94,.2);color:#86efac;"><i class="bi bi-currency-dollar"></i></div>
                    <div><div class="stat-val">₫28.4M</div><div class="stat-lbl">Total Earnings</div></div>
                </div>
            </div>

            <div class="section-card">
                <h2><i class="bi bi-car-front me-2"></i>My Fleet</h2>

                <div class="vehicle-row">
                    <div class="veh-thumb">&#128664;</div>
                    <div class="veh-info">
                        <div class="veh-name">Toyota Camry 2023</div>
                        <div class="veh-meta">Hanoi &nbsp;·&nbsp; ₫900,000 / day</div>
                    </div>
                    <span class="badge-pill pill-rented">Currently Rented</span>
                </div>

                <div class="vehicle-row">
                    <div class="veh-thumb">&#128666;</div>
                    <div class="veh-info">
                        <div class="veh-name">Ford Ranger 2022</div>
                        <div class="veh-meta">HCM City &nbsp;·&nbsp; ₫1,100,000 / day</div>
                    </div>
                    <span class="badge-pill pill-available">Available</span>
                </div>

                <div class="vehicle-row">
                    <div class="veh-thumb">&#128652;</div>
                    <div class="veh-info">
                        <div class="veh-name">Hyundai Santa Fe 2023</div>
                        <div class="veh-meta">Da Nang &nbsp;·&nbsp; ₫1,200,000 / day</div>
                    </div>
                    <span class="badge-pill pill-pending">Pending Approval</span>
                </div>

                <p style="color:rgba(255,255,255,.35);font-size:.78rem;margin:1rem 0 0;">
                    ⚙️ Prototype stub – wire up <code>VehicleDAO.getVehiclesByOwner(userId)</code> to populate.
                </p>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
