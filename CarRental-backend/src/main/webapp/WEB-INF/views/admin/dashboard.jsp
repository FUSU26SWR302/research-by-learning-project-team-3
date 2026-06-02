<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard – Car Rental Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter',sans-serif; background:#0f0f1a; color:#fff; margin:0; min-height:100vh; }
        .layout { display:flex; min-height:100vh; }

        /* SIDEBAR */
        .sidebar {
            width:240px; flex-shrink:0;
            background:rgba(255,255,255,.04);
            border-right:1px solid rgba(255,255,255,.08);
            padding:1.5rem 1rem;
            display:flex; flex-direction:column; gap:.35rem;
        }
        .sidebar-label {
            font-size:.7rem; letter-spacing:.1em; text-transform:uppercase;
            color:rgba(255,255,255,.3); font-weight:600; padding:.75rem .75rem .25rem;
        }
        .sidebar a {
            display:flex; align-items:center; gap:.65rem;
            padding:.6rem .75rem; border-radius:.625rem;
            color:rgba(255,255,255,.6); text-decoration:none; font-size:.875rem; font-weight:500;
            transition:background .2s, color .2s;
        }
        .sidebar a:hover, .sidebar a.active {
            background:rgba(79,70,229,.18); color:#a5b4fc;
        }
        .sidebar a i { font-size:1rem; }

        /* MAIN */
        .main { flex:1; display:flex; flex-direction:column; overflow:hidden; }
        .main-content { flex:1; padding:2rem; overflow-y:auto; }
        .page-header { margin-bottom:2rem; }
        .page-header h1 { font-size:1.5rem; font-weight:700; margin-bottom:.25rem; }
        .page-header p  { color:rgba(255,255,255,.5); font-size:.875rem; margin:0; }

        /* STAT CARDS */
        .stat-grid {
            display:grid; grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
            gap:1.25rem; margin-bottom:2rem;
        }
        .stat-card {
            background:rgba(255,255,255,.05);
            border:1px solid rgba(255,255,255,.09);
            border-radius:1rem; padding:1.25rem 1.5rem;
            display:flex; align-items:center; gap:1rem;
            transition:border-color .2s, transform .2s;
        }
        .stat-card:hover { border-color:rgba(79,70,229,.4); transform:translateY(-2px); }
        .stat-icon {
            width:44px; height:44px; border-radius:.75rem;
            display:flex; align-items:center; justify-content:center;
            font-size:1.25rem; flex-shrink:0;
        }
        .stat-val { font-size:1.6rem; font-weight:700; line-height:1; }
        .stat-lbl { color:rgba(255,255,255,.5); font-size:.8rem; margin-top:.2rem; }

        /* TABLE */
        .section-card {
            background:rgba(255,255,255,.04);
            border:1px solid rgba(255,255,255,.08);
            border-radius:1rem; padding:1.5rem;
        }
        .section-card h2 { font-size:1rem; font-weight:600; margin-bottom:1.25rem; }
        table { width:100%; border-collapse:collapse; font-size:.875rem; }
        th { color:rgba(255,255,255,.4); font-weight:500; font-size:.75rem;
             text-transform:uppercase; letter-spacing:.06em;
             padding:.5rem .75rem; text-align:left; border-bottom:1px solid rgba(255,255,255,.07); }
        td { padding:.7rem .75rem; color:rgba(255,255,255,.8); border-bottom:1px solid rgba(255,255,255,.05); }
        tr:last-child td { border-bottom:none; }
        .badge-pill {
            display:inline-block; padding:.2rem .6rem; border-radius:100px;
            font-size:.72rem; font-weight:600;
        }
        .pill-active  { background:rgba(34,197,94,.15);  color:#86efac; }
        .pill-renter  { background:rgba(79,70,229,.15);  color:#a5b4fc; }
        .pill-owner   { background:rgba(6,182,212,.15);  color:#67e8f9; }
        .pill-admin   { background:rgba(239,68,68,.15);  color:#fca5a5; }
        .pill-staff   { background:rgba(251,191,36,.15); color:#fde68a; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/includes/_navbar.jsp" %>

<div class="layout">

    <!-- Sidebar -->
    <aside class="sidebar">
        <span class="sidebar-label">Main Menu</span>
        <a href="#" class="active"><i class="bi bi-grid-1x2"></i> Dashboard</a>
        <a href="#"><i class="bi bi-people"></i> Users</a>
        <a href="#"><i class="bi bi-car-front"></i> Vehicles</a>
        <a href="#"><i class="bi bi-receipt"></i> Bookings</a>

        <span class="sidebar-label">System</span>
        <a href="#"><i class="bi bi-bar-chart-line"></i> Reports</a>
        <a href="#"><i class="bi bi-gear"></i> Settings</a>
        <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </aside>

    <!-- Main content -->
    <main class="main">
        <div class="main-content">
            <div class="page-header">
                <h1>&#128274; Admin Dashboard</h1>
                <p>System overview – welcome, <strong>${sessionScope.loggedInUser.fullName}</strong></p>
            </div>

            <!-- Stats -->
            <div class="stat-grid">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(79,70,229,.2);color:#818cf8;">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div>
                        <div class="stat-val">248</div>
                        <div class="stat-lbl">Total Users</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(6,182,212,.2);color:#67e8f9;">
                        <i class="bi bi-car-front-fill"></i>
                    </div>
                    <div>
                        <div class="stat-val">83</div>
                        <div class="stat-lbl">Listed Vehicles</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(34,197,94,.2);color:#86efac;">
                        <i class="bi bi-receipt-cutoff"></i>
                    </div>
                    <div>
                        <div class="stat-val">1,042</div>
                        <div class="stat-lbl">Total Bookings</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(251,191,36,.2);color:#fde68a;">
                        <i class="bi bi-currency-dollar"></i>
                    </div>
                    <div>
                        <div class="stat-val">₫142M</div>
                        <div class="stat-lbl">Revenue (MTD)</div>
                    </div>
                </div>
            </div>

            <!-- Recent Users Table -->
            <div class="section-card">
                <h2><i class="bi bi-people me-2"></i>Recent Registered Users</h2>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Joined</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td><td>Nguyen Van A</td><td>a@email.com</td>
                            <td><span class="badge-pill pill-renter">RENTER</span></td>
                            <td><span class="badge-pill pill-active">ACTIVE</span></td>
                            <td>2026-06-01</td>
                        </tr>
                        <tr>
                            <td>2</td><td>Tran Thi B</td><td>b@email.com</td>
                            <td><span class="badge-pill pill-owner">CAR_OWNER</span></td>
                            <td><span class="badge-pill pill-active">ACTIVE</span></td>
                            <td>2026-05-30</td>
                        </tr>
                        <tr>
                            <td>3</td><td>Le Van C</td><td>c@email.com</td>
                            <td><span class="badge-pill pill-staff">STAFF</span></td>
                            <td><span class="badge-pill pill-active">ACTIVE</span></td>
                            <td>2026-05-28</td>
                        </tr>
                    </tbody>
                </table>
                <p style="color:rgba(255,255,255,.35);font-size:.78rem;margin:.75rem 0 0;">
                    ⚙️ This is a prototype stub – wire up <code>UserDAO.getAllUsers()</code> to populate dynamically.
                </p>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
