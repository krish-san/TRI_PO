CREATE TABLE accused (
    id SERIAL PRIMARY KEY,

    -- Page 1: Personal Details
    name VARCHAR(200),
    father_husband_name VARCHAR(200),
    caste VARCHAR(100),
    profession VARCHAR(200),
    native_place VARCHAR(200),
    certifying_witnesses TEXT,
    residence TEXT,
    places_visited TEXT,
    offender_class VARCHAR(100),
    
    -- Page 2: Physical Description
    age INTEGER,
    height VARCHAR(50),
    build VARCHAR(50),
    hair_color VARCHAR(50),
    is_bald BOOLEAN,
    hair_cut_style VARCHAR(100),
    eyebrows VARCHAR(50),
    forehead VARCHAR(50),
    eyes VARCHAR(50),
    iris_color VARCHAR(50),
    sight VARCHAR(50),
    appearance VARCHAR(100),
    walk VARCHAR(100),
    talk VARCHAR(100),
    
    -- Page 3: Facial Features
    nose VARCHAR(50),
    mouth VARCHAR(50),
    lips VARCHAR(50),
    teeth VARCHAR(50),
    finger VARCHAR(50),
    chin VARCHAR(50),
    ears VARCHAR(50),
    face VARCHAR(50),
    complexion VARCHAR(50),
    moustache_style VARCHAR(50),
    beard_details TEXT,
    moustache_details TEXT,
    other_description TEXT,
    
    -- Page 4: Marks and Mannerisms
    marks_hands TEXT,
    marks_face TEXT,
    marks_knees TEXT,
    marks_feet TEXT,
    peculiarities TEXT,
    appearance_details TEXT,
    deformities TEXT,
    accomplishments TEXT,
    habits TEXT,
    
    -- Page 5: Social and Crime History
    relatives TEXT,
    associates TEXT,
    property_disposal TEXT,
    past_arrests TEXT,
    crime_localities TEXT,
    criminal_history TEXT,
    suspicion_cases TEXT,
    convictions TEXT,
    current_doings TEXT,
    
    -- Photos as BYTEA (actual binary image blobs)
    full_face_photo BYTEA,
    full_length_photo BYTEA,
    head_shoulder_photo BYTEA,
    profile_left_photo BYTEA,
    profile_right_photo BYTEA,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
