import { useEffect, useState } from "react";
import API from "../services/api";

export default function AttendanceList() {
  const [data, setData] = useState([]);

  useEffect(() => {
    API.get("/attendance")
      .then((res) => setData(res.data))
      .catch(console.error);
  }, []);

  return (
    <div>
      <h2>Attendance Records</h2>

      <table border="1">
        <thead>
          <tr>
            <th>Name</th>
            <th>Job</th>
            <th>Days Present</th>
            <th>Total Days</th>
          </tr>
        </thead>

        <tbody>
          {data.map((a) => (
            <tr key={a.id}>
              <td>{a.employee.full_name}</td>
              <td>{a.employee.job_title}</td>
              <td>{a.days_present}</td>
              <td>{a.total_working_days}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}