
-- Select the csv to import to iCloud keychain
set theFile to (choose file with prompt "Select the CSV file")

-- Read csv file
set f to read theFile

-- Split lines into records
set recs to paragraphs of f

-- getting values for each record
set vals to {}
set AppleScript's text item delimiters to ","
repeat with i from 1 to length of recs
	set end of vals to text items of (item i of recs)
	set kcURL to text item 1 of (item i of recs)
	set kcUsername to text item 2 of (item i of recs)
	set kcPassword to text item 3 of (item i of recs)
	
	activate application "Keychain Access"
	
	tell application "System Events" to tell application process "Keychain Access"
		keystroke "n" using {command down}
		
		-- Write fields
		delay 0.2
		tell application "System Events" to keystroke kcURL
		delay 0.2
		keystroke tab
		tell application "System Events" to keystroke kcUsername
		delay 0.2
		keystroke tab
		tell application "System Events" to keystroke kcPassword
		
		delay 0.2
		keystroke tab
		delay 0.2
		
		keystroke return
		delay 0.2
		keystroke return
		
		
	end tell
	
	
end repeat
