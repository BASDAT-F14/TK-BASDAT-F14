-- Stored Procedure untuk Menambahkan Ulasan
CREATE OR REPLACE FUNCTION pacilflix.add_ulasan (
    p_user_id UUID,
    p_tayangan_id UUID,
    p_review_text TEXT,
    p_rating INT
)
RETURNS VOID AS $$
DECLARE
    ulasan_count INT;
BEGIN
    -- Cek apakah pengguna sudah memberikan ulasan untuk tayangan ini
    SELECT COUNT(*) INTO ulasan_count
    FROM pacilflix.ulasan
    WHERE user_id = p_user_id AND tayangan_id = p_tayangan_id;

    IF ulasan_count > 0 THEN
        RAISE EXCEPTION 'Pengguna sudah pernah memberikan ulasan untuk tayangan ini.';
    ELSE
        -- Insert ulasan baru
        INSERT INTO pacilflix.ulasan (user_id, tayangan_id, review_text, rating)
        VALUES (p_user_id, p_tayangan_id, p_review_text, p_rating);
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Trigger untuk Mengecek Ulasan Sebelum Insert
CREATE OR REPLACE FUNCTION pacilflix.check_ulasan_exists()
RETURNS TRIGGER AS $$
DECLARE
    ulasan_count INT;
BEGIN
    -- Cek apakah pengguna sudah memberikan ulasan untuk tayangan ini
    SELECT COUNT(*) INTO ulasan_count
    FROM pacilflix.ulasan
    WHERE user_id = NEW.user_id AND tayangan_id = NEW.tayangan_id;

    IF ulasan_count > 0 THEN
        RAISE EXCEPTION 'Pengguna sudah pernah memberikan ulasan untuk tayangan ini.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_ulasan_insert
BEFORE INSERT ON pacilflix.ulasan
FOR EACH ROW
EXECUTE FUNCTION pacilflix.check_ulasan_exists();
