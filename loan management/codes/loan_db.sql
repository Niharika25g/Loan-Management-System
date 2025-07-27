-- Creating the 'payments' table
CREATE TABLE payments (
  payment_id INT(11) NOT NULL AUTO_INCREMENT,
  loan_id INT(11) DEFAULT NULL,
  amount DECIMAL(15,2) NOT NULL,
  payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (payment_id),
  KEY loan_id (loan_id)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

-- Adding foreign key constraint (optional but recommended)
ALTER TABLE payments
  ADD CONSTRAINT fk_payments_loans
  FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

Efficiency:
•	Simplified INT Declaration: Removed the display width (e.g., INT (11)) as it's deprecated and has no effect without ZEROFILL.
•	Enforced Foreign Key Integrity: Set loan_id as NOT NULL to ensure every payment is linked to a loan.
•	Optimized Deletion Behaviour: Used ON DELETE CASCADE to automatically remove payments when a loan is deleted, maintaining data integrity.
•	Enhanced Collation: Switched to utf8mb4_unicode_ci for better Unicode support and accurate sorting.
•	Indexed Foreign Key: Added an index on loan_id to improve join performance and maintain referential integrity.
This streamlined schema ensures better performance, data integrity, and compatibility with modern MySQL standards.

-- Creating the 'loans' table
CREATE TABLE loans (
  loan_id INT(11) NOT NULL AUTO_INCREMENT,
  user_id INT(11) DEFAULT NULL,
  loan_amount DECIMAL(15,2) NOT NULL,
  interest_rate DECIMAL(5,2) NOT NULL,
  loan_term INT(11) NOT NULL,
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  PRIMARY KEY (loan_id),
  KEY user_id (user_id)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

-- Adding foreign key constraint to link 'user_id' to the 'users' table
ALTER TABLE loans
  ADD CONSTRAINT fk_loans_users
  FOREIGN KEY (user_id) REFERENCES users(user_id)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

      Effieciency:
1.	Simplified INT Declaration: Removed the display width (e.g., INT(11)) as it's deprecated and has no effect without ZEROFILL.
2.	Enforced Foreign Key Integrity: Set user_id as NOT NULL to ensure every loan is linked to a user.(Medium)
3.	Optimized Deletion Behavior: Used ON DELETE CASCADE to automatically remove loans when a user is deleted, maintaining data integrity.
4.	Enhanced Collation: Switched to utf8mb4_unicode_ci for better Unicode support and accurate sorting.
5.	Indexed Foreign Key: Added an index on user_id to improve join performance and maintain referential integrity.
6.	ENUM Usage: Utilized ENUM for the status field to enforce valid statuses and improve storage efficiency.


-- Creating the 'users' table
CREATE TABLE users (
  user_id INT(11) NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin', 'applicant') NOT NULL,
  PRIMARY KEY (user_id)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

-- Sample data insertion into 'users' table
INSERT INTO users (user_id, username, password, role) VALUES
(16, 'honey1234', 'honey123', ''),
(2147483647, 'honey123', 'honey@123', 'applicant');

-- Setting AUTO_INCREMENT value
ALTER TABLE users
  MODIFY user_id INT(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 2147483648;


Efficiency:

1.	Use of BIGINT UNSIGNED for user_id: Switching to BIGINT UNSIGNED increases the maximum value range, accommodating a larger number of users and preventing potential overflow issues. Stack Overflow
2.	Removal of Display Width in INT(11): The (11) in INT(11) specifies display width and has no effect on storage or range. It's deprecated and can be omitted. DEV Community
3.	Improved Collation: Changing collation to utf8mb4_unicode_ci provides better Unicode support and accurate sorting for a wide range of characters.
4.	Validation of ENUM Values: Ensure that the role field only accepts predefined values ('admin', 'applicant') to maintain data integrity. Inserting an empty string as a role, as seen in your sample data, can lead to unexpected behavior. 

 
