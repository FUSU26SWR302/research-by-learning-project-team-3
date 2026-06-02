<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
  _navbar.jsp – Shared navigation bar included by all dashboard views.

  Usage:
    <%@ include file="/WEB-INF/includes/_navbar.jsp" %>

  Reads the logged-in user from the session:
    ${sessionScope.loggedInUser}
--%>
<style>
    .cr-navbar {
        position: sticky; top: 0; z-index: 100;
        background: rgba(15,15,26,.85);
        backdrop-filter: blur(16px); -webkit-backdrop-filter: blur(16px);
        border-bottom: 1px solid rgba(255,255,255,.09);
        display: flex; align-items: center; justify-content: space-between;
        padding: .8rem 1.75rem;
    }
    .cr-brand {
        display: flex; align-items: center; gap: .55rem;
        font-size: 1.05rem; font-weight: 700; color: #fff; text-decoration: none;
    }
    .cr-brand .cr-logo {
        width: 34px; height: 34px;
        background: linear-gradient(135deg, #4f46e5, #06b6d4);
        border-radius: 9px; display: flex; align-items: center;
        justify-content: center; font-size: 1rem;
    }
    .cr-nav-right { display: flex; align-items: center; gap: .75rem; }
    .cr-user-chip {
        display: flex; align-items: center; gap: .5rem;
        background: rgba(255,255,255,.06); border: 1px solid rgba(255,255,255,.1);
        border-radius: 100px; padding: .3rem .85rem .3rem .4rem;
    }
    .cr-avatar {
        width: 30px; height: 30px;
        background: linear-gradient(135deg, #4f46e5, #06b6d4);
        border-radius: 50%; display: flex; align-items: center;
        justify-content: center; font-size: .85rem; color: #fff;
    }
    .cr-user-name  { color: rgba(255,255,255,.85); font-size: .8125rem; font-weight: 500; }
    .cr-role-badge {
        font-size: .7rem; font-weight: 600; padding: .15rem .5rem;
        border-radius: 100px; letter-spacing: .03em;
    }
    .badge-admin   { background: rgba(239,68,68,.2);  color: #fca5a5; }
    .badge-renter  { background: rgba(79,70,229,.2);  color: #a5b4fc; }
    .badge-owner   { background: rgba(6,182,212,.2);  color: #67e8f9; }
    .badge-staff   { background: rgba(251,191,36,.2); color: #fde68a; }
    .cr-logout-btn {
        background: rgba(239,68,68,.1); border: 1px solid rgba(239,68,68,.3);
        color: #fca5a5; border-radius: .6rem;
        padding: .35rem .85rem; font-size: .8125rem; font-weight: 500;
        text-decoration: none; transition: background .2s;
    }
    .cr-logout-btn:hover { background: rgba(239,68,68,.2); color: #fca5a5; }
</style>

<nav class="cr-navbar">
    <a href="${pageContext.request.contextPath}/" class="cr-brand">
        <span class="cr-logo"><i class="bi bi-car-front-fill"></i></span>
        CarRental
    </a>

    <div class="cr-nav-right">
        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="cr-user-chip">
                <div class="cr-avatar"><i class="bi bi-person-fill"></i></div>
                <span class="cr-user-name">${sessionScope.loggedInUser.fullName}</span>
                <c:choose>
                    <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                        <span class="cr-role-badge badge-admin">Admin</span>
                    </c:when>
                    <c:when test="${sessionScope.loggedInUser.role == 'STAFF'}">
                        <span class="cr-role-badge badge-staff">Staff</span>
                    </c:when>
                    <c:when test="${sessionScope.loggedInUser.role == 'CAR_OWNER'}">
                        <span class="cr-role-badge badge-owner">Car Owner</span>
                    </c:when>
                    <c:otherwise>
                        <span class="cr-role-badge badge-renter">Renter</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        <a href="${pageContext.request.contextPath}/logout" class="cr-logout-btn">
            <i class="bi bi-box-arrow-right me-1"></i>Logout
        </a>
    </div>
</nav>
