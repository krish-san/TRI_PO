const express = require('express');
const router = express.Router();
const pool = require('../db');

// Create new accused entry
router.post('/', async (req, res) => {
  try {
    const {
      name,
      fatherName,
      caste,
      profession,
      nativePlace,
      witnesses,
      residence,
      placesVisited,
      offenderClass
    } = req.body;

    const result = await pool.query(
      'INSERT INTO accused (name, father_husband_name, caste, trade_profession, native_place_district, certifying_witnesses, residence, places_visited, classification) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *',
      [name, fatherName, caste, profession, nativePlace, witnesses, residence, placesVisited, offenderClass]
    );

    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get all accused entries
router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM accused ORDER BY created_at DESC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get accused by ID
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query('SELECT * FROM accused WHERE accused_id = $1', [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Accused not found' });
    }
    
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;