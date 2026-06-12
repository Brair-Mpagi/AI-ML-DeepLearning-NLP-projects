#!/bin/bash

# Fix Scraper Pause Issue - Automated Script
# Run this to kill old processes and prepare for fresh scraping

echo "=========================================="
echo "Fixing Scraper Pause Issue"
echo "=========================================="
echo ""

# Step 1: Kill all running scraper processes
echo "Step 1: Killing all web_scraper.py processes..."
pkill -9 -f "web_scraper.py"
sleep 2

# Verify they're gone
RUNNING=$(ps aux | grep web_scraper.py | grep -v grep | wc -l)
if [ $RUNNING -eq 0 ]; then
    echo "✓ All scraper processes killed"
else
    echo "⚠ Warning: $RUNNING processes still running"
    ps aux | grep web_scraper.py | grep -v grep
fi
echo ""

# Step 2: Clear status files
echo "Step 2: Clearing temporary status files..."
rm -f /tmp/scrape_missing_*.json
rm -f /tmp/scrape_missing_*.log
rm -f /tmp/scan_missing_*.json
echo "✓ Status files cleared"
echo ""

# Step 3: Reset database status
echo "Step 3: Resetting database status..."
mysql -u root campus_ai_chatbot -e "UPDATE scrape_link_queue SET status='pending' WHERE status='scraping';" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✓ Database status reset"
    
    # Show pending count
    PENDING=$(mysql -u root campus_ai_chatbot -se "SELECT COUNT(*) FROM scrape_link_queue WHERE status='pending';" 2>/dev/null)
    echo "✓ Pending URLs: $PENDING"
else
    echo "⚠ Could not connect to database (you may need to enter password manually)"
    echo "Run this command manually:"
    echo "  mysql -u root -p campus_ai_chatbot -e \"UPDATE scrape_link_queue SET status='pending' WHERE status='scraping';\""
fi
echo ""

# Step 4: Instructions
echo "=========================================="
echo "✓ Fix Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Go to http://localhost/Admin-F/web_scraper.php"
echo "2. Click 'Missing Links Queue' tab"
echo "3. Select your source"
echo "4. Click 'Scrape Pending' button"
echo ""
echo "The scraper will now process ALL pending URLs without stopping!"
echo ""
echo "To monitor progress:"
echo "  tail -f /tmp/scrape_missing_1.log"
echo ""
