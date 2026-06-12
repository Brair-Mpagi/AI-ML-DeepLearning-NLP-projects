-- Cleanup Malformed URLs from Missing Links Queue
-- Run this SQL script to remove all malformed URLs with recursive encoding

-- First, let's see how many malformed URLs we have
SELECT 
    'Total malformed URLs' as description,
    COUNT(*) as count
FROM scrape_link_queue 
WHERE page_url LIKE '%?p=%?p=%' 
   OR page_url LIKE '%?p=%/%?p=%'
   OR page_url LIKE '%2F%3Fp%3D%'
   OR page_url REGEXP '\\?p=[^&]*\\?p='
UNION ALL
SELECT 
    'Total in queue' as description,
    COUNT(*) as count
FROM scrape_link_queue;

-- Show some examples before deletion
SELECT 'Examples of malformed URLs to be deleted:' as info;
SELECT page_url, status, discovered_at
FROM scrape_link_queue 
WHERE page_url LIKE '%?p=%?p=%' 
   OR page_url LIKE '%?p=%/%?p=%'
   OR page_url LIKE '%2F%3Fp%3D%'
   OR page_url REGEXP '\\?p=[^&]*\\?p='
LIMIT 10;

-- DELETE THE MALFORMED URLs
-- Uncomment the line below to actually delete (remove the -- at the start)
-- DELETE FROM scrape_link_queue 
-- WHERE page_url LIKE '%?p=%?p=%' 
--    OR page_url LIKE '%?p=%/%?p=%'
--    OR page_url LIKE '%2F%3Fp%3D%'
--    OR page_url REGEXP '\\?p=[^&]*\\?p=';

-- After deletion, check remaining counts
SELECT 
    'After cleanup - Total in queue' as description,
    COUNT(*) as count
FROM scrape_link_queue
UNION ALL
SELECT 
    'After cleanup - Pending' as description,
    COUNT(*) as count
FROM scrape_link_queue 
WHERE status = 'pending';
