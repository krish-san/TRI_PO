-- Create main POLICE_PERSONNEL table
CREATE TABLE police_personnel (
    personnel_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    rank VARCHAR(50) NOT NULL,
    g_number VARCHAR(20) UNIQUE NOT NULL,
    station VARCHAR(100) NOT NULL,
    date_of_enlistment DATE NOT NULL,
    date_of_promotion DATE,
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create PERSONAL_INFO table
CREATE TABLE personal_info (
    info_id SERIAL PRIMARY KEY,
    personnel_id INTEGER NOT NULL,
    cps_number VARCHAR(30),
    ifhrms_number VARCHAR(30),
    contact_number VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_personal_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES police_personnel(personnel_id)
        ON DELETE CASCADE
);

-- Create FAMILY_INFO table
CREATE TABLE family_info (
    family_id SERIAL PRIMARY KEY,
    personnel_id INTEGER NOT NULL,
    father_name VARCHAR(100),
    marital_status VARCHAR(20),
    spouse_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_family_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES police_personnel(personnel_id)
        ON DELETE CASCADE
);

-- Create ADDRESS_INFO table
CREATE TABLE address_info (
    address_id SERIAL PRIMARY KEY,
    personnel_id INTEGER NOT NULL,
    permanent_address TEXT NOT NULL,
    present_address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_address_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES police_personnel(personnel_id)
        ON DELETE CASCADE
);

-- Create FINANCIAL_INFO table
CREATE TABLE financial_info (
    finance_id SERIAL PRIMARY KEY,
    personnel_id INTEGER NOT NULL,
    bank_name VARCHAR(100) NOT NULL,
    account_number VARCHAR(30) NOT NULL,
    ifsc_code VARCHAR(20) NOT NULL,
    branch VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_financial_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES police_personnel(personnel_id)
        ON DELETE CASCADE
);

-- Create IDENTITY_INFO table
CREATE TABLE identity_info (
    identity_id SERIAL PRIMARY KEY,
    personnel_id INTEGER NOT NULL,
    aadhar_number VARCHAR(20) UNIQUE,
    pan_number VARCHAR(20) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_identity_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES police_personnel(personnel_id)
        ON DELETE CASCADE
);

-- Create PROFILE_DETAILS table
CREATE TABLE profile_details (
    profile_id SERIAL PRIMARY KEY,
    personnel_id INTEGER NOT NULL,
    religion VARCHAR(50),
    community VARCHAR(50),
    caste VARCHAR(50),
    education TEXT,
    blood_group VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_profile_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES police_personnel(personnel_id)
        ON DELETE CASCADE
);

-- Create SERVICE_HISTORY table
CREATE TABLE service_history (
    history_id SERIAL PRIMARY KEY,
    personnel_id INTEGER NOT NULL,
    present_station_name VARCHAR(100) NOT NULL,
    present_station_join_date DATE NOT NULL,
    previous_station_name VARCHAR(255),
    previous_station_join_date DATE,
    previous_station_end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_history_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES police_personnel(personnel_id)
        ON DELETE CASCADE
);

-- Create PHOTOS table
CREATE TABLE photos (
    photo_id SERIAL PRIMARY KEY,
    personnel_id INTEGER NOT NULL,
    photo_type VARCHAR(50) NOT NULL, -- e.g., 'PROFILE', 'ID', etc.
    photo_file_path TEXT NOT NULL,
    upload_date DATE DEFAULT CURRENT_DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_photos_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES police_personnel(personnel_id)
        ON DELETE CASCADE
);

-- Add indexes for better performance
CREATE INDEX idx_personal_personnel_id ON personal_info(personnel_id);
CREATE INDEX idx_family_personnel_id ON family_info(personnel_id);
CREATE INDEX idx_address_personnel_id ON address_info(personnel_id);
CREATE INDEX idx_financial_personnel_id ON financial_info(personnel_id);
CREATE INDEX idx_identity_personnel_id ON identity_info(personnel_id);
CREATE INDEX idx_profile_personnel_id ON profile_details(personnel_id);
CREATE INDEX idx_service_personnel_id ON service_history(personnel_id);
CREATE INDEX idx_photos_personnel_id ON photos(personnel_id);

-- Create trigger functions to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- triggers for each table
CREATE TRIGGER update_police_personnel_modtime
    BEFORE UPDATE ON police_personnel
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_personal_info_modtime
    BEFORE UPDATE ON personal_info
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_family_info_modtime
    BEFORE UPDATE ON family_info
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_address_info_modtime
    BEFORE UPDATE ON address_info
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_financial_info_modtime
    BEFORE UPDATE ON financial_info
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_identity_info_modtime
    BEFORE UPDATE ON identity_info
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_profile_details_modtime
    BEFORE UPDATE ON profile_details
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_service_history_modtime
    BEFORE UPDATE ON service_history
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_photos_modtime
    BEFORE UPDATE ON photos
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();