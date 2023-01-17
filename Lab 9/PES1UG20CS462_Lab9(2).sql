CREATE TABLE backup_transactions(transaction_id INT PRIMARY KEY, bank VARCHAR(20), card_no BIGINT, price DECIMAL(10, 2), pnr VARCHAR(10));

DELIMITER $$
CREATE TRIGGER backup_transact
BEFORE DELETE
ON ticket FOR EACH ROW
BEGIN
INSERT into backup_transactions SELECT * FROM payment_info WHERE pnr = OLD.pnr;
DELETE FROM payment_info WHERE pnr = OLD.pnr;
DELETE FROM ticket_passenger WHERE pnr = OLD.pnr;
END;
$$
DELIMITER ;
