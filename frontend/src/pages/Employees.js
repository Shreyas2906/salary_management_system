import { useEffect, useState } from "react";
import API from "../services/api";

export default function Employees() {
  const [employees, setEmployees] = useState([]);
  const [page, setPage] = useState(1);

  const [search, setSearch] = useState("");
  const [jobTitle, setJobTitle] = useState("");

  const role = localStorage.getItem("role");
  const isAdmin = role === "admin";

  const fetchEmployees = (pageNum = 1) => {
    API.get(
      `/employees?page=${pageNum}&per_page=10&search=${search}&job_title=${jobTitle}`
    )
      .then((res) => setEmployees(res.data))
      .catch(console.error);
  };

  useEffect(() => {
    fetchEmployees(page);
  }, [page, search, jobTitle]);

  useEffect(() => {
    setPage(1);
  }, [search, jobTitle]);

  return (
    <div style={{ padding: "20px" }}>
      <h2>Employees</h2>

      {/* 🔍 SEARCH + FILTER */}
      <div style={{ marginBottom: "15px" }}>
        <input
          placeholder="Search by name"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          style={{
            marginRight: "10px",
            padding: "5px"
          }}
        />

        <select
          value={jobTitle}
          onChange={(e) => setJobTitle(e.target.value)}
          style={{ padding: "5px" }}
        >
          <option value="">All Roles</option>
          <option value="Analyst">Analyst</option>
          <option value="Tech">Tech</option>
          <option value="Manager">Manager</option>
        </select>
      </div>

      <table border="1" style={{ width: "100%", marginBottom: "10px" }}>
        <thead>
          <tr>
            <th>Name</th>
            <th>Job</th>
            <th>Country</th>
            {isAdmin ? <th>Salary</th> : <th>Email</th>}
          </tr>
        </thead>

        <tbody>
          {employees.length > 0 ? (
            employees.map((e) => (
              <tr key={e.id}>
                <td>{e.full_name}</td>
                <td>{e.job_title}</td>
                <td>{e.country}</td>

                {isAdmin ? (
                  <td>{e.salary}</td>
                ) : (
                  <td>
                    <a href={`mailto:${e.user?.email}`}>
                      {e.user?.email || "N/A"}
                    </a>
                  </td>
                )}
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan="4" style={{ textAlign: "center" }}>
                No employees found
              </td>
            </tr>
          )}
        </tbody>
      </table>

      <div>
        <button onClick={() => setPage(page - 1)} disabled={page === 1}>
          Prev
        </button>

        <span style={{ margin: "0 10px" }}>Page {page}</span>

        <button onClick={() => setPage(page + 1)}>
          Next
        </button>
      </div>
    </div>
  );
}