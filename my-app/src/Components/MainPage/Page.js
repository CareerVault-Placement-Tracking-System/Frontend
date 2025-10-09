import React from "react";
import "./styles.css";
const Page = ({ setView }) => (
 
   <div className="container landing-container">
      <h1>Placement Tracker App</h1>
      <p>Track opportunities and manage applications with US</p>
      <div className="buttons">
        <button className="login-button" onClick={() => setView("login")}>Student Login</button>
        <button className="login-button" onClick={() => setView("login")}>Placement Admin Login</button>
      </div>
    </div>
);

export default Page;
