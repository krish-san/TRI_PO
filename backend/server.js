const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
require('dotenv').config();
const path = require('path');

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Database configuration
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

// Routes
app.use('/api/police', require('./routes/police'));
const accusedRoutes = require('./routes/accused');
app.use('/api/accused', accusedRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});


// Serve Flutter Web static files
app.use(express.static(path.join(__dirname, '..', 'builds', 'web')));

// Fallback route for Flutter Web routing (SPA)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '..', 'builds', 'web', 'index.html'));
});

