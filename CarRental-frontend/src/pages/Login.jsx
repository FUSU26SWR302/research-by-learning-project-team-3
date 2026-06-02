import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { Mail, Lock, Eye, EyeOff, Car, AlertTriangle, ArrowRight } from 'lucide-react';

const Login = () => {
  const { login } = useAuth();
  const navigate = useNavigate();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [infoMessage, setInfoMessage] = useState(
    'For evaluation, use: admin@carrental.com / admin123 or renter@carrental.com / renter123'
  );

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    const res = await login(email, password);
    
    if (res.success) {
      // Clear alert messages
      setInfoMessage('');
      
      // Fetch session object to determine route
      const savedUser = localStorage.getItem('car_rental_user');
      if (savedUser) {
        const u = JSON.parse(savedUser);
        const route = roleToRedirectPath(u.role);
        navigate(route, { replace: true });
      } else {
        navigate('/', { replace: true });
      }
    } else {
      setError(res.error || 'Login failed. Please try again.');
      setLoading(false);
    }
  };

  const roleToRedirectPath = (role) => {
    switch (role) {
      case 'ADMIN': return '/admin/dashboard';
      case 'STAFF': return '/staff/dashboard';
      case 'CAR_OWNER': return '/owner/dashboard';
      case 'RENTER': return '/renter/dashboard';
      default: return '/';
    }
  };

  return (
    <div className="auth-container">
      {/* Dynamic Background Glows */}
      <div className="auth-background-glows">
        <div className="glow-circle glow-1"></div>
        <div className="glow-circle glow-2"></div>
      </div>

      <div className="auth-card glass-panel">
        <div className="auth-header">
          <div className="auth-logo">
            <Car size={32} />
            <span>DriveEase</span>
          </div>
          <h1 className="auth-title">Log In</h1>
          <p className="auth-subtitle">Rent a car or manage your fleet in minutes</p>
        </div>

        {error && (
          <div className="alert alert-danger">
            <AlertTriangle size={18} style={{ flexShrink: 0 }} />
            <span>{error}</span>
          </div>
        )}

        {infoMessage && !error && (
          <div className="alert" style={{ background: 'rgba(59, 130, 246, 0.1)', border: '1px solid rgba(59, 130, 246, 0.2)', color: '#93c5fd' }}>
            <span>{infoMessage}</span>
          </div>
        )}

        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label className="form-label" htmlFor="email-input">Email Address</label>
            <div className="form-input-container">
              <Mail className="form-icon-left" size={18} />
              <input 
                id="email-input"
                type="email" 
                className="form-input" 
                placeholder="you@example.com"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                disabled={loading}
              />
            </div>
          </div>

          <div className="form-group">
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
              <label className="form-label" htmlFor="password-input" style={{ marginBottom: 0 }}>Password</label>
              <a href="#forgot" className="auth-link" style={{ fontSize: '0.85rem' }}>Forgot password?</a>
            </div>
            <div className="form-input-container">
              <Lock className="form-icon-left" size={18} />
              <input 
                id="password-input"
                type={showPassword ? "text" : "password"} 
                className="form-input" 
                placeholder="••••••••"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                disabled={loading}
              />
              <button 
                type="button" 
                className="form-icon-right" 
                onClick={() => setShowPassword(!showPassword)}
                tabIndex="-1"
              >
                {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
              </button>
            </div>
          </div>

          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '1rem' }}>
            <label className="form-checkbox-container">
              <input type="checkbox" className="form-checkbox" />
              <span>Keep me signed in</span>
            </label>
          </div>

          <button 
            type="submit" 
            className="btn-primary" 
            disabled={loading}
            id="login-submit-btn"
          >
            {loading ? 'Authenticating...' : 'Sign In'}
            {!loading && <ArrowRight size={18} />}
          </button>
        </form>

        <div className="auth-footer-link">
          Don't have an account?{' '}
          <Link to="/register" className="auth-link">Sign up</Link>
        </div>
      </div>
    </div>
  );
};

export default Login;
