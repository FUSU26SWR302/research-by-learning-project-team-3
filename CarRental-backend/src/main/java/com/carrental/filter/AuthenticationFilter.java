package com.carrental.filter;

import com.carrental.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

/**
 * AuthenticationFilter – Role-Based Access Control (RBAC) for protected routes.
 *
 * ---------------------------------------------------------------
 * How Session-Based Role Routing Works
 * ---------------------------------------------------------------
 *
 * 1. STORAGE
 *    After a successful login, LoginServlet stores the authenticated
 *    User object in the HTTP Session:
 *
 *       session.setAttribute("loggedInUser", user);
 *
 * 2. INTERCEPTION
 *    This filter intercepts every request to the protected URL patterns
 *    declared in web.xml:
 *       /admin/*  /renter/*  /owner/*  /staff/*
 *
 * 3. AUTHENTICATION CHECK
 *    The filter first checks whether the session contains the
 *    "loggedInUser" attribute.  If it is missing the user is not
 *    logged in (Guest) → redirect to /login.
 *
 * 4. AUTHORISATION CHECK
 *    The filter then checks whether the user's role permits access to
 *    the requested URL prefix using the ROLE_TO_PATH map below.
 *    Mismatch → HTTP 403 Forbidden (or redirect to /access-denied).
 *
 * 5. PASS-THROUGH
 *    If both checks pass, chain.doFilter() is called and the request
 *    continues to the target Servlet / JSP.
 *
 * ---------------------------------------------------------------
 * Role ↔ URL-prefix mapping
 * ---------------------------------------------------------------
 *   ADMIN     → /admin
 *   STAFF     → /staff
 *   CAR_OWNER → /owner
 *   RENTER    → /renter
 *
 * A ADMIN user may also access /staff, /owner, /renter if needed.
 * Adjust the ADMIN_FULL_ACCESS flag below.
 * ---------------------------------------------------------------
 */
@WebFilter(urlPatterns = {"/admin/*", "/renter/*", "/owner/*", "/staff/*"})
public class AuthenticationFilter implements Filter {

    /**
     * Maps each URL prefix to the single role allowed to access it.
     * The key is the prefix that appears after the context path.
     */
    private static final Map<String, String> PATH_ROLE_MAP = Map.of(
        "/admin",  User.ROLE_ADMIN,
        "/staff",  User.ROLE_STAFF,
        "/owner",  User.ROLE_CAR_OWNER,
        "/renter", User.ROLE_RENTER
    );

    /**
     * When true, ADMIN users bypass path-role checks and can access
     * every protected route (useful for super-admin scenarios).
     */
    private static final boolean ADMIN_FULL_ACCESS = true;

    // ---------------------------------------------------------------
    // Filter lifecycle
    // ---------------------------------------------------------------

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialisation needed
    }

    @Override
    public void destroy() {
        // No cleanup needed
    }

    // ---------------------------------------------------------------
    // Core filter logic
    // ---------------------------------------------------------------

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        // ── Step 1: Retrieve session without creating a new one ─────────────
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null)
                ? (User) session.getAttribute("loggedInUser")
                : null;

        // ── Step 2: Authentication – must be logged in ──────────────────────
        if (loggedInUser == null) {
            // Not authenticated → redirect to login, preserving the original URL
            String loginUrl = request.getContextPath() + "/login?redirect=" +
                              encodeUrl(request.getRequestURI());
            response.sendRedirect(loginUrl);
            return;
        }

        // ── Step 3: Account status – must not be banned / inactive ──────────
        if (!loggedInUser.isActive()) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login?error=account_disabled");
            return;
        }

        // ── Step 4: Authorisation – role must match the URL prefix ──────────
        if (ADMIN_FULL_ACCESS && User.ROLE_ADMIN.equals(loggedInUser.getRole())) {
            // Admin bypasses all path-role checks
            chain.doFilter(request, response);
            return;
        }

        String contextPath  = request.getContextPath();   // e.g. "/carrental"
        String requestUri   = request.getRequestURI();    // e.g. "/carrental/renter/dashboard"
        String pathAfterCtx = requestUri.substring(contextPath.length()); // "/renter/dashboard"

        String requiredRole = resolveRequiredRole(pathAfterCtx);

        if (requiredRole == null || !requiredRole.equals(loggedInUser.getRole())) {
            // Authenticated but wrong role → 403 Access Denied
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                "You do not have permission to access this page.");
            return;
        }

        // ── Step 5: All checks passed – continue the filter chain ───────────
        chain.doFilter(request, response);
    }

    // ---------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------

    /**
     * Returns the role required for the given path, or {@code null}
     * if no matching prefix is found.
     */
    private String resolveRequiredRole(String path) {
        for (Map.Entry<String, String> entry : PATH_ROLE_MAP.entrySet()) {
            if (path.startsWith(entry.getKey())) {
                return entry.getValue();
            }
        }
        return null;
    }

    /** Simple URL encoding for the redirect parameter. */
    private String encodeUrl(String url) {
        try {
            return java.net.URLEncoder.encode(url, "UTF-8");
        } catch (java.io.UnsupportedEncodingException e) {
            return url;
        }
    }
}
