#!/bin/bash

while true; do

	# Take photo using current date	
	DATE=$(date +"%Y-%m-%d-%H%M")
	raspistill -vf -hf -o $DATE.jpg

	ARRAY=()
	X=0

	# Try different thresholds
	for I in 90 80 70 60 50 40 30 20 10; do

		# Ensure there is at least PIX pixels
		for PIX in 50 20 5; do
			
			# Shear image by different amounts 
			for SHEAR in 65 10; do

				Z=$(../../ssocr/ssocr -d3 -i$PIX rotate 359 crop 600 825 1230 550 shear $SHEAR -t$I -f white ${DATE}.jpg -o dump.jpg)
	
				# Ensure exit code was 0, meaning OCR detected numbers of 3 digits
				if [ $? -eq 0 ] && [ "${Z: -1}" != "-" ]; then
					echo $Z
					# Store number from OCR as integer, convert b to 6 
					# (as ssocr sometimes thinks 6 is B in hex)
					NUMI=$(echo "$(echo $Z | sed "s/b/6/g")" | bc)	
					((ARRAY[$NUMI]++))
					X=1
				fi
			done
		done 
	done

	if [ $X -eq 0 ]; then
		# Failed to detect display correctly	
		echo ${DATE} >> bad
	else
		LOW=0
		LVAL=-1

		# Find best value out of possible candidate OCRd values
		for var in "${!ARRAY[@]}";
		do	
			# Check if this number appears the most common	
			if [ ${ARRAY[$var]} -gt $LOW ]; then
				LOW=${ARRAY[$var]}
				LVAL=$var
			fi
		done
		
		# Convert number to decimal
		NUM=$(echo "scale = 2; $LVAL / 10" | bc)

		# Write number to CSV
		echo "${DATE},$NUM" >> temps
		
		rm ${DATE}.jpg
	fi

	sleep 60
done
