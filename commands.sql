CREATE TABLE profile (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE experience (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  company VARCHAR(255),
  start_date DATE,
  end_date DATE
);

CREATE TABLE contact (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50)
);

INSERT INTO profile (name) VALUES ('Kosa Eszter');
INSERT INTO experience (title, company, start_date, end_date) VALUES ('DevOps Engineer', 'abc', '2024-01-01', '2025-10-01');
INSERT INTO contact (email, phone) VALUES ('kosa@example.com', '+1234567890');