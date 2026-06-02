import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { Mail, Lock, User, Eye, EyeOff, Car, AlertTriangle, ArrowRight, CheckCircle2 } from 'lucide-react';

const Register = () => {
  const { register } = useAuth();
  const navigate = useNavigate();

  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [role, setRole] = useState('RENTER'); // default role is Renter
  
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    
    // Validations
    if (password.length < 6) {
      setError('Password must be at least 6 characters long.');
      return;
    }
    if (password !== confirmPassword) {
      setError('Passwords do not match.');
      return;
    }

    setLoading(true);

    const res = await register(name, email, password, role);

    if (res.success) {
      setSuccess(true);
      setLoading(false);
      // Wait 2 seconds, then navigate to login or dashboard
      setTimeout(() => {
        navigate('/login');
      }, 2000);
    } else {
      setError(res.error || 'Registration failed. Email might already be in use.');
      setLoading(false);
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
          <h1 className="auth-title">Register</h1>
          <p className="auth-subtitle">Join us to rent or rent out vehicles</p>
        </div>

        {error && (
          <div className="alert alert-danger">
            <AlertTriangle size={18} style={{ flexShrink: 0 }} />
            <span>{error}</span>
          </div>
        )}

        {success && (
          <div className="alert alert-success">
            <CheckCircle2 size={18} style={{ flexShrink: 0 }} />
            <span>Registration successful! Redirecting to login...</span>
          </div>
        )}

        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label className="form-label" htmlFor="name-input">Full Name</label>
            <div className="form-input-container">
              <User className="form-icon-left" size={18} />
              <input 
                id="name-input"
                type="text" 
                className="form-input" 
                placeholder="John Doe"
                value={name}
                onChange={(e) => setName(e.target.value)}
                required
                disabled={loading || success}
              />
            </div>
          </div>

          <div className="form-group">
            <label className="form-label" htmlFor="email-input">Email Address</label>
            <div className="form-input-container">
              <Mail className="form-icon-left" size={18} />
              <input 
                id="email-input"
                type="email" 
                className="form-input" 
                placeholder="john@example.com"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                disabled={loading || success}
              />
            </div>
          </div>

          <div className="form-group">
            <label className="form-label" htmlFor="role-select">Account Type</label>
            <select
              id="role-select"
              className="form-select"
              value={role}
              onChange={(e) => setRole(e.target.value)}
              disabled={loading || success}
            >
              <option value="RENTER">Renter (Customer looking to rent a car)</option>
              <option value="CAR_OWNER">Car Owner (Partner listing vehicles)</option>
            </select>
          </div>

          <div className="form-group">
            <label className="form-label" htmlFor="password-input">Password</label>
            <div className="form-input-container">
              <Lock className="form-icon-left" size={18} />
              <input 
                id="password-input"
                type={showPassword ? "text" : "password"} 
                className="form-input" 
                placeholder="Min 6 characters"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                disabled={loading || success}
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

          <div className="form-group">
            <label className="form-label" htmlFor="confirm-password-input">Confirm Password</label>
            <div className="form-input-container">
              <Lock className="form-icon-left" size={18} />
              <input 
                id="confirm-password-input"
                type={showPassword ? "text" : "password"} 
                className="form-input" 
                placeholder="Confirm password"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                required
                disabled={loading || success}
              />
            </div>
          </div>

          <button 
            type="submit" 
            className="btn-primary" 
            disabled={loading || success}
            id="register-submit-btn"
          >
            {loading ? 'Creating account...' : 'Create Account'}
            {!loading && <ArrowRight size={18} />}
          </button>
        </form>

        <div className="auth-footer-link">
          Already have an account?{' '}
          <Link to="/login" className="auth-link">Log in</Link>
        </div>
      </div>
    </div>
  );
};

export default Register;
