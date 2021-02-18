-- Select the csv to import to iCloud keychain
set theFile to (choose file with prompt "Select the CSV file")

-- Read csv file
set f to read theFile

-- Split lines into records
set recs to paragraphs of f

-- Open safari passwords screen, check it is unlocked, do not allow to proceed until it is unlocked or user clicks cancel.
tell application "System Events"
	tell application process "Safari"
		set frontmost to true
		keystroke "," using command down
		tell window 1

			-- Change Passwords to your language equivalent! 1/4

			click button "Passwords" of toolbar 1 of it

			-- Change Add to your language equivalent! 2/4

			repeat until (exists button "Add" of group 1 of group 1 of it)

				-- Change Add to your language equivalent! 3/4

				if not (exists button "Add" of group 1 of group 1 of it) then
					display dialog "To begin importing, unlock Safari passwords then click OK. Please do not use your computer until the process has completed." with title "CSV to iCloud Keychain"
				end if
			end repeat
		end tell
	end tell
end tell

-- getting values for each record
set vals to {}
set AppleScript's text item delimiters to ","
repeat with i from 1 to length of recs
	set end of vals to text items of (item i of recs)
	set kcURL to text item 1 of (item i of recs)
	set kcUsername to text item 2 of (item i of recs)
	set kcPassword to text item 3 of (item i of recs)
	
	-- Write kcURL, kcUsername and kcPassword into text fields of safari passwords
	tell application "System Events"
		tell application process "Safari"
			set frontmost to true
			tell window 1
				
				-- Change Add to your language equivalent! 4/4

				click button "Add" of group 1 of group 1 of it
				
				-- Write fields

				tell application "System Events" to keystroke kcURL
				keystroke tab
				tell application "System Events" to keystroke kcUsername
				keystroke tab
				tell application "System Events" to keystroke kcPassword

				-- Include enough delays to allow user to stop the script execution when a repeated password is detected (the OK button will NOT be enabled). Please make sure that:

				-- -> All the imported passwords are NOT already in the iCloud Keychain
				-- -> The fields to write the password details are empty (and with the focus on the first one, see screenshot) BEFORE running the script! (Because maybe you need to stop it to fix some CSV line, make sure the fields are like in the screenshot with the dialog closed BEFORE running the script)
				-- -> All CSV lines END WITH a domain: Safari does NOT accept password sites like "example", but only "example.com", careful when migrating from third-party apps.

				delay 5
				keystroke tab
				delay 0.5
				keystroke tab
				delay 0.5
				keystroke tab
				
				keystroke return
			end tell
		end tell
	end tell
end repeat