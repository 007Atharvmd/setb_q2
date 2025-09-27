const express = require('express');
const app = express();
const PORT = 8080;

// Retrieve build information from environment variables
const buildId = process.env.BUILD_ID || 'N/A';
const gitCommit = process.env.GIT_COMMIT || 'N/A';

app.get('/', (req, res) => {
  res.send(`
    <h1>Hello from the Advanced Node.js App!COde CHange 4</h1>
    <p>This application was built with Jenkins and Docker.</p>
    <ul>
      <li><b>Jenkins Build ID:</b> ${buildId}</li>
      <li><b>Git Commit Hash:</b> ${gitCommit}</li>
    </ul>
  `);
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
  console.log(`Build ID: ${buildId}, Git Commit: ${gitCommit}`);
});