CREATE TABLE subdivision (
  sub_id CHAR(2) PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE station (
  station_id CHAR(2) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  sub_id CHAR(2) REFERENCES subdivision(sub_id)
);

--assuming the data provided is in toto ⟵⁠(⁠o⁠_⁠O⁠)
INSERT INTO subdivision (sub_id, name) VALUES
('01', 'Jeeyapuram'),
('02', 'Thiruverumbur'),
('03', 'Lalkudi'),
('04', 'Musiri'),
('05', 'Manapparai');

INSERT INTO station (station_id, name, sub_id) VALUES
('01', 'Jeeyapuram', '01'),
('02', 'Pettavaithalai', '01'),
('03', 'Vathalai', '01'),
('04', 'Mannachanallur', '01'),
('05', 'Pulivalam', '01'),
('06', 'Somarasampettai', '01'),
('07', 'Ramji Nagar', '01'),
('08', 'Inamkulathur', '01'),
('09', 'Thiruverumbur', '02'),
('10', 'Thuvakudi', '02'),
('11', 'Navalpattu', '02'),
('12', 'Manikandam', '02'),
('13', 'Lalgudi', '03'),
('14', 'Kallakudi', '03'),
('15', 'Siruganur', '03'),
('16', 'K K Nallur', '03'),
('17', 'Samayapuram', '03'),
('18', 'Kollidam', '03'),
('19', 'Musiri', '04'),
('20', 'Thottiyam', '04'),
('21', 'Kattuputhur', '04'),
('22', 'Jambunathapuram', '04'),
('23', 'Thuraiyur', '04'),
('24', 'Uppiliyapuram', '04'),
('25', 'Manapparai', '05'),
('26', 'Vaiyampatti', '05'),
('27', 'Thuvarankurichi', '05'),
('28', 'Valanadu', '05');
