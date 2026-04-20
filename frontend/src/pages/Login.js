import { useState } from "react";
import API, { setAuthToken } from "../services/api";

export default function Login() {
  const [form, setForm] = useState({ email: "", password: "" });
  

  const handleLogin = (e) => {
    e.preventDefault();

    API.post("/login", form)
      .then((res) => {
        localStorage.setItem("token", res.data.token);
        localStorage.setItem("role", res.data.role);

        setAuthToken(res.data.token);
        window.location.reload();
      })
      .catch(() => alert("Invalid credentials"));
  };

  return (
    <div style={styles.container}>
      <form onSubmit={handleLogin} style={styles.card}>
        <h2>Login</h2>

        <input
          placeholder="Email"
          onChange={(e) => setForm({ ...form, email: e.target.value })}
        />

        <input
          type="password"
          placeholder="Password"
          onChange={(e) => setForm({ ...form, password: e.target.value })}
        />

        <button type="submit">Login</button>
      </form>
    </div>
  );
}

const styles = {
  container: {
    height: "100vh",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    background: "#e2e8f0"
  },
  card: {
    background: "#fff",
    padding: "30px",
    borderRadius: "10px",
    display: "flex",
    flexDirection: "column",
    gap: "10px",
    width: "300px"
  }
};