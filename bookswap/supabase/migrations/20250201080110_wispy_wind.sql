/*
  # Add contact email to books table

  1. Changes
    - Add `contact_email` column to `books` table
    - Make it required (NOT NULL)

  2. Notes
    - Using DO block to safely add column if it doesn't exist
    - No data will be lost as this is only adding a new column
*/

DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'books' AND column_name = 'contact_email'
  ) THEN
    ALTER TABLE books ADD COLUMN contact_email text NOT NULL;
  END IF;
END $$;