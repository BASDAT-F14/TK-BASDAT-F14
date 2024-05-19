set search_path to pacilflix;
-- Step 1: Create the function
CREATE OR REPLACE FUNCTION check_existing_username()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the username already exists
    IF EXISTS (
        SELECT 1
        FROM pengguna
        WHERE username = NEW.username
    ) THEN
        -- Raise an exception if username exists
        RAISE EXCEPTION 'Username % already exists.', NEW.username;
    END IF;
    -- Proceed with the insert if no existing username is found
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Step 2: Create the trigger
CREATE TRIGGER before_insert_pengguna_trigger
BEFORE INSERT ON pengguna
FOR EACH ROW
EXECUTE FUNCTION check_existing_username();