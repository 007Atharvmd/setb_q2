const express = require('express');
const app = express();
const PORT = 3000;

// Environment variables passed as build args will be available here
const buildId = process.env.BUILD_ID || 'N/A';
const gitCommit = process.env.GIT_COMMIT || 'N/A';

app.get('/', (req, res) => {
  res.send(`Hello from Docker! TRIGGER4!!!! Jenkins Build ID: ${buildId}, Git Commit: ${gitCommit}`);
});

app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
});
