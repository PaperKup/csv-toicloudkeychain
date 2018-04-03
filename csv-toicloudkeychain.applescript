-- select the csv to import to iCloud keychain
set theFile to (choose file with prompt "Select the CSV file")

-- read csv file
set f to read theFile

-- split lines into records
set recs to paragraphs of f

-- open safari passwords screen, check it is unlocked, do not allow to proceed until it is unlocked or user clicks cancel.
tell application "System Events"
	tell application process "Safari"
		set frontmost to true
		keystroke "," using command down
		tell window 1
			click button "Passwords" of toolbar 1 of it
			repeat until (exists button "Add" of group 1 of group 1 of it)
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
	
	-- write kcURL, kcUsername and kcPassword into text fields of safari passwords
	tell application "System Events"
		tell application process "Safari"
			set frontmost to true
			tell window 1
				
				click button "Add" of group 1 of group 1 of it
				-- write fields
				tell last row of table 1 of scroll area of group 1 of group 1 of it
					set value of text field 1 of it to kcURL
					keystroke tab
					set value of text field 2 of it to kcUsername
					keystroke tab
					set value of text field 3 of it to kcPassword
					keystroke return
				end tell
				
			end tell
		end tell
	end tell
end repeat


