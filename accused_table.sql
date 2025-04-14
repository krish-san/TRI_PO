-- Master table for accused individuals
CREATE TABLE accused (
    accused_id SERIAL PRIMARY KEY,
    history_sheet_number VARCHAR(50) NOT NULL,
    registration_date DATE,
    classification VARCHAR(100),
    kd_or_suspect VARCHAR(50),
    name VARCHAR(255) NOT NULL,
    aliases TEXT,
    father_husband_name VARCHAR(255),
    caste VARCHAR(100),
    trade_profession VARCHAR(255),
    native_place_district VARCHAR(100),
    native_place_police VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for certifying witnesses
CREATE TABLE certifying_witnesses (
    witness_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    witness_name VARCHAR(255) NOT NULL,
    father_name VARCHAR(255),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for residences of accused
CREATE TABLE residences (
    residence_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    place VARCHAR(255) NOT NULL,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for places visited by accused
CREATE TABLE places_visited (
    visit_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    place VARCHAR(255) NOT NULL,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for offender classification and MO details
CREATE TABLE offender_details (
    detail_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    offender_class VARCHAR(100),
    modus_operandi TEXT,
    transport_means VARCHAR(255),
    property_stolen VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for physical description
CREATE TABLE physical_description (
    description_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    age INTEGER,
    height_feet INTEGER,
    height_inches INTEGER,
    build VARCHAR(50),
    hair_color VARCHAR(50),
    hair_style VARCHAR(50),
    baldness BOOLEAN DEFAULT FALSE,
    eyebrows VARCHAR(50),
    forehead VARCHAR(50),
    eyes VARCHAR(50),
    eye_color VARCHAR(50),
    sight VARCHAR(50),
    wears_glasses BOOLEAN DEFAULT FALSE,
    nose VARCHAR(50),
    mouth VARCHAR(50),
    lips VARCHAR(50),
    teeth VARCHAR(50),
    fingers VARCHAR(50),
    finger_deformity VARCHAR(100),
    chin VARCHAR(50),
    ears VARCHAR(50),
    face VARCHAR(50),
    complexion VARCHAR(50),
    beard VARCHAR(100),
    beard_color VARCHAR(50),
    moustache VARCHAR(100),
    moustache_color VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for identifying marks
CREATE TABLE identifying_marks (
    mark_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    mark_location VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for behavioral traits
CREATE TABLE behavioral_traits (
    trait_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    peculiarities VARCHAR(255),
    appearance VARCHAR(255),
    deformity VARCHAR(255),
    accomplishments TEXT,
    habits TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for relatives
CREATE TABLE relatives (
    relative_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    name VARCHAR(255) NOT NULL,
    relationship VARCHAR(100),
    residence VARCHAR(255),
    police_station VARCHAR(100),
    occupation VARCHAR(255),
    history_reference TEXT,
    likely_to_visit BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for associates
CREATE TABLE associates (
    associate_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    name VARCHAR(255) NOT NULL,
    father_name VARCHAR(255),
    caste VARCHAR(100),
    residence VARCHAR(255),
    police_station VARCHAR(100),
    occupation VARCHAR(255),
    association_nature TEXT,
    history_reference TEXT,
    likely_to_visit BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for property disposal information
CREATE TABLE property_disposal_info (
    disposal_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    disposal_method TEXT,
    case_reference TEXT,
    receiver_details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for past arrests
CREATE TABLE past_arrests (
    arrest_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    arrest_date DATE,
    arrest_location VARCHAR(255),
    arrested_by VARCHAR(255),
    harboured_by VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for crime localities
CREATE TABLE crime_localities (
    locality_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    locality VARCHAR(255),
    is_favorite BOOLEAN DEFAULT FALSE,
    offences_committed TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for criminal history
CREATE TABLE criminal_history (
    history_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    history_details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for suspected cases
CREATE TABLE suspected_cases (
    case_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    section VARCHAR(100),
    modus_operandi TEXT,
    gif_number VARCHAR(100),
    district VARCHAR(100),
    station VARCHAR(100),
    crime_number VARCHAR(100),
    property_kind VARCHAR(255),
    case_summary TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for convictions and definite suspicions
CREATE TABLE convictions (
    conviction_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    section VARCHAR(100),
    modus_operandi TEXT,
    gif_number VARCHAR(100),
    station VARCHAR(100),
    crime_number VARCHAR(100),
    property_kind VARCHAR(255),
    court_cc_number VARCHAR(100),
    sentence_date DATE,
    sentence TEXT,
    fp_bureau_serial_number VARCHAR(100),
    fp_bureau_date DATE,
    identifying_witnesses TEXT,
    jail_number VARCHAR(100),
    release_date DATE,
    return_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for current doings
CREATE TABLE current_doings (
    doing_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    details TEXT,
    recorded_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for photographs
CREATE TABLE photographs (
    photo_id SERIAL PRIMARY KEY,
    accused_id INTEGER REFERENCES accused(accused_id),
    photo_type VARCHAR(50) NOT NULL, -- 'full_face', 'full_length', 'head_shoulders', 'profile_left', 'profile_right', 'peculiarity'
    photo_file_path VARCHAR(255),
    description TEXT,
    taken_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add indexes for frequently queried columns
CREATE INDEX idx_accused_name ON accused(name);
CREATE INDEX idx_accused_history_sheet ON accused(history_sheet_number);
CREATE INDEX idx_physical_desc_accused ON physical_description(accused_id);
CREATE INDEX idx_convictions_accused ON convictions(accused_id);
CREATE INDEX idx_relatives_accused ON relatives(accused_id);
CREATE INDEX idx_associates_accused ON associates(accused_id);
