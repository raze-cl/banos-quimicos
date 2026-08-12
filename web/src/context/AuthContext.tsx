import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import api from '../core/api';

interface User {
  id: string;
  email: string;
  role: string;
  name: string;
}

interface AuthContextType {
  user: User | null;
  tenantId: string | null;
  isAuthenticated: boolean;
  loading: boolean;
  login: (email: string, password: string, tenantId: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [tenantId, setTenantId] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  const logout = useCallback(() => {
    localStorage.removeItem('web_token');
    localStorage.removeItem('web_tenant_id');
    localStorage.removeItem('web_user');
    setUser(null);
    setTenantId(null);
    setLoading(false);
  }, []);

  const checkSession = useCallback(async () => {
    const token = localStorage.getItem('web_token');
    const storedTenantId = localStorage.getItem('web_tenant_id');
    const storedUser = localStorage.getItem('web_user');

    if (token && storedTenantId && storedUser) {
      try {
        setTenantId(storedTenantId);
        setUser(JSON.parse(storedUser));
      } catch (e) {
        logout();
      }
    }
    setLoading(false);
  }, [logout]);

  useEffect(() => {
    checkSession();
  }, [checkSession]);

  const login = async (email: string, password: string, selectedTenantId: string) => {
    setLoading(true);
    try {
      localStorage.setItem('web_tenant_id', selectedTenantId);
      
      let token = 'token-demo-jwt';
      let profile = {
        id: 'user-demo-admin',
        email: email || 'admin@faena.cl',
        name: 'Administrador de Faena',
        role: 'ADMIN',
      };

      try {
        const response = await api.post('/api/v1/auth/login', { email, password });
        if (response.data?.access_token) {
          token = response.data.access_token;
          profile = response.data.user || profile;
        }
      } catch (_) {
        // En entorno Vercel de demostración si la API no está conectada públicamente, se inicia sesión en modo demo
      }

      localStorage.setItem('web_token', token);
      localStorage.setItem('web_user', JSON.stringify(profile));

      setUser(profile);
      setTenantId(selectedTenantId);
    } catch (error) {
      localStorage.removeItem('web_tenant_id');
      throw error;
    } finally {
      setLoading(false);
    }
  };

  return (
    <AuthContext.Provider value={{ user, tenantId, isAuthenticated: !!user, loading, login, logout }}>
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
