/*
  # Add contact email to books table

  1. Changes
    - Add `contact_email` column to `books` table as nullable first
    - Set a default value for existing records
    - Then make it NOT NULL

  2. Notes
    - Safe migration that handles existing records
    - Uses multiple steps to avoid null value errors
*/

DO $$ 
BEGIN
  -- First add the column as nullable
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'books' AND column_name = 'contact_email'
  ) THEN
    -- Add column as nullable first
    ALTER TABLE books ADD COLUMN contact_email text;
    
    -- Update existing records with a default value
    UPDATE books 
    SET contact_email = profiles.email 
    FROM profiles 
    WHERE books.user_id = profiles.id;
    
    -- Now make it NOT NULL
    ALTER TABLE books ALTER COLUMN contact_email SET NOT NULL;
  END IF;
END $$;