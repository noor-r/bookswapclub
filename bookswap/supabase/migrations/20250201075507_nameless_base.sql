/*
  # Create Storage Bucket for Book Images

  1. New Storage Bucket
    - Create 'book-images' bucket for storing book cover images
  
  2. Security
    - Enable public access for viewing images
    - Add policies for authenticated users to upload images
*/

-- Create the storage bucket for book images
INSERT INTO storage.buckets (id, name, public)
VALUES ('book-images', 'book-images', true);

-- Allow authenticated users to upload images
CREATE POLICY "Allow authenticated users to upload images"
ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'book-images'
  AND auth.role() = 'authenticated'
);

-- Allow public access to view images
CREATE POLICY "Allow public to view images"
ON storage.objects
FOR SELECT
TO public
USING (bucket_id = 'book-images');