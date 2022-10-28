import React, { useState, Fragment } from 'react';
import axios from 'axios'
import './styles.scss';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const onSubmitForm = () => {
    const payload = {
      email: email,
      password: password
    }
    axios.post('/admin/v1/authentications', payload).then(res => {
      if(res.data && res.data.status == 'success') {
        const { info } = res.data.data;

        localStorage.setItem('access_token', info.access_token )
        localStorage.setItem('logged_in', true )
        window.location.href = '/admin';
        console.log(res)
      } else {
        console.log(res.data)
      }
  
      // window.location.href = '/';
    }).catch(error => {
      console.log(error);
    });
  }

  const onChangeEmail = (e) => {
    setEmail(e.target.value);
  };

  const onChangePassword = (e) => {
    setPassword(e.target.value);
  };

  return (
    <Fragment>
      <h1 className="text-center">Login</h1>
      <form className="container mt-4">
        <div className="form-group">
          <label >Email</label>
          <input type="email" className="form-control" onChange={onChangeEmail} id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email"></input>
        </div>
        <div className="form-group mt-4">
          <label >Password</label>
          <input type="password" className="form-control" onChange={onChangePassword} id="exampleInputPassword1" placeholder="Password"></input>
        </div>
        <button type="button" onClick={onSubmitForm} className="btn btn-primary mt-4">Submit</button>
      </form>
    </Fragment>
  );

}

export default Login;