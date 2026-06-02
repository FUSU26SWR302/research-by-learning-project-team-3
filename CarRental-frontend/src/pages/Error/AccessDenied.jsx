import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import { ShieldAlert, ArrowLeft, LogOut } from 'lucide-react';

const AccessDenied = () => {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = async () => {
    await logout();
    navigate('/login');
  };

  const getDashboardPath = () => {
    if (!user) return '/login';
    switch (user.role) {
      case 'ADMIN': return '/admin/dashboard';
      case 'STAFF': return '/staff/dashboard';
      case 'CAR_OWNER': return '/owner/dashboard';
      case 'RENTER': return '/renter/dashboard';
      default: return '/';
    }
  };

  return (
    <div className="error-layout">
      <div className="auth-background-glows">
        <div className="glow-circle glow-1" style={{ background: 'var(--danger)', opacity: 0.1 }}></div>
      </div>

      <div className="glass-panel" style={{ padding: '3.5rem', maxWidth: '520px', width: '90%', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
        <div style={{ color: 'var(--danger)', marginBottom: '1.5rem', display: 'flex', justifyContent: 'center' }}>
          <ShieldAlert size={64} />
        </div>
        
        <h1 className="error-title" style={{ fontSize: '2rem', marginBottom: '1rem' }}>Access Denied</h1>
        
        <p className="error-description" style={{ marginBottom: '2rem', fontSize: '0.95rem' }}>
          You do not have permission to view this resource. 
          {user && (
            <span>
              {' '}Your current account role is <strong style={{ color: 'var(--accent)' }}>{user.role}</strong>, 
              which lacks access to this page.
            </span>
          )}
        </p>

        <div className="action-buttons">
          <button 
            className="btn-primary" 
            onClick={() => navigate(getDashboardPath())}
            style={{ margin: 0, padding: '0.75rem 1.25rem' }}
          >
            <ArrowLeft size={18} /> Back to Dashboard
          </button>
          <button 
            className="btn-outline" 
            onClick={handleLogout}
            style={{ padding: '0.75rem 1.25rem' }}
          >
            <LogOut size={18} /> Switch Account
          </button>
        </div>
      </div>
    </div>
  );
};

export default AccessDenied;
