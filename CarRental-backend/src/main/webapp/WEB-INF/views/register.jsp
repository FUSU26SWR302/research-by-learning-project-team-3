<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Create your Car Rental account. Sign up as a renter or car owner.">
    <title>Create Account – Car Rental Platform</title>

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
            --primary:     #4f46e5;   /* Indigo */
            --primary-dark:#3730a3;
            --accent:      #06b6d4;   /* Cyan */
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
                radial-gradient(ellipse at 20% 50%, rgba(79,70,229,.25) 0%, transparent 60%),
                radial-gradient(ellipse at 80% 20%, rgba(6,182,212,.20) 0%, transparent 55%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }

        .auth-card {
            width: 100%;
            max-width: 480px;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 1.5rem;
            padding: 2.5rem 2rem;
            box-shadow: 0 25px 60px rgba(0,0,0,.5);
            animation: fadeUp .5s ease both;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(24px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .brand-logo {
            width: 48px; height: 48px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem; color: #fff;
            margin: 0 auto 1.25rem;
        }

        h1.auth-title {
            color: #fff;
            font-size: 1.5rem;
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

        .form-control, .form-select {
            background: rgba(255,255,255,.07);
            border: 1px solid var(--border);
            color: #fff;
            border-radius: .75rem;
            padding: .65rem 1rem;
            font-size: .9rem;
            transition: border-color .2s, box-shadow .2s;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255,255,255,.10);
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79,70,229,.3);
            color: #fff;
            outline: none;
        }

        .form-control::placeholder { color: rgba(255,255,255,.3); }

        .form-select option { background: #1e1e2e; color: #fff; }

        .input-group-text {
            background: rgba(255,255,255,.07);
            border: 1px solid var(--border);
            border-right: none;
            color: rgba(255,255,255,.5);
            border-radius: .75rem 0 0 .75rem;
        }

        .input-group .form-control { border-left: none; border-radius: 0 .75rem .75rem 0; }

        .btn-primary-gradient {
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

        .btn-primary-gradient:hover { opacity: .9; transform: translateY(-1px); }
        .btn-primary-gradient:active { transform: translateY(0); }

        .role-card {
            border: 1.5px solid var(--border);
            border-radius: .875rem;
            padding: .85rem 1rem;
            cursor: pointer;
            transition: border-color .2s, background .2s;
            display: flex; align-items: center; gap: .75rem;
        }

        .role-card:hover { border-color: var(--primary); background: rgba(79,70,229,.1); }

        .role-card input[type="radio"] { accent-color: var(--primary); width: 1.1rem; height: 1.1rem; }

        .role-card .role-icon {
            width: 38px; height: 38px;
            border-radius: .5rem;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem; flex-shrink: 0;
        }

        .role-card .role-label { color: #fff; font-weight: 600; font-size: .9rem; }
        .role-card .role-desc  { color: rgba(255,255,255,.5); font-size: .78rem; }

        .alert-danger-custom {
            background: rgba(239,68,68,.12);
            border: 1px solid rgba(239,68,68,.4);
            color: #fca5a5;
            border-radius: .75rem;
            padding: .75rem 1rem;
            font-size: .875rem;
            display: flex; align-items: center; gap: .5rem;
        }

        .divider {
            border-top: 1px solid var(--border);
            margin: 1.5rem 0;
        }

        .link-subtle { color: rgba(255,255,255,.55); font-size: .875rem; text-align: center; }
        .link-subtle a { color: var(--accent); text-decoration: none; font-weight: 500; }
        .link-subtle a:hover { text-decoration: underline; }

        /* Password strength bar */
        .strength-bar {
            height: 4px;
            border-radius: 2px;
            background: rgba(255,255,255,.1);
            margin-top: .4rem;
            overflow: hidden;
        }

        .strength-fill {
            height: 100%;
            border-radius: 2px;
            width: 0;
            transition: width .3s, background .3s;
        }
    </style>
</head>
<body>

<div class="auth-card">

    <!-- Brand -->
    <div class="brand-logo"><i class="bi bi-car-front-fill"></i></div>
    <h1 class="auth-title">Create your account</h1>
    <p class="auth-subtitle">Join the Car Rental Platform today</p>

    <!-- Error Alert -->
    <c:if test="${not empty error}">
        <div class="alert-danger-custom mb-3" role="alert">
            <i class="bi bi-exclamation-circle-fill"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- Registration Form -->
    <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post"
          novalidate>

        <!-- Full Name -->
        <div class="mb-3">
            <label for="fullName" class="form-label">Full Name <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <input type="text" id="fullName" name="fullName" class="form-control"
                       placeholder="Nguyen Van A"
                       value="${not empty fullName ? fullName : ''}"
                       required maxlength="150">
            </div>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label for="email" class="form-label">Email Address <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                <input type="email" id="email" name="email" class="form-control"
                       placeholder="you@example.com"
                       value="${not empty email ? email : ''}"
                       required maxlength="255">
            </div>
        </div>

        <!-- Phone -->
        <div class="mb-3">
            <label for="phone" class="form-label">Phone Number</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                <input type="tel" id="phone" name="phone" class="form-control"
                       placeholder="0901 234 567"
                       value="${not empty phone ? phone : ''}"
                       maxlength="20">
            </div>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input type="password" id="password" name="password" class="form-control"
                       placeholder="Min. 8 characters" required minlength="8">
                <button type="button" class="input-group-text border-start-0" id="togglePwd"
                        style="cursor:pointer; border-radius:0 .75rem .75rem 0;">
                    <i class="bi bi-eye" id="eyeIcon"></i>
                </button>
            </div>
            <div class="strength-bar"><div class="strength-fill" id="strengthFill"></div></div>
            <small id="strengthLabel" class="d-block mt-1" style="font-size:.75rem; color:rgba(255,255,255,.4);"></small>
        </div>

        <!-- Confirm Password -->
        <div class="mb-3">
            <label for="confirmPassword" class="form-label">Confirm Password <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       class="form-control" placeholder="Re-enter password" required>
            </div>
            <small id="pwdMatchMsg" class="d-none mt-1" style="font-size:.75rem;"></small>
        </div>

        <!-- Role Selection -->
        <div class="mb-4">
            <label class="form-label">I want to <span class="text-danger">*</span></label>
            <div class="d-flex flex-column gap-2">

                <label class="role-card" for="roleRenter">
                    <input type="radio" id="roleRenter" name="role" value="RENTER"
                           ${(empty role || role == 'RENTER') ? 'checked' : ''}>
                    <span class="role-icon" style="background:rgba(79,70,229,.2); color:#818cf8;">
                        <i class="bi bi-car-front"></i>
                    </span>
                    <span>
                        <div class="role-label">Rent a Car</div>
                        <div class="role-desc">Browse and book vehicles from owners</div>
                    </span>
                </label>

                <label class="role-card" for="roleOwner">
                    <input type="radio" id="roleOwner" name="role" value="CAR_OWNER"
                           ${role == 'CAR_OWNER' ? 'checked' : ''}>
                    <span class="role-icon" style="background:rgba(6,182,212,.2); color:#67e8f9;">
                        <i class="bi bi-key"></i>
                    </span>
                    <span>
                        <div class="role-label">List My Car</div>
                        <div class="role-desc">Earn income by sharing your vehicle</div>
                    </span>
                </label>

            </div>
        </div>

        <!-- Hidden field to ensure role is always submitted (fallback) -->
        <input type="hidden" id="roleFallback" name="roleFallback" value="">

        <button type="submit" class="btn-primary-gradient mb-3" id="registerBtn">
            <i class="bi bi-person-plus me-2"></i>Create Account
        </button>

    </form>

    <div class="divider"></div>

    <p class="link-subtle">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login">Sign in here</a>
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

    // ── Password strength meter ─────────────────────────────────────
    const pwdInput  = document.getElementById('password');
    const fill      = document.getElementById('strengthFill');
    const label     = document.getElementById('strengthLabel');

    pwdInput.addEventListener('input', function () {
        const val = this.value;
        let score = 0;
        if (val.length >= 8)  score++;
        if (/[A-Z]/.test(val)) score++;
        if (/[0-9]/.test(val)) score++;
        if (/[^A-Za-z0-9]/.test(val)) score++;

        const levels = [
            { w: '25%', color: '#ef4444', text: 'Weak' },
            { w: '50%', color: '#f59e0b', text: 'Fair' },
            { w: '75%', color: '#3b82f6', text: 'Good' },
            { w: '100%', color: '#22c55e', text: 'Strong' },
        ];

        if (val.length === 0) {
            fill.style.width = '0'; label.textContent = '';
        } else {
            const lvl = levels[score - 1] || levels[0];
            fill.style.width    = lvl.w;
            fill.style.background = lvl.color;
            label.textContent   = lvl.text;
            label.style.color   = lvl.color;
        }
    });

    // ── Passwords match indicator ───────────────────────────────────
    const confirmInput = document.getElementById('confirmPassword');
    const matchMsg     = document.getElementById('pwdMatchMsg');

    function checkMatch() {
        if (confirmInput.value.length === 0) { matchMsg.className = 'd-none'; return; }
        if (pwdInput.value === confirmInput.value) {
            matchMsg.textContent  = '✓ Passwords match';
            matchMsg.style.color  = '#22c55e';
            matchMsg.className    = 'd-block';
        } else {
            matchMsg.textContent  = '✗ Passwords do not match';
            matchMsg.style.color  = '#ef4444';
            matchMsg.className    = 'd-block';
        }
    }

    confirmInput.addEventListener('input', checkMatch);
    pwdInput.addEventListener('input', checkMatch);

    // ── Client-side pre-submission validation ───────────────────────
    document.getElementById('registerForm').addEventListener('submit', function (e) {
        const pwd     = document.getElementById('password').value;
        const confirm = document.getElementById('confirmPassword').value;

        if (pwd !== confirm) {
            e.preventDefault();
            alert('Passwords do not match.');
            return;
        }

        if (pwd.length < 8) {
            e.preventDefault();
            alert('Password must be at least 8 characters.');
        }
    });
</script>
</body>
</html>
