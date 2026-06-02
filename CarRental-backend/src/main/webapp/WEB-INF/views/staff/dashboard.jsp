<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard – Car Rental Platform</title>
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
        .sidebar a:hover, .sidebar a.active { background:rgba(251,191,36,.12); color:#fde68a; }
        .main { flex:1; display:flex; flex-direction:column; }
        .main-content { flex:1; padding:2rem; }
        .page-header { margin-bottom:2rem; }
        .page-header h1 { font-size:1.5rem; font-weight:700; margin-bottom:.25rem; }
        .page-header p  { color:rgba(255,255,255,.5); font-size:.875rem; margin:0; }
        .stat-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(200px,1fr)); gap:1.25rem; margin-bottom:2rem; }
        .stat-card {
            background:rgba(255,255,255,.05); border:1px solid rgba(255,255,255,.09);
            border-radius:1rem; padding:1.25rem 1.5rem; display:flex; align-items:center; gap:1rem;
            transition:border-color .2s, transform .2s;
        }
        .stat-card:hover { border-color:rgba(251,191,36,.4); transform:translateY(-2px); }
        .stat-icon { width:44px; height:44px; border-radius:.75rem; display:flex; align-items:center; justify-content:center; font-size:1.25rem; }
        .stat-val { font-size:1.5rem; font-weight:700; }
        .stat-lbl { color:rgba(255,255,255,.45); font-size:.8rem; margin-top:.2rem; }
        .section-card { background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.08); border-radius:1rem; padding:1.5rem; margin-bottom:1.5rem; }
        .section-card h2 { font-size:1rem; font-weight:600; margin-bottom:1.25rem; }
        table { width:100%; border-collapse:collapse; font-size:.875rem; }
        th { color:rgba(255,255,255,.4); font-weight:500; font-size:.75rem; text-transform:uppercase;
             letter-spacing:.06em; padding:.5rem .75rem; text-align:left; border-bottom:1px solid rgba(255,255,255,.07); }
        td { padding:.7rem .75rem; color:rgba(255,255,255,.8); border-bottom:1px solid rgba(255,255,255,.05); }
        tr:last-child td { border-bottom:none; }
        .badge-pill { display:inline-block; padding:.2rem .6rem; border-radius:100px; font-size:.72rem; font-weight:600; }
        .pill-open     { background:rgba(251,191,36,.15); color:#fde68a; }
        .pill-resolved { background:rgba(34,197,94,.15);  color:#86efac; }
        .pill-pending  { background:rgba(239,68,68,.15);  color:#fca5a5; }
        .ticket-pri { font-size:.75rem; font-weight:600; }
        .pri-high   { color:#fca5a5; }
        .pri-medium { color:#fde68a; }
        .pri-low    { color:#86efac; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/includes/_navbar.jsp" %>

<div class="layout">
    <aside class="sidebar">
        <span class="sidebar-label">Support</span>
        <a href="#" class="active"><i class="bi bi-grid-1x2"></i> Dashboard</a>
        <a href="#"><i class="bi bi-chat-dots"></i> Support Tickets</a>
        <a href="#"><i class="bi bi-person-check"></i> User Verification</a>
        <a href="#"><i class="bi bi-car-front"></i> Car Verification</a>
        <span class="sidebar-label">Tools</span>
        <a href="#"><i class="bi bi-journal-text"></i> Activity Log</a>
        <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </aside>

    <main class="main">
        <div class="main-content">
            <div class="page-header">
                <h1>&#127881; Staff Dashboard</h1>
                <p>Customer Support &amp; Verification – <strong>${sessionScope.loggedInUser.fullName}</strong></p>
            </div>

            <div class="stat-grid">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(251,191,36,.2);color:#fde68a;"><i class="bi bi-chat-left-text"></i></div>
                    <div><div class="stat-val">12</div><div class="stat-lbl">Open Tickets</div></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(239,68,68,.2);color:#fca5a5;"><i class="bi bi-person-exclamation"></i></div>
                    <div><div class="stat-val">5</div><div class="stat-lbl">Pending User Verifications</div></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(34,197,94,.2);color:#86efac;"><i class="bi bi-check2-all"></i></div>
                    <div><div class="stat-val">47</div><div class="stat-lbl">Resolved Today</div></div>
                </div>
            </div>

            <!-- Support Tickets -->
            <div class="section-card">
                <h2><i class="bi bi-ticket-perforated me-2"></i>Open Support Tickets</h2>
                <table>
                    <thead>
                        <tr><th>#</th><th>Subject</th><th>User</th><th>Priority</th><th>Status</th><th>Created</th></tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>TK-051</td>
                            <td>Cannot extend rental period</td>
                            <td>Nguyen Van A</td>
                            <td><span class="ticket-pri pri-high">High</span></td>
                            <td><span class="badge-pill pill-open">Open</span></td>
                            <td>2026-06-01</td>
                        </tr>
                        <tr>
                            <td>TK-050</td>
                            <td>Vehicle condition dispute</td>
                            <td>Tran Thi B</td>
                            <td><span class="ticket-pri pri-medium">Medium</span></td>
                            <td><span class="badge-pill pill-pending">In Progress</span></td>
                            <td>2026-05-31</td>
                        </tr>
                        <tr>
                            <td>TK-049</td>
                            <td>Refund request</td>
                            <td>Le Van C</td>
                            <td><span class="ticket-pri pri-low">Low</span></td>
                            <td><span class="badge-pill pill-resolved">Resolved</span></td>
                            <td>2026-05-30</td>
                        </tr>
                    </tbody>
                </table>
                <p style="color:rgba(255,255,255,.35);font-size:.78rem;margin:.75rem 0 0;">
                    ⚙️ Prototype stub – wire up <code>TicketDAO.getOpenTickets()</code> to populate.
                </p>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
