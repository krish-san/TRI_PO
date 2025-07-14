const router = require('express').Router();
const pool = require('../db');
const multer = require('multer');
const path = require('path');

// Configure multer for file uploads
const storage = multer.diskStorage({
    destination: './uploads/police',
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const upload = multer({ storage: storage });

// Create new police entry
router.post('/', upload.single('photo'), async (req, res) => {
    try {
        const {
            name, rank, g_number, station, date_of_enlistment, date_of_promotion,
            date_of_birth, cps_number, ifhrms_number, contact_number, father_name,
            marital_status, spouse_name, permanent_address, present_address,
            bank_name, account_number, ifsc_code, branch, aadhar_number,
            pan_number, religion, community, caste, education, blood_group,
            present_station_name, present_station_join_date, previous_station_name,
            previous_station_join_date, previous_station_end_date, photo_type
        } = req.body;

        const photo_path = req.file ? req.file.path : null;

        const query = `
            INSERT INTO police_officers (
                name, rank, g_number, station, date_of_enlistment, date_of_promotion,
                date_of_birth, cps_number, ifhrms_number, contact_number, father_name,
                marital_status, spouse_name, permanent_address, present_address,
                bank_name, account_number, ifsc_code, branch, aadhar_number,
                pan_number, religion, community, caste, education, blood_group,
                present_station_name, present_station_join_date, previous_station_name,
                previous_station_join_date, previous_station_end_date, photo_type,
                photo_path
            )
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, 
                    $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, 
                    $27, $28, $29, $30, $31, $32, $33)
            RETURNING *
        `;

        const values = [
            name, rank, g_number, station, date_of_enlistment, date_of_promotion,
            date_of_birth, cps_number, ifhrms_number, contact_number, father_name,
            marital_status, spouse_name, permanent_address, present_address,
            bank_name, account_number, ifsc_code, branch, aadhar_number,
            pan_number, religion, community, caste, education, blood_group,
            present_station_name, present_station_join_date, previous_station_name,
            previous_station_join_date, previous_station_end_date, photo_type,
            photo_path
        ];

        const result = await pool.query(query, values);
        res.status(201).json(result.rows[0]);
    } catch (error) {
        console.error('Error creating police entry:', error);
        res.status(500).json({ error: 'Failed to create police entry' });
    }
});

// Get all police entries
router.get('/', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM police_officers ORDER BY created_at DESC');
        res.json(result.rows);
    } catch (error) {
        console.error('Error fetching police entries:', error);
        res.status(500).json({ error: 'Failed to fetch police entries' });
    }
});

// Get police entry by ID
router.get('/:id', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM police_officers WHERE id = $1', [req.params.id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Police entry not found' });
        }
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error fetching police entry:', error);
        res.status(500).json({ error: 'Failed to fetch police entry' });
    }
});

module.exports = router;