import axios from 'axios';
const BASE_URL = '/admin/v1/';

const RequestClient = ({ method, payload }) => {
  const defaultOptions = {
    baseURL: BASE_URL,
    method: method,
    data: payload,
    headers: {
      'Content-Type': 'application/json',
    },
  };

  // Create instance
  let instance = axios.create(defaultOptions);

  // Set the AUTH token for any request
  instance.interceptors.request.use(function (config) {
    const token = localStorage.getItem('access_token');
    config.headers.Authorization =  token ? `Bearer ${token}` : '';
    return config;
  });

  return instance;
};

export default RequestClient;