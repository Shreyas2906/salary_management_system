import Sidebar from "./Sidebar";

export default function Layout({ children }) {
  return (
    <div style={{ display: "flex" }}>
      <Sidebar />

      <div style={{ flex: 1, padding: "20px", background: "#f1f5f9" }}>
        {children}
      </div>
    </div>
  );
}