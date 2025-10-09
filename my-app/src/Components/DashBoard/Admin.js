import React from "react";
import "./admin.css";

const Admin = ({ onSignOut }) => (
    <div className="dashboard-container">
      <div className="dashboard-header">
        <h1 className="dashboard-title">Placement Dashboard</h1>
        <button onClick={onSignOut} className="signout-button">
          Sign Out
        </button>
      </div>
      <div className="dashboard-content">
        <div className="sidebar">
          <ul className="dashboard-menu">
            <li className="menu-item">
              <h2>Ongoing Drives</h2>
              <p>View and manage current placement drives.</p>
            </li>
            <li className="menu-item">
              <h2>Completed Drives</h2>
              <p>Review the history of completed drives.</p>
            </li>
            <li className="menu-item">
              <h2>Placed Students</h2>
              <p>Track students who have secured placements.</p>
            </li>
          </ul>
        </div>
        <div className="main-content">
          <p>Select a section from the left to view details.</p>
        </div>
      </div>
    </div>
);

export default Admin;
