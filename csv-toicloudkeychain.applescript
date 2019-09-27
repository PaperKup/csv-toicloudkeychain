-- change the delimiter if you have passwords containing ","
set csvDelim to ","

-- select the csv to import to iCloud keychain
set theFile to (choose file with prompt "Select the CSV file")

-- ask user for password to unlock Safari
set pwdDialog to display dialog "Enter password to unlock Safari" default answer "" buttons {"Cancel", "Continue"} default button "Continue" with hidden answer
set myPassword to text returned of pwdDialog

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
		end tell
	end tell
end tell

set abort to false

-- getting values for each record
set AppleScript's text item delimiters to csvDelim
repeat with i from 1 to length of recs
	-- skip remaining rows if aborted
	if abort then exit repeat
	
	set done to false
	
	-- ignore empty lines on the csv file
	if item i of recs is not "" then
		set kcURL to text item 1 of (item i of recs)
		set kcUsername to text item 2 of (item i of recs)
		set kcPassword to text item 3 of (item i of recs)
		
		-- repeat eatch entry until successfull (sometimes the screen locks mid-operation)
		repeat until (done)
			-- capture errors like button or fields no longer present on the screen
			try
				-- write kcURL, kcUsername and kcPassword into text fields of safari passwords
				tell application "System Events"
					tell application process "Safari"
						set frontmost to true
						tell window "Passwords"
							-- try to unlock the screen
							repeat until (exists button "Add" of group 1 of group 1 of it)
								log "Screen is locked, trying to unlock in 10 seconds"
								tell text field 1 of group 1 of group 1 of it
									-- wait for 10 seconds (Safari enters a high CPU usage loop when importing a large number of entries
									delay 10
									log "Typing password"
									set focused of it to true
									set value of it to myPassword
									confirm
								end tell
							end repeat
							
							click button "Add" of group 1 of group 1 of it
							-- write fields (using "set value of" fails to enable the "Add" button)
							tell sheet of it
								set focused of text field 1 to true
								keystroke kcURL
								
								set focused of text field 2 to true
								keystroke kcUsername
								
								set focused of text field 3 to true
								keystroke kcPassword
								
								if (enabled of button "Add Password") then
									click button "Add Password"
									set done to true
									log "Imported password for " & kcURL & " (" & kcUsername & ")" & " successfully"
								else
									-- Failed to add entry, cancel and proceed to the next row
									click button "Cancel"
									set done to true
									log "Failed to import password for " & kcURL
								end if
							end tell
						end tell
					end tell
				end tell
			on error errText
				log errText
				
				-- give the user 1 second to cancel the script (prevents runaway loops)
				delay 1
				
				-- user stopped the script
				if ((errText as string) contains "User cancelled") then
					log "Aborting due to user request"
					set abort to true
					exit repeat
				end if
			end try
		end repeat
	end if
end repeat


