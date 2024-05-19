set search_path to pacilflix;
CREATE OR REPLACE FUNCTION update_if_exists()
RETURNS TRIGGER AS $$
BEGIN
   IF EXISTS (
        SELECT 1
        FROM transaction
        WHERE 
            NEW.username = username AND
            NEW.start_date_time BETWEEN start_date_time AND end_date_time
    ) THEN
        UPDATE transaction
        SET
            end_date_time = NEW.end_date_time,
            nama_paket = NEW.nama_paket,
            metode_pembayaran = NEW.metode_pembayaran,
            timestamp_pembayaran = NEW.timestamp_pembayaran
        WHERE
            username = NEW.username AND
            NEW.start_date_time BETWEEN start_date_time AND end_date_time;
        RETURN NULL;
ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_inser
BEFORE INSERT ON transaction
FOR EACH ROW
EXECUTE FUNCTION update_if_exists();