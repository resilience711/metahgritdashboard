export default function Dashboard() {
  return (
    <main style={{ padding: "20px", fontFamily: "Arial" }}>
      <h1 style={{ fontSize: "28px", marginBottom: "20px" }}>
        Metahgrit Mining Dashboard
      </h1>

      <div style={{
        display: "grid",
        gridTemplateColumns: "repeat(auto-fit, minmax(250px, 1fr))",
        gap: "20px"
      }}>
        
        {/* Hashrate Card */}
        <div style={cardStyle}>
          <h3>Hashrate</h3>
          <p style={valueStyle}>0 TH/s</p>
        </div>

        {/* Workers Card */}
        <div style={cardStyle}>
          <h3>Active Workers</h3>
          <p style={valueStyle}>0</p>
        </div>

        {/* Revenue Card */}
        <div style={cardStyle}>
          <h3>Revenue (24h)</h3>
          <p style={valueStyle}>$0.00</p>
        </div>

      </div>
    </main>
  );
}

const cardStyle = {
  padding: "20px",
  borderRadius: "12px",
  background: "#111",
  color: "#fff",
  boxShadow: "0 4px 10px rgba(0,0,0,0.2)"
};

const valueStyle = {
  fontSize: "22px",
  marginTop: "10px",
  fontWeight: "bold"
};
