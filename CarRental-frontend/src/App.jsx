import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider, useAuth } from './context/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';
import DashboardLayout from './components/DashboardLayout';

// Pages
import Login from './pages/Login';
import Register from './pages/Register';
import AdminDashboard from './pages/dashboards/AdminDashboard';
import StaffDashboard from './pages/dashboards/StaffDashboard';
import OwnerDashboard from './pages/dashboards/OwnerDashboard';
import RenterDashboard from './pages/dashboards/RenterDashboard';
import AccessDenied from './pages/Error/AccessDenied';
import NotFound from './pages/Error/NotFound';

// Helper component to redirect root "/" to the appropriate dashboard
const RootRedirect = () => {
  const { user } = useAuth();
  
  if (!user) {
    return <Navigate to="/login" replace />;
  }
  
  switch (user.role) {
    case 'ADMIN': return <Navigate to="/admin/dashboard" replace />;
    case 'STAFF': return <Navigate to="/staff/dashboard" replace />;
    case 'CAR_OWNER': return <Navigate to="/owner/dashboard" replace />;
    case 'RENTER': return <Navigate to="/renter/dashboard" replace />;
    default: return <Navigate to="/login" replace />;
  }
};

function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          {/* Public routes */}
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/access-denied" element={<AccessDenied />} />

          {/* Protected dashboard routes */}
          <Route element={<ProtectedRoute><DashboardLayout /></ProtectedRoute>}>
            
            {/* Admin-only paths */}
            <Route 
              path="/admin/dashboard" 
              element={
                <ProtectedRoute allowedRoles={['ADMIN']}>
                  <AdminDashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/admin/users" 
              element={
                <ProtectedRoute allowedRoles={['ADMIN']}>
                  <AdminDashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/admin/settings" 
              element={
                <ProtectedRoute allowedRoles={['ADMIN']}>
                  <div className="glass-panel" style={{ padding: '2rem' }}>
                    <h3>System Settings</h3>
                    <p style={{ color: 'var(--text-secondary)', marginTop: '1rem' }}>Global configuration details are managed here.</p>
                  </div>
                </ProtectedRoute>
              } 
            />

            {/* Staff-only paths */}
            <Route 
              path="/staff/dashboard" 
              element={
                <ProtectedRoute allowedRoles={['STAFF']}>
                  <StaffDashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/staff/rentals" 
              element={
                <ProtectedRoute allowedRoles={['STAFF']}>
                  <StaffDashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/staff/support" 
              element={
                <ProtectedRoute allowedRoles={['STAFF']}>
                  <div className="glass-panel" style={{ padding: '2rem' }}>
                    <h3>Customer Support Tickets</h3>
                    <p style={{ color: 'var(--text-secondary)', marginTop: '1rem' }}>No open tickets today.</p>
                  </div>
                </ProtectedRoute>
              } 
            />

            {/* Owner-only paths */}
            <Route 
              path="/owner/dashboard" 
              element={
                <ProtectedRoute allowedRoles={['CAR_OWNER']}>
                  <OwnerDashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/owner/cars" 
              element={
                <ProtectedRoute allowedRoles={['CAR_OWNER']}>
                  <OwnerDashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/owner/add-car" 
              element={
                <ProtectedRoute allowedRoles={['CAR_OWNER']}>
                  <OwnerDashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/owner/earnings" 
              element={
                <ProtectedRoute allowedRoles={['CAR_OWNER']}>
                  <OwnerDashboard />
                </ProtectedRoute>
              } 
            />

            {/* Renter-only paths */}
            <Route 
              path="/renter/dashboard" 
              element={
                <ProtectedRoute allowedRoles={['RENTER']}>
                  <RenterDashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/renter/bookings" 
              element={
                <ProtectedRoute allowedRoles={['RENTER']}>
                  <RenterDashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/renter/profile" 
              element={
                <ProtectedRoute allowedRoles={['RENTER']}>
                  <div className="glass-panel" style={{ padding: '2rem' }}>
                    <h3>Profile Information</h3>
                    <p style={{ color: 'var(--text-secondary)', marginTop: '1rem' }}>Your driver license is verified.</p>
                  </div>
                </ProtectedRoute>
              } 
            />

          </Route>

          {/* Root redirect */}
          <Route path="/" element={<RootRedirect />} />

          {/* Fallback routes */}
          <Route path="*" element={<NotFound />} />
        </Routes>
      </Router>
    </AuthProvider>
  );
}

export default App;
