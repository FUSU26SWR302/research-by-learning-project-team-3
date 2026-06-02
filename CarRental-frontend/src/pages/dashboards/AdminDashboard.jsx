import React, { useState } from 'react';
import { Users, Car, Shield, DollarSign, Ban, CheckCircle } from 'lucide-react';

const INITIAL_USERS = [
  { id: 1, name: 'John Renter', email: 'renter@carrental.com', role: 'RENTER', status: 'Active' },
  { id: 2, name: 'Car Owner Partner', email: 'owner@carrental.com', role: 'CAR_OWNER', status: 'Active' },
  { id: 3, name: 'Support Staff User', email: 'staff@carrental.com', role: 'STAFF', status: 'Active' },
  { id: 4, name: 'Suspended User', email: 'inactive@carrental.com', role: 'RENTER', status: 'Suspended' }
];

const AdminDashboard = () => {
  const [users, setUsers] = useState(INITIAL_USERS);

  const toggleStatus = (id) => {
    setUsers(users.map(u => {
      if (u.id === id) {
        return { ...u, status: u.status === 'Active' ? 'Suspended' : 'Active' };
      }
      return u;
    }));
  };

  return (
    <div>
      {/* Overview stats */}
      <div className="dashboard-grid">
        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Total Renters</span>
            <span className="stat-value">1,248</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(59, 130, 246, 0.1)', color: 'var(--primary)' }}>
            <Users size={24} />
          </div>
        </div>

        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Active Fleet</span>
            <span className="stat-value">382</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(168, 85, 247, 0.1)', color: 'var(--secondary)' }}>
            <Car size={24} />
          </div>
        </div>

        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Staff Members</span>
            <span className="stat-value">12</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(6, 182, 212, 0.1)', color: 'var(--accent)' }}>
            <Shield size={24} />
          </div>
        </div>

        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Monthly Gross</span>
            <span className="stat-value">$42.8K</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(16, 185, 129, 0.1)', color: 'var(--success)' }}>
            <DollarSign size={24} />
          </div>
        </div>
      </div>

      {/* User Management Section */}
      <div className="glass-panel" style={{ padding: '2rem' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
          <div>
            <h3 style={{ fontSize: '1.25rem', marginBottom: '0.25rem' }}>Account Management</h3>
            <p style={{ color: 'var(--text-secondary)', fontSize: '0.9rem' }}>Approve, suspend, or manage platform roles</p>
          </div>
        </div>

        <div className="data-table-container">
          <table className="data-table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {users.map(u => (
                <tr key={u.id}>
                  <td style={{ fontWeight: '600' }}>{u.name}</td>
                  <td>{u.email}</td>
                  <td>
                    <span className={`role-badge badge-${u.role.toLowerCase()}`}>
                      {u.role}
                    </span>
                  </td>
                  <td>
                    <span style={{ 
                      color: u.status === 'Active' ? 'var(--success)' : 'var(--danger)',
                      fontWeight: '600',
                      fontSize: '0.9rem'
                    }}>
                      {u.status}
                    </span>
                  </td>
                  <td>
                    <button 
                      className="btn-outline" 
                      onClick={() => toggleStatus(u.id)}
                      style={{ 
                        padding: '0.4rem 0.8rem', 
                        fontSize: '0.85rem',
                        borderColor: u.status === 'Active' ? 'rgba(239, 68, 68, 0.3)' : 'rgba(16, 185, 129, 0.3)',
                        color: u.status === 'Active' ? '#fca5a5' : '#a7f3d0'
                      }}
                    >
                      {u.status === 'Active' ? (
                        <>
                          <Ban size={14} /> Suspend
                        </>
                      ) : (
                        <>
                          <CheckCircle size={14} /> Activate
                        </>
                      )}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default AdminDashboard;
