import React, { useState, useEffect, Fragment } from 'react';
import { redirect } from 'react-router';

const AdminDashboard = () => {
  useEffect(() => {
    const loggedIn = localStorage.getItem('logged_in');

    if(loggedIn == null || loggedIn == false) {
      window.location.href = '/admin/login';
    }
  }, []);

  return(<div>
    Dashboard
  </div>)
};

export default AdminDashboard;