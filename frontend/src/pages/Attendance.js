import { useEffect, useState } from "react";
import API from "../services/api";

export default function Attendance() {
  const [employees, setEmployees] = useState([]);
  const [attendanceList, setAttendanceList] = useState([]);
  const [page, setPage] = useState(1);

  const [form, setForm] = useState({
    employee_id: "",
    days_present: "",
    total_working_days: ""
  });

  useEffect(() => {
    fetchEmployees();
    fetchAttendance(page);
  }, [page]);

  const fetchEmployees = () => {
    API.get("/employees?per_page=100")
      .then((res) => setEmployees(res.data))
      .catch(console.error);
  };

  const fetchAttendance = (pageNum = 1) => {
    API.get(`/attendance?page=${pageNum}&per_page=5`)
      .then((res) => setAttendanceList(res.data))
      .catch(console.error);
  };

  const existingEmployeeIds = attendanceList.map(a => a.employee_id);

  const handleSubmit = (e) => {
    e.preventDefault();

    API.post("/attendance", { attendance: form })
      .then(() => {
        alert("Attendance added");
        setForm({ employee_id: "", days_present: "", total_working_days: "" });
        fetchAttendance(page);
      })
      .catch(console.error);
  };

  return (
    <div style={{ padding: "20px" }}>
      <h2>Attendance</h2>

      {/* Attendance Table */}
      <table border="1" style={{ width: "100%", marginBottom: "10px" }}>
        <thead>
          <tr>
            <th>Name</th>
            <th>Job</th>
            <th>Days Present</th>
            <th>Total Days</th>
          </tr>
        </thead>

        <tbody>
          {attendanceList.map((a) => (
            <tr key={a.id}>
              <td>{a.employee?.full_name}</td>
              <td>{a.employee?.job_title}</td>
              <td>{a.days_present}</td>
              <td>{a.total_working_days}</td>
            </tr>
          ))}
        </tbody>
      </table>

      {/* Pagination */}
      <div style={{ marginBottom: "30px" }}>
        <button onClick={() => setPage(page - 1)} disabled={page === 1}>
          Prev
        </button>

        <span style={{ margin: "0 10px" }}>Page {page}</span>

        <button onClick={() => setPage(page + 1)}>
          Next
        </button>
      </div>

      {/* Form */}
      <h3>Add Attendance</h3>

      <form onSubmit={handleSubmit}>
        <select
          value={form.employee_id}
          onChange={(e) =>
            setForm({ ...form, employee_id: e.target.value })
          }
        >
          <option value="">Select Employee</option>

          {employees.map((e) => (
            <option
              key={e.id}
              value={e.id}
              disabled={existingEmployeeIds.includes(e.id)}
            >
              {e.full_name} ({e.job_title})
              {existingEmployeeIds.includes(e.id)
                ? " - Already Marked"
                : ""}
            </option>
          ))}
        </select>

        <br /><br />

        <input
          placeholder="Days Present"
          value={form.days_present}
          onChange={(e) =>
            setForm({ ...form, days_present: e.target.value })
          }
        />

        <br /><br />

        <input
          placeholder="Total Working Days"
          value={form.total_working_days}
          onChange={(e) =>
            setForm({ ...form, total_working_days: e.target.value })
          }
        />

        <br /><br />

        <button type="submit">Submit</button>
      </form>
    </div>
  );
}