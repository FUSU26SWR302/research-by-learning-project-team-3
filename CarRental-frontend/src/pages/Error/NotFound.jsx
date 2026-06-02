import React from 'react';
import { useNavigate } from 'react-router-dom';
import { HelpCircle, ArrowLeft } from 'lucide-react';

const NotFound = () => {
  const navigate = useNavigate();

  return (
    <div className="error-layout">
      <div className="auth-background-glows">
        <div className="glow-circle glow-2" style={{ background: 'var(--primary)', opacity: 0.1 }}></div>
      </div>

      <div className="glass-panel" style={{ padding: '3.5rem', maxWidth: '520px', width: '90%', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
        <div className="error-code">404</div>
        
        <h1 className="error-title">Page Not Found</h1>
        
        <p className="error-description">
          The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.
        </p>

        <button 
          className="btn-primary" 
          onClick={() => navigate('/')}
          style={{ margin: 0, padding: '0.75rem 1.25rem' }}
        >
          <ArrowLeft size={18} /> Back to Home
        </button>
      </div>
    </div>
  );
};

export default NotFound;
