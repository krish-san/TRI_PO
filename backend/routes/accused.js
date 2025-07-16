const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const pool = require('../db');
const fs = require('fs');


// Configure multer for file uploads
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/accused');
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = `${Date.now()}-${Math.round(Math.random() * 1E9)}`;
        cb(null, `${file.fieldname}-${uniqueSuffix}${path.extname(file.originalname)}`);
    }
});

const upload = multer({ storage });

// Create new accused entry with photos
router.post('/', upload.fields([
    { name: 'fullFacePhoto', maxCount: 1 },
    { name: 'fullLengthPhoto', maxCount: 1 },
    { name: 'headShoulderPhoto', maxCount: 1 },
    { name: 'profileLeftPhoto', maxCount: 1 },
    { name: 'profileRightPhoto', maxCount: 1 }
]), async (req, res) => {
    try {
        const photos = {};
        if (req.files) {
            Object.keys(req.files).forEach(key => {
            photos[key] = fs.readFileSync(req.files[key][0].path);  // binary buffer
        });

        }

        const query = `
            INSERT INTO accused (
                name, father_husband_name, caste, profession, native_place,
                certifying_witnesses, residence, places_visited, offender_class,
                age, height, build, hair_color, is_bald, hair_cut_style,
                eyebrows, forehead, eyes, iris_color, sight, appearance,
                walk, talk, nose, mouth, lips, teeth, finger, chin, ears,
                face, complexion, moustache_style, beard_details,
                moustache_details, other_description, marks_hands,
                marks_face, marks_knees, marks_feet, peculiarities,
                appearance_details, deformities, accomplishments, habits,
                relatives, associates, property_disposal, past_arrests,
                crime_localities, criminal_history, suspicion_cases,
                convictions, current_doings, full_face_photo,
                full_length_photo, head_shoulder_photo, profile_left_photo,
                profile_right_photo
            )
            VALUES (${Array.from({ length: 59 }, (_, i) => `$${i + 1}`).join(', ')})
            RETURNING *
        `;

        const values = [
            // Page 1
            req.body.name,
            req.body.fatherName,
            req.body.caste,
            req.body.profession,
            req.body.nativePlace,
            req.body.witnesses,
            req.body.residence,
            req.body.placesVisited,
            req.body.offenderClass,
            
            // Page 2
            req.body.age,
            req.body.height,
            req.body.build,
            req.body.hairColor,
            req.body.isBald === 'Yes',
            req.body.hairCutStyle,
            req.body.eyebrows,
            req.body.forehead,
            req.body.eyes,
            req.body.irisColor,
            req.body.sight,
            req.body.appearance,
            req.body.walk,
            req.body.talk,
            
            // Page 3
            req.body.nose,
            req.body.mouth,
            req.body.lips,
            req.body.teeth,
            req.body.finger,
            req.body.chin,
            req.body.ears,
            req.body.face,
            req.body.complexion,
            req.body.moustacheStyle,
            req.body.beardDetails,
            req.body.moustacheDetails,
            req.body.otherDescription,
            
            // Page 4
            req.body.marksHands,
            req.body.marksFace,
            req.body.marksKnees,
            req.body.marksFeet,
            req.body.peculiarities,
            req.body.appearanceDetails,
            req.body.deformities,
            req.body.accomplishments,
            req.body.habits,
            
            // Page 5
            req.body.relatives,
            req.body.associates,
            req.body.propertyDisposal,
            req.body.pastArrests,
            req.body.crimeLocalities,
            req.body.criminalHistory,
            req.body.suspicionCases,
            req.body.convictions,
            req.body.currentDoings,
            
            // Photos
            photos.fullFacePhoto || null,
            photos.fullLengthPhoto || null,
            photos.headShoulderPhoto || null,
            photos.profileLeftPhoto || null,
            photos.profileRightPhoto || null
        ];

        const result = await pool.query(query, values);
        res.status(201).json(result.rows[0]);
    } catch (error) {
        console.error('Error creating accused entry:', error);
        res.status(500).json({ error: 'Failed to create accused entry' });
    }
});

// Get all accused entries
router.get('/', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM accused ORDER BY created_at DESC');
        res.json(result.rows);
    } catch (error) {
        console.error('Error fetching accused entries:', error);
        res.status(500).json({ error: 'Failed to fetch accused entries' });
    }
});

// Get accused by ID
router.get('/:id', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM accused WHERE id = $1', [req.params.id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Accused not found' });
        }
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error fetching accused:', error);
        res.status(500).json({ error: 'Failed to fetch accused' });
    }
});

// Search accused by ID (case-insensitive)
router.get('/search', async (req, res) => {
  try {
    const { id } = req.query;
    
    if (!id) {
      return res.status(400).json({ error: 'ID parameter is required' });
    }

    const accused = await Accused.findOne({ 
      id: { $regex: id, $options: 'i' }  // Case-insensitive search
    });

    if (!accused) {
      return res.status(404).json({ error: 'Accused not found' });
    }

    // Convert BYTEA fields to base64 string
    const photoFields = [
      'full_face_photo',
      'full_length_photo',
      'head_shoulder_photo',
      'profile_left_photo',
      'profile_right_photo'
    ];

    photoFields.forEach(field => {
      if (accused[field]) {
        accused[field] = accused[field].toString('base64'); // base64 encode
      }
    });

    res.json(accused);
  } catch (error) {
    console.error('Search error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


module.exports = router;