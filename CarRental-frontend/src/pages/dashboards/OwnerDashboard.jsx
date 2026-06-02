import React, { useState } from 'react';
import { Car, DollarSign, Calendar, Plus, ToggleLeft, ToggleRight, Sparkles } from 'lucide-react';

const INITIAL_CARS = [
  { id: 1, make: 'Tesla Model 3', year: 2022, plate: '29A-882.91', price: 95, status: 'Active', bookings: 12 },
  { id: 2, make: 'Mazda CX-5', year: 2021, plate: '30E-449.12', price: 55, status: 'Active', bookings: 18 },
  { id: 3, make: 'Toyota Fortuner', year: 2020, plate: '30F-991.04', price: 70, status: 'Inactive', bookings: 6 }
];

const OwnerDashboard = () => {
  const [cars, setCars] = useState(INITIAL_CARS);
  const [newCarMake, setNewCarMake] = useState('');
  const [newCarPrice, setNewCarPrice] = useState('');
  const [newCarPlate, setNewCarPlate] = useState('');
  const [newCarYear, setNewCarYear] = useState('2023');
  const [showAddForm, setShowAddForm] = useState(false);

  const toggleCarStatus = (id) => {
    setCars(cars.map(c => {
      if (c.id === id) {
        return { ...c, status: c.status === 'Active' ? 'Inactive' : 'Active' };
      }
      return c;
    }));
  };

  const handleAddCar = (e) => {
    e.preventDefault();
    if (!newCarMake || !newCarPrice || !newCarPlate) return;

    const newCar = {
      id: Date.now(),
      make: newCarMake,
      year: parseInt(newCarYear),
      plate: newCarPlate,
      price: parseFloat(newCarPrice),
      status: 'Active',
      bookings: 0
    };

    setCars([...cars, newCar]);
    setNewCarMake('');
    setNewCarPrice('');
    setNewCarPlate('');
    setShowAddForm(false);
  };

  return (
    <div>
      {/* Metrics */}
      <div className="dashboard-grid">
        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Total Earnings</span>
            <span className="stat-value">$2,480</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(16, 185, 129, 0.1)', color: 'var(--success)' }}>
            <DollarSign size={24} />
          </div>
        </div>

        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Vehicles Listed</span>
            <span className="stat-value">{cars.length}</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(59, 130, 246, 0.1)', color: 'var(--primary)' }}>
            <Car size={24} />
          </div>
        </div>

        <div className="glass-panel stat-card">
          <div className="stat-info">
            <span className="stat-label">Active Bookings</span>
            <span className="stat-value">3</span>
          </div>
          <div className="stat-icon-wrapper" style={{ background: 'rgba(168, 85, 247, 0.1)', color: 'var(--secondary)' }}>
            <Calendar size={24} />
          </div>
        </div>
      </div>

      {/* Car management grid */}
      <div style={{ display: 'grid', gridTemplateColumns: showAddForm ? '2fr 1fr' : '1fr', gap: '2rem', alignItems: 'start' }}>
        
        {/* Vehicles list */}
        <div className="glass-panel" style={{ padding: '2rem' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
            <div>
              <h3 style={{ fontSize: '1.25rem', marginBottom: '0.25rem' }}>My Vehicles</h3>
              <p style={{ color: 'var(--text-secondary)', fontSize: '0.9rem' }}>Manage availability and pricing</p>
            </div>
            {!showAddForm && (
              <button className="btn-primary" onClick={() => setShowAddForm(true)} style={{ margin: 0, padding: '0.5rem 1rem', fontSize: '0.9rem' }}>
                <Plus size={16} /> Add Vehicle
              </button>
            )}
          </div>

          <div className="data-table-container">
            <table className="data-table">
              <thead>
                <tr>
                  <th>Vehicle</th>
                  <th>License Plate</th>
                  <th>Daily Price</th>
                  <th>Bookings</th>
                  <th>Status</th>
                  <th style={{ textAlign: 'right' }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {cars.map(c => (
                  <tr key={c.id}>
                    <td>
                      <div style={{ fontWeight: '600' }}>{c.make}</div>
                      <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>Year {c.year}</div>
                    </td>
                    <td style={{ fontFamily: 'monospace' }}>{c.plate}</td>
                    <td style={{ fontWeight: '600', color: 'var(--accent)' }}>${c.price}/day</td>
                    <td>{c.bookings} rentals</td>
                    <td>
                      <span style={{ 
                        color: c.status === 'Active' ? 'var(--success)' : 'var(--text-muted)',
                        fontWeight: '600'
                      }}>
                        {c.status}
                      </span>
                    </td>
                    <td style={{ textAlign: 'right' }}>
                      <button 
                        onClick={() => toggleCarStatus(c.id)} 
                        style={{ background: 'none', border: 'none', cursor: 'pointer', color: c.status === 'Active' ? 'var(--primary)' : 'var(--text-muted)' }}
                        title={c.status === 'Active' ? 'Set Inactive' : 'Set Active'}
                      >
                        {c.status === 'Active' ? <ToggleRight size={32} /> : <ToggleLeft size={32} />}
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Add car form */}
        {showAddForm && (
          <div className="glass-panel" style={{ padding: '2rem' }}>
            <h3 style={{ fontSize: '1.25rem', marginBottom: '1.5rem' }}>List New Vehicle</h3>
            <form onSubmit={handleAddCar}>
              <div className="form-group">
                <label className="form-label">Brand & Model</label>
                <input 
                  type="text" 
                  className="form-input" 
                  style={{ paddingLeft: '1rem' }} 
                  placeholder="e.g. Honda Civic"
                  value={newCarMake}
                  onChange={(e) => setNewCarMake(e.target.value)}
                  required
                />
              </div>

              <div className="form-group">
                <label className="form-label">License Plate</label>
                <input 
                  type="text" 
                  className="form-input" 
                  style={{ paddingLeft: '1rem' }} 
                  placeholder="e.g. 29A-123.45"
                  value={newCarPlate}
                  onChange={(e) => setNewCarPlate(e.target.value)}
                  required
                />
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                <div className="form-group">
                  <label className="form-label">Year</label>
                  <select 
                    className="form-select"
                    value={newCarYear}
                    onChange={(e) => setNewCarYear(e.target.value)}
                  >
                    <option value="2024">2024</option>
                    <option value="2023">2023</option>
                    <option value="2022">2022</option>
                    <option value="2021">2021</option>
                    <option value="2020">2020</option>
                  </select>
                </div>

                <div className="form-group">
                  <label className="form-label">Daily Price ($)</label>
                  <input 
                    type="number" 
                    className="form-input" 
                    style={{ paddingLeft: '1rem' }} 
                    placeholder="75"
                    value={newCarPrice}
                    onChange={(e) => setNewCarPrice(e.target.value)}
                    required
                  />
                </div>
              </div>

              <div style={{ display: 'flex', gap: '1rem', marginTop: '1.5rem' }}>
                <button type="submit" className="btn-primary" style={{ margin: 0, flexGrow: 1 }}>
                  Submit Fleet Car
                </button>
                <button 
                  type="button" 
                  className="btn-outline" 
                  style={{ flexGrow: 1, justifyContent: 'center' }} 
                  onClick={() => setShowAddForm(false)}
                >
                  Cancel
                </button>
              </div>
            </form>
          </div>
        )}

      </div>
    </div>
  );
};

export default OwnerDashboard;
