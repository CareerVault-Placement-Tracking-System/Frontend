import React, { useState } from "react";
import "./styles.css";

const LoginPage = ({ onSignInSuccess }) => {
  const [state, setState] = useState({
    email: "",
    password: ""
  });

  const handleChange = evt => {
    const value = evt.target.value;
    setState({
      ...state,
      [evt.target.name]: value
    });
  };

  const handleOnSubmit = evt => {
    evt.preventDefault();
    const { email, password } = state;
    console.log(`You are logged in with email: ${email} and password: ${password}`);
    onSignInSuccess();
  };

  return (
    <div className="form-container sign-in-container">
      <form onSubmit={handleOnSubmit}>
        <h1>Sign In</h1>
        <input
          type="email"
          placeholder="Email"
          name="email"
          value={state.email}
          onChange={handleChange}
        />
        <input
          type="password"
          name="password"
          placeholder="Password"
          value={state.password}
          onChange={handleChange}
        />
       


        <button type="submit">Sign In</button>
        <button>success</button>
        </form>
    </div>
  );
};

export default LoginPage;
