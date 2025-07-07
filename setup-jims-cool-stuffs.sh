#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
SOURCE_FOLDER="jims-config-files-and-handy-utilities-for-others"
DESTINATION_FILE="${HOME}/"

cd $SCRIPT_DIR
DIRECTORY_JIMS_FILES=$(find . -type d -name "jims-config-files-and-handy-utilities-for-others" -print -quit | xargs readlink -f)

if [ -n "$DIRECTORY_JIMS_FILES" ]; then
	echo "Starting to move files..."
	sleep 2
else
	echo "The '$SOURCE_FOLDER' folder not found."
	exit 1
fi 

# Change to Jim's files directory
cd "$DIRECTORY_JIMS_FILES" || exit 1

counter=0
# Loop throgh all files in the Jim's cool folder
for FILE in * .bashrc .gitconfig .gitmessage; do 
	echo "Processing file: $FILE"
	sleep .2
        echo "Copying: '$FILE' to '$DESTINATION_FILE'..."
	if [[ -f "$FILE" ]] then
		cp "$FILE" "$DESTINATION_FILE"
	else
	        cp -r "$FILE" "$DESTINATION_FILE"
	fi

        # Check the exit status of the cp command to confirm completation
        if [ $? -eq 0 ]; then
               echo "'$FILE' copied successfully"
        else
               echo "Error: '$FILE' copy failed."
	       ((counter++))
        fi
done



# Check the exit status of the cp command to confirm completation
if [ $counter -eq 0 ]; then
	# Everything is good so proceed to source .bashrc
	echo "Executing .bashrc contents"
	source "$DESTINATION_FILE.bashrc"
	wait 
        echo "Done!, enjoy the jim's configuration for git cool stuffs"
else
	echo "Errors: File copy failed."
	exit 1
fi

