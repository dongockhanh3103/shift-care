import React from 'react';
import { Route, Routes } from 'react-router-dom';
import Dashboard from './Dashboard';
import Login from './admin/Login'
import Clients from './admin/clients/Clients'
import Plumbers from './admin/plumbers/Plumbers'
import AdminDashboard from './admin/Dashboard';
import ClientDetail from './admin/clients/ClientDetail';
import PlumberDetail from './admin/plumbers/PlumberDetail';

import Jobs from './admin/jobs/Jobs';

const App = () => {
  return (
    <Routes>
      <Route exact path="/" element={<Dashboard />} ></Route>
      <Route exact path="/admin" element={<AdminDashboard />} ></Route>
      <Route exact path="/admin/login" element={<Login />} ></Route>
      <Route exact path="/admin/clients" element={<Clients />} ></Route>
      <Route exact path="/admin/plumbers" element={<Plumbers />} ></Route>
      <Route exact path="/admin/jobs" element={<Jobs />} ></Route>
      <Route exact path="/admin/jobs/:id" element={<Jobs />} ></Route>
      <Route exact path="/admin/clients/:id" element={<ClientDetail />} ></Route>
      <Route exact path="/admin/plumbers/:id" element={<PlumberDetail />} ></Route>
    </Routes>
  );
};

export default App;