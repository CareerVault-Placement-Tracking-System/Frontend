import React, { useState } from "react";
import Admin from "./Components/DashBoard/Admin.js";
import LoginPage from "./Components/LoginPage/LoginPage";
import MainPage from "./Components/MainPage/Page.js";
import SignUpPage from "./Components/SignupPage/signUp.js";
import "./appstyle.css";
import "./Components/LoginPage/styles.css";
import "./Components/MainPage/styles.css";
import "./Components/DashBoard/admin.css";
const App = () => {
  const [view, setView] = useState("landing");
  const [isSignUpActive, setIsSignUpActive] = useState(false);

  const handleSignInSuccess = () => {
    setView("dashboard");
  };

  const handleSignOut = () => {
    setView("landing");
  };

  const containerClass = `container ${isSignUpActive ? "right-panel-active" : ""}`;

  return (
      <div className="App">
        {view === "landing" ? (
          <MainPage setView={setView} />
        ) : view === "dashboard" ? (
          <Admin onSignOut={handleSignOut} />
        ) : (
          <div className={containerClass} id="container">
            <SignUpPage />
            <LoginPage onSignInSuccess={handleSignInSuccess} />
            <div className="overlay-container">
              <div className="overlay">
                <div className="overlay-panel overlay-left">
                  <h1>Welcome Back!</h1>
                  <p>To keep connected with the Placement team</p>
                  <button
                    className="ghost"
                    id="signIn"
                    onClick={() => setIsSignUpActive(false)}
                  >
                    Sign In
                  </button>
                </div>
                <div className="overlay-panel overlay-right">
                  <h1>Hello, Friend!</h1>
                  <p>To join with The Rajalakshmi's Placement team</p>
                  <button
                    className="ghost"
                    id="signUp"
                    onClick={() => setIsSignUpActive(true)}
                  >
                    Sign Up
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
  );
};

export default App;
