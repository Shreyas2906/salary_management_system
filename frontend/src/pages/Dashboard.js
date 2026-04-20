import { useEffect, useState } from "react";
import API from "../services/api";
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer } from "recharts";

export default function Dashboard() {
  const role = localStorage.getItem("role");
  const isAdmin = role === "admin";

  const [data, setData] = useState({ min: 0, max: 0, avg: 0 });
  const [country, setCountry] = useState("India");

  const [employeeData, setEmployeeData] = useState(null);

  const getDaysToPayday = () => {
    const today = new Date();
    const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);
    const diff = Math.ceil((lastDay - today) / (1000 * 60 * 60 * 24));
    return diff;
  };

  const fetchAdminData = (selectedCountry) => {
    API.get(`/insights/salary?country=${selectedCountry}`)
      .then((res) => setData(res.data))
      .catch(handleError);
  };

  const fetchEmployeeData = () => {
    API.get("/me/dashboard")
      .then((res) => setEmployeeData(res.data))
      .catch(handleError);
  };

  const handleError = (err) => {
    if (err.response?.status === 401) {
      alert("Session expired. Please login again.");
      localStorage.clear();
      window.location.reload();
    }
  };

  useEffect(() => {
    if (isAdmin) {
      fetchAdminData(country);
    } else {
      fetchEmployeeData();
    }
  }, [country]);

  const chartData = [
    { name: "Min", value: data.min },
    { name: "Avg", value: data.avg },
    { name: "Max", value: data.max },
  ];

  return (
    <div style={{ padding: "20px" }}>
      <h2>Dashboard</h2>

      {/* ================= ADMIN VIEW ================= */}
      {isAdmin && (
        <>
          <div style={{ marginBottom: "20px" }}>
            <label>Select Country: </label>
            <select value={country} onChange={(e) => setCountry(e.target.value)}>
              <option value="India">India</option>
              <option value="USA">USA</option>
              <option value="UK">UK</option>
            </select>
          </div>

          <div style={{ display: "flex", gap: "20px", marginBottom: "30px" }}>
            <div style={cardStyle}>
              <h4>Min Salary</h4>
              <p>{data.min}</p>
            </div>

            <div style={cardStyle}>
              <h4>Avg Salary</h4>
              <p>{data.avg}</p>
            </div>

            <div style={cardStyle}>
              <h4>Max Salary</h4>
              <p>{data.max}</p>
            </div>
          </div>

          <div style={{ width: "100%", height: 300 }}>
            <ResponsiveContainer>
              <BarChart data={chartData}>
                <XAxis dataKey="name" />
                <YAxis />
                <Tooltip />
                <Bar dataKey="value" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </>
      )}

      {/* ================= EMPLOYEE VIEW ================= */}
      {!isAdmin && employeeData && (
        <>
          <div style={cardStyle}>
            <h3>💼 Salary Details</h3>
            <p>Monthly Salary: ₹ {employeeData.salary}</p>
            <p>Per Day: ₹ {employeeData.payroll.per_day}</p>
            <p>Earned This Month: ₹ {employeeData.payroll.earned}</p>
            <p>Tax: ₹ {employeeData.payroll.tax}</p>
            <p><b>Net Salary: ₹ {employeeData.payroll.net}</b></p>
          </div>

          <div style={cardStyle}>
            <h3>📅 Attendance</h3>
            <p>
              {employeeData.attendance.days_present} /{" "}
              {employeeData.attendance.total_days_in_month} days
            </p>
          </div>

          <div style={paydayStyle}>
            💸 Payday in {getDaysToPayday()} days
          </div>
        </>
      )}
    </div>
  );
}

const cardStyle = {
  padding: "20px",
  marginBottom: "20px",
  borderRadius: "10px",
  background: "#fff",
  boxShadow: "0 2px 5px rgba(0,0,0,0.1)"
};

const paydayStyle = {
  padding: "15px",
  background: "#dcfce7",
  borderRadius: "10px",
  fontWeight: "bold"
};