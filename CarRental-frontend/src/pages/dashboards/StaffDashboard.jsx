import React, { useState } from 'react';
import { ShieldCheck, FileCheck, Check, X, Clock, HelpCircle } from 'lucide-react';

const INITIAL_QUEUE = [
  { id: 1, name: 'Alice Renter', type: 'Driver License', submitDate: '2026-06-01', docNo: 'DL-99210-VN', status: 'Pending' },
  { id: 2, name: 'Bob Owner', type: 'Identity Card & Insurance', submitDate: '2026-05-31', docNo: 'IC-38290-VN', status: 'Pending' },
  { id: 3, name: 'Charles Renter', type: 'Driver License', submitDate: '2026-05-31', docNo: 'DL-44810-VN', status: 'Pending' }
];

const StaffDashboard = () => {
  const [queue, setQueue] = useState(INITIAL_QUEUE);

  const handleAction = (id, newStatus) => {
    setQueue(queue.map(item => {
      if (item.id === id) {
        return { ...item, status: newStatus };
      }
      return item;
    }));
  };

  return (
    <div>
      {/* Overview stats */}
      <div className="dashboard-grid">
        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Pending Verification</span>
            <span className="stat-value">{queue.filter(q => q.status === 'Pending').length}</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(245, 158, 11, 0.1)', color: 'var(--warning)' }}>
            <Clock size={24} />
          </div>
        </div>

        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Verified Today</span>
            <span className="stat-value">28</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(16, 185, 129, 0.1)', color: 'var(--success)' }}>
            <ShieldCheck size={24} />
          </div>
        </div>

        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Total Audited Documents</span>
            <span className="stat-value">1,482</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(59, 130, 246, 0.1)', color: 'var(--primary)' }}>
            <FileCheck size={24} />
          </div>
        </div>
      </div>

      {/* Verification table */}
      <div className="glass-panel" style={{ padding: '2rem' }}>
        <div style={{ marginBottom: '1.5rem' }}>
          <h3 style={{ fontSize: '1.25rem', marginBottom: '0.25rem' }}>Document Verification Queue</h3>
          <p style={{ color: 'var(--text-secondary)', fontSize: '0.9rem' }}>Verify driver licenses, IDs, and car registration files.</p>
        </div>

        <div className="data-table-container">
          <table className="data-table">
            <thead>
              <tr>
                <th>Applicant</th>
                <th>Document Type</th>
                <th>Doc Reference</th>
                <th>Submitted Date</th>
                <th>Status</th>
                <th style={{ textAlign: 'right' }}>Actions</th>
              </tr>
            </thead>
            <tbody>
              {queue.map(item => (
                <tr key={item.id}>
                  <td style={{ fontWeight: '600' }}>{item.name}</td>
                  <td>{item.type}</td>
                  <td style={{ fontFamily: 'monospace' }}>{item.docNo}</td>
                  <td>{item.submitDate}</td>
                  <td>
                    <span style={{ 
                      color: item.status === 'Pending' ? 'var(--warning)' : 
                             item.status === 'Verified' ? 'var(--success)' : 'var(--danger)',
                      fontWeight: '600'
                    }}>
                      {item.status}
                    </span>
                  </td>
                  <td style={{ display: 'flex', gap: '0.5rem', justifyContent: 'flex-end' }}>
                    {item.status === 'Pending' ? (
                      <>
                        <button 
                          className="btn-outline"
                          onClick={() => handleAction(item.id, 'Verified')}
                          style={{ 
                            padding: '0.4rem 0.8rem', 
                            fontSize: '0.85rem',
                            borderColor: 'rgba(16, 185, 129, 0.3)',
                            color: '#a7f3d0'
                          }}
                        >
                          <Check size={14} /> Approve
                        </button>
                        <button 
                          className="btn-outline"
                          onClick={() => handleAction(item.id, 'Rejected')}
                          style={{ 
                            padding: '0.4rem 0.8rem', 
                            fontSize: '0.85rem',
                            borderColor: 'rgba(239, 68, 68, 0.3)',
                            color: '#fca5a5'
                          }}
                        >
                          <X size={14} /> Reject
                        </button>
                      </>
                    ) : (
                      <span style={{ fontSize: '0.85rem', color: 'var(--text-muted)', fontStyle: 'italic' }}>
                        Processed
                      </span>
                    )}
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

export default StaffDashboard;
