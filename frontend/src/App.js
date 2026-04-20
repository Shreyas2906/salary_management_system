import { BrowserRouter, Routes, Route } from "react-router-dom";
import Dashboard from "./pages/Dashboard";
import Employees from "./pages/Employees";
import Attendance from "./pages/Attendance";
import Login from "./pages/Login";
import Layout from "./components/Layout";
import { setAuthToken } from "./services/api";

function App() {
  const token = localStorage.getItem("token");

  if (token) {
    setAuthToken(token);
  }

  if (!token) {
    return <Login />;
  }

  return (
    <BrowserRouter>
      <Layout>
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/employees" element={<Employees />} />
          <Route path="/attendance" element={<Attendance />} />
        </Routes>
      </Layout>
    </BrowserRouter>
  );
}

export default App;