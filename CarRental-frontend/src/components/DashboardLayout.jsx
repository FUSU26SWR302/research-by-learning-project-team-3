import React from 'react';
import { Link, useLocation, Outlet, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { 
  Car, 
  User, 
  Users, 
  LogOut, 
  Settings, 
  ShieldCheck, 
  Activity, 
  FileText, 
  Clock, 
  PlusCircle, 
  DollarSign, 
  Search,
  BookOpen
} from 'lucide-react';

const DashboardLayout = () => {
  const { user, logout } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();

  const handleLogout = async () => {
    await logout();
    navigate('/login');
  };

  // Generate sidebar navigation items based on User Role
  const getNavItems = () => {
    if (!user) return [];
    
    switch (user.role) {
      case 'ADMIN':
        return [
          { label: 'Overview', path: '/admin/dashboard', icon: <Activity size={20} /> },
          { label: 'Manage Users', path: '/admin/users', icon: <Users size={20} /> },
          { label: 'System Settings', path: '/admin/settings', icon: <Settings size={20} /> }
        ];
      case 'STAFF':
        return [
          { label: 'Verification Queue', path: '/staff/dashboard', icon: <ShieldCheck size={20} /> },
          { label: 'Active Rentals', path: '/staff/rentals', icon: <Car size={20} /> },
          { label: 'Support Cases', path: '/staff/support', icon: <Clock size={20} /> }
        ];
      case 'CAR_OWNER':
        return [
          { label: 'Rentals Status', path: '/owner/dashboard', icon: <Activity size={20} /> },
          { label: 'My Vehicles', path: '/owner/cars', icon: <Car size={20} /> },
          { label: 'Add a Car', path: '/owner/add-car', icon: <PlusCircle size={20} /> },
          { label: 'Earnings Report', path: '/owner/earnings', icon: <DollarSign size={20} /> }
        ];
      case 'RENTER':
        return [
          { label: 'Browse Vehicles', path: '/renter/dashboard', icon: <Search size={20} /> },
          { label: 'My Bookings', path: '/renter/bookings', icon: <BookOpen size={20} /> },
          { label: 'Profile Details', path: '/renter/profile', icon: <User size={20} /> }
        ];
      default:
        return [];
    }
  };

  const navItems = getNavItems();

  const getRoleBadge = (role) => {
    switch (role) {
      case 'ADMIN': return <span className="role-badge badge-admin">Admin</span>;
      case 'STAFF': return <span className="role-badge badge-staff">Staff</span>;
      case 'CAR_OWNER': return <span className="role-badge badge-owner">Owner</span>;
      case 'RENTER': return <span className="role-badge badge-renter">Renter</span>;
      default: return <span className="role-badge">{role}</span>;
    }
  };

  return (
    <div className="app-layout">
      {/* Sidebar Navigation */}
      <aside className="app-sidebar">
        <div className="sidebar-brand">
          <div className="auth-logo" style={{ justifyContent: 'flex-start', fontSize: '1.5rem', marginBottom: 0 }}>
            <Car size={26} style={{ color: 'var(--primary)' }} />
            <span>DriveEase</span>
          </div>
        </div>

        <nav className="sidebar-nav">
          {navItems.map((item, idx) => {
            const isActive = location.pathname === item.path;
            return (
              <Link 
                key={idx} 
                to={item.path} 
                className={`nav-link ${isActive ? 'active' : ''}`}
              >
                {item.icon}
                <span>{item.label}</span>
              </Link>
            );
          })}
        </nav>

        {/* User Card */}
        {user && (
          <div className="sidebar-user">
            <div className="user-profile-info">
              <span className="profile-name">{user.name}</span>
              <span className="profile-role">{getRoleBadge(user.role)}</span>
            </div>
            <button className="logout-btn" onClick={handleLogout} title="Log Out">
              <LogOut size={20} />
            </button>
          </div>
        )}
      </aside>

      {/* Main Container */}
      <div className="app-main">
        <header className="app-header">
          <div>
            <h2 style={{ fontSize: '1.25rem' }}>
              Welcome back, {user?.name?.split(' ')[0] || 'User'}!
            </h2>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
            <span style={{ fontSize: '0.9rem', color: 'var(--text-secondary)' }}>
              {user?.email}
            </span>
          </div>
        </header>

        <main className="app-content">
          <Outlet />
        </main>
      </div>
    </div>
  );
};

export default DashboardLayout;
