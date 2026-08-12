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
      // Registrar el selectedTenantId en el local storage ANTES del request
      // de forma que el interceptor de api.ts inyecte la cabecera x-tenant-id requerida
      localStorage.setItem('web_tenant_id', selectedTenantId);
      
      const response = await api.post('/api/v1/auth/login', { email, password });
      const { access_token, user: profile } = response.data;

      localStorage.setItem('web_token', access_token);
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
