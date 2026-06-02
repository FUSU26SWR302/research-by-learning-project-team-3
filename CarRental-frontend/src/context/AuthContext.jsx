import React, { createContext, useState, useEffect, useContext } from 'react';

const AuthContext = createContext(null);

// Standard mock users list for fallback when Java backend REST APIs are offline or dev server is standalone
const MOCK_USERS = [
  { email: 'admin@carrental.com', name: 'System Administrator', role: 'ADMIN', active: true },
  { email: 'staff@carrental.com', name: 'Support Staff User', role: 'STAFF', active: true },
  { email: 'owner@carrental.com', name: 'Car Owner Partner', role: 'CAR_OWNER', active: true },
  { email: 'renter@carrental.com', name: 'John Renter', role: 'RENTER', active: true },
  { email: 'inactive@carrental.com', name: 'Suspended User', role: 'RENTER', active: false }
];

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  // Restore session from localStorage on mount
  useEffect(() => {
    const savedUser = localStorage.getItem('car_rental_user');
    if (savedUser) {
      setUser(JSON.parse(savedUser));
    }
    setLoading(false);
  }, []);

  const login = async (email, password) => {
    try {
      // 1. Try real login via API proxy
      const response = await fetch('/api/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password })
      });

      if (response.ok) {
        const data = await response.json();
        if (data.active) {
          setUser(data);
          localStorage.setItem('car_rental_user', JSON.stringify(data));
          return { success: true };
        } else {
          return { success: false, error: 'Your account is deactivated. Please contact support.' };
        }
      } else {
        const errText = await response.text();
        let errMsg = 'Invalid email or password.';
        try {
          const errObj = JSON.parse(errText);
          errMsg = errObj.message || errMsg;
        } catch (_) {}
        return { success: false, error: errMsg };
      }
    } catch (networkError) {
      console.warn('API connection failed. Falling back to mock authentication...', networkError);
      
      // 2. Fallback to mock login
      const matchedUser = MOCK_USERS.find(
        (u) => u.email.toLowerCase() === email.trim().toLowerCase()
      );

      if (matchedUser) {
        // Assume password matches (demo password pattern is any matching name with 123)
        if (password.length >= 6) {
          if (!matchedUser.active) {
            return { success: false, error: 'Your account is deactivated. Please contact support.' };
          }
          setUser(matchedUser);
          localStorage.setItem('car_rental_user', JSON.stringify(matchedUser));
          return { success: true, isMock: true };
        }
      }
      return { success: false, error: 'Invalid email or password. (Hint: use admin@carrental.com / admin123)' };
    }
  };

  const register = async (name, email, password, role) => {
    try {
      // 1. Try registration via API proxy
      const response = await fetch('/api/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name, email, password, role })
      });

      if (response.ok) {
        return { success: true };
      } else {
        const errText = await response.text();
        let errMsg = 'Registration failed.';
        try {
          const errObj = JSON.parse(errText);
          errMsg = errObj.message || errMsg;
        } catch (_) {}
        return { success: false, error: errMsg };
      }
    } catch (networkError) {
      console.warn('API connection failed. Simulating local registration...', networkError);
      
      // 2. Mock registration fallback
      if (email && name && password.length >= 6) {
        const mockNewUser = { name, email, role, active: true };
        setUser(mockNewUser);
        localStorage.setItem('car_rental_user', JSON.stringify(mockNewUser));
        return { success: true, isMock: true };
      }
      return { success: false, error: 'Please provide all details and password >= 6 characters.' };
    }
  };

  const logout = async () => {
    try {
      await fetch('/api/logout', { method: 'POST' });
    } catch (err) {
      console.warn('API logout failed, clearing local session...', err);
    } finally {
      setUser(null);
      localStorage.removeItem('car_rental_user');
    }
  };

  return (
    <AuthContext.Provider value={{ user, loading, login, register, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
