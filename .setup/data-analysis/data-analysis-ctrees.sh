#!/bin/bash

# type1 ---------------------------------------------------------------------------
TabSize=2
FilePath='type1.txt'

CloseEnclosures(){
	# Get the difference between tabbing of this entry and the previous
	TabDiff=$(( LastTabCount - TabCount ))

	# Apply closures relative to the difference and close the previous entry.
	for (( i = 0; i <= $TabDiff; i++ )); do
		printf '%*s' $(( ( LastTabCount - i ) * TabSize ))
		printf ']\n'
	done
}

printf -v OneTab '%*s' $TabSize
Re='( *)'
LastTabCount=
while IFS= read -r Line; do
	# Parse the padding and count it relative to tab size
	[[ $Line =~ $Re ]]
	Padding=${BASH_REMATCH[1]}
	TabCount=$(( ${#Padding} / TabSize ))

	# Close enclosure(s) relative to the hierarchical position of the previous entry
	[[ $LastTabCount ]] && CloseEnclosures

	# Open enclosure and print the line with an extra tab
	printf '%s\n%s\n' "$Padding[" "$OneTab$Line"

	LastTabCount=$TabCount

done < "$FilePath"

# Close remaining enclosure(s)
TabCount=0
CloseEnclosures



# power ---------------------------------------------------------------------------
TabSize=2
FilePath='power.txt'

CloseEnclosures(){
	# Get the difference between tabbing of this entry and the previous
	TabDiff=$(( LastTabCount - TabCount ))

	# Apply closures relative to the difference and close the previous entry.
	for (( i = 0; i <= $TabDiff; i++ )); do
		printf '%*s' $(( ( LastTabCount - i ) * TabSize ))
		printf ']\n'
	done
}

printf -v OneTab '%*s' $TabSize
Re='( *)'
LastTabCount=
while IFS= read -r Line; do
	# Parse the padding and count it relative to tab size
	[[ $Line =~ $Re ]]
	Padding=${BASH_REMATCH[1]}
	TabCount=$(( ${#Padding} / TabSize ))

	# Close enclosure(s) relative to the hierarchical position of the previous entry
	[[ $LastTabCount ]] && CloseEnclosures

	# Open enclosure and print the line with an extra tab
	printf '%s\n%s\n' "$Padding[" "$OneTab$Line"

	LastTabCount=$TabCount

done < "$FilePath"

# Close remaining enclosure(s)
TabCount=0
CloseEnclosures

# miss ---------------------------------------------------------------------------

TabSize=2
FilePath='miss.txt'

CloseEnclosures(){
	# Get the difference between tabbing of this entry and the previous
	TabDiff=$(( LastTabCount - TabCount ))

	# Apply closures relative to the difference and close the previous entry.
	for (( i = 0; i <= $TabDiff; i++ )); do
		printf '%*s' $(( ( LastTabCount - i ) * TabSize ))
		printf ']\n'
	done
}

printf -v OneTab '%*s' $TabSize
Re='( *)'
LastTabCount=
while IFS= read -r Line; do
	# Parse the padding and count it relative to tab size
	[[ $Line =~ $Re ]]
	Padding=${BASH_REMATCH[1]}
	TabCount=$(( ${#Padding} / TabSize ))

	# Close enclosure(s) relative to the hierarchical position of the previous entry
	[[ $LastTabCount ]] && CloseEnclosures

	# Open enclosure and print the line with an extra tab
	printf '%s\n%s\n' "$Padding[" "$OneTab$Line"

	LastTabCount=$TabCount

done < "$FilePath"

# Close remaining enclosure(s)
TabCount=0
CloseEnclosures
