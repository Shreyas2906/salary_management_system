import { Link } from "react-router-dom";
import { setAuthToken } from "../services/api";

export default function Sidebar() {
  const role = localStorage.getItem("role");
  const isAdmin = role === "admin";


  {isAdmin && (
    <Link style={styles.link} to="/attendance">Attendance</Link>
  )}

  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("role");

    setAuthToken(null);
    window.location.reload();
  };

  return (
    <div style={styles.sidebar}>
      <h2 style={{ color: "#fff" }}>💼 SMS</h2>

      <Link style={styles.link} to="/">Dashboard</Link>
      <Link style={styles.link} to="/employees">Employees</Link>

      {isAdmin && (
        <Link style={styles.link} to="/attendance">Attendance</Link>
      )}

      <button style={styles.logout} onClick={handleLogout}>
        Logout
      </button>
    </div>
  );
}

const styles = {
  sidebar: {
    width: "220px",
    height: "100vh",
    background: "#1e293b",
    color: "#fff",
    padding: "20px",
    display: "flex",
    flexDirection: "column",
    gap: "15px",
  },
  link: {
    color: "#cbd5f5",
    textDecoration: "none",
    padding: "5px 0"
  },
  logout: {
    marginTop: "auto",
    background: "#ef4444",
    color: "#fff",
    border: "none",
    padding: "10px",
    cursor: "pointer",
    borderRadius: "5px"
  }
};