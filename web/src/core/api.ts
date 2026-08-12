import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:3000',
  headers: {
    'Content-Type': 'application/json',
  },
});

// Interceptor para inyectar token JWT e ID de inquilino (Tenant) de forma dinámica
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('web_token');
  const tenantId = localStorage.getItem('web_tenant_id');

  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }

  if (tenantId) {
    config.headers['x-tenant-id'] = tenantId;
  }

  return config;
}, (error) => {
  return Promise.reject(error);
});

export default api;
