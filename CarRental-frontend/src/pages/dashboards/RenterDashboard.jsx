import React, { useState } from 'react';
import { Search, Fuel, Settings2, ShieldCheck, CheckCircle2, Star, Calendar } from 'lucide-react';

const INITIAL_CATALOG = [
  { id: 1, make: 'Tesla Model 3', type: 'Electric', transmission: 'Automatic', price: 95, rating: 4.9, image: 'https://images.unsplash.com/photo-1563720223185-11003d516935?w=500&auto=format&fit=crop&q=60' },
  { id: 2, make: 'Mazda CX-5', type: 'Petrol', transmission: 'Automatic', price: 55, rating: 4.7, image: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=500&auto=format&fit=crop&q=60' },
  { id: 3, make: 'Toyota Fortuner', type: 'Diesel', transmission: 'Manual', price: 70, rating: 4.8, image: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=500&auto=format&fit=crop&q=60' },
  { id: 4, make: 'Honda Civic', type: 'Petrol', transmission: 'Automatic', price: 45, rating: 4.6, image: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=500&auto=format&fit=crop&q=60' },
  { id: 5, make: 'Ford Mustang', type: 'Petrol', transmission: 'Manual', price: 120, rating: 4.95, image: 'https://images.unsplash.com/photo-1584345604476-8ec5e12e42dd?w=500&auto=format&fit=crop&q=60' }
];

const RenterDashboard = () => {
  const [catalog, setCatalog] = useState(INITIAL_CATALOG);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedType, setSelectedType] = useState('All');
  
  const [bookings, setBookings] = useState([]);
  const [showSuccessModal, setShowSuccessModal] = useState(false);
  const [latestBookedCar, setLatestBookedCar] = useState(null);

  const handleBookCar = (car) => {
    const newBooking = {
      id: Date.now(),
      carName: car.make,
      price: car.price,
      date: new Date().toISOString().split('T')[0],
      status: 'Confirmed'
    };
    setBookings([newBooking, ...bookings]);
    setLatestBookedCar(car);
    setShowSuccessModal(true);
  };

  const filteredCatalog = catalog.filter(car => {
    const matchesSearch = car.make.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesType = selectedType === 'All' || car.type === selectedType;
    return matchesSearch && matchesType;
  });

  return (
    <div>
      <div style={{ display: 'grid', gridTemplateColumns: '3fr 1fr', gap: '2rem', alignItems: 'start' }}>
        
        {/* Browse listings */}
        <div>
          {/* Search bar & filter */}
          <div className="glass-panel" style={{ padding: '1.5rem', marginBottom: '2rem', display: 'flex', gap: '1rem', alignItems: 'center' }}>
            <div className="form-input-container" style={{ flexGrow: 1 }}>
              <Search className="form-icon-left" size={18} />
              <input 
                type="text" 
                className="form-input" 
                placeholder="Search cars by model..." 
                style={{ paddingLeft: '2.5rem' }}
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
            
            <select 
              className="form-select" 
              style={{ width: '180px' }}
              value={selectedType}
              onChange={(e) => setSelectedType(e.target.value)}
            >
              <option value="All">All Fuel Types</option>
              <option value="Petrol">Petrol</option>
              <option value="Diesel">Diesel</option>
              <option value="Electric">Electric</option>
            </select>
          </div>

          {/* Cars Catalog Grid */}
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '1.5rem' }}>
            {filteredCatalog.map(car => (
              <div key={car.id} className="glass-panel" style={{ overflow: 'hidden', padding: 0 }}>
                {/* Simulated Car Image */}
                <div style={{ height: '180px', width: '100%', background: '#1c1f30', position: 'relative' }}>
                  <img 
                    src={car.image} 
                    alt={car.make} 
                    style={{ width: '100%', height: '100%', objectFit: 'cover', opacity: 0.8 }}
                    onError={(e) => { e.target.style.display = 'none'; }}
                  />
                  <div style={{ 
                    position: 'absolute', 
                    top: '1rem', 
                    right: '1rem', 
                    background: 'rgba(0,0,0,0.6)', 
                    backdropFilter: 'blur(4px)',
                    padding: '0.25rem 0.5rem', 
                    borderRadius: '4px',
                    display: 'flex', 
                    alignItems: 'center', 
                    gap: '0.25rem',
                    fontSize: '0.85rem'
                  }}>
                    <Star size={14} style={{ fill: '#fbbf24', color: '#fbbf24' }} />
                    <span style={{ fontWeight: '600' }}>{car.rating}</span>
                  </div>
                </div>

                <div style={{ padding: '1.5rem' }}>
                  <h4 style={{ fontSize: '1.15rem', marginBottom: '0.5rem' }}>{car.make}</h4>
                  
                  <div style={{ display: 'flex', gap: '1rem', fontSize: '0.85rem', color: 'var(--text-secondary)', marginBottom: '1.5rem' }}>
                    <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                      <Fuel size={14} /> {car.type}
                    </span>
                    <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                      <Settings2 size={14} /> {car.transmission}
                    </span>
                  </div>

                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div>
                      <span style={{ fontSize: '1.4rem', fontWeight: '700', color: 'var(--accent)' }}>${car.price}</span>
                      <span style={{ fontSize: '0.85rem', color: 'var(--text-muted)' }}>/day</span>
                    </div>
                    <button 
                      className="btn-primary" 
                      onClick={() => handleBookCar(car)}
                      style={{ margin: 0, padding: '0.5rem 1rem', fontSize: '0.9rem' }}
                    >
                      Book Now
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Sidebar bookings */}
        <div className="glass-panel" style={{ padding: '1.5rem' }}>
          <h3 style={{ fontSize: '1.1rem', marginBottom: '1rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <Calendar size={18} style={{ color: 'var(--primary)' }} />
            My Bookings
          </h3>

          {bookings.length === 0 ? (
            <div style={{ color: 'var(--text-muted)', fontSize: '0.9rem', textAlign: 'center', padding: '2rem 0' }}>
              No active bookings yet. Select a vehicle to rent.
            </div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
              {bookings.map(b => (
                <div key={b.id} style={{ padding: '1rem', background: 'rgba(255,255,255,0.03)', borderRadius: '8px', border: '1px solid var(--panel-border)' }}>
                  <div style={{ fontWeight: '600', fontSize: '0.95rem', marginBottom: '0.25rem' }}>{b.carName}</div>
                  <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.5rem' }}>Booked on {b.date}</div>
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <span style={{ fontSize: '0.9rem', fontWeight: '600', color: 'var(--accent)' }}>${b.price}/day</span>
                    <span style={{ fontSize: '0.75rem', fontWeight: '700', color: 'var(--success)', textTransform: 'uppercase' }}>{b.status}</span>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

      </div>

      {/* Booking confirmation modal */}
      {showSuccessModal && latestBookedCar && (
        <div style={{
          position: 'fixed', top: 0, left: 0, right: 0, bottom: 0,
          background: 'rgba(0,0,0,0.6)', backdropFilter: 'blur(8px)',
          display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 999
        }}>
          <div className="glass-panel" style={{ maxWidth: '400px', width: '90%', padding: '2.5rem', textAlign: 'center' }}>
            <CheckCircle2 size={54} style={{ color: 'var(--success)', margin: '0 auto 1.5rem' }} />
            <h3 style={{ fontSize: '1.5rem', marginBottom: '0.5rem' }}>Booking Confirmed!</h3>
            <p style={{ color: 'var(--text-secondary)', fontSize: '0.95rem', marginBottom: '2rem' }}>
              Your rental for the <strong>{latestBookedCar.make}</strong> has been successfully booked at <strong>${latestBookedCar.price}/day</strong>.
            </p>
            <button className="btn-primary" onClick={() => setShowSuccessModal(false)} style={{ margin: 0 }}>
              Back to Catalog
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default RenterDashboard;
