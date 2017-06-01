# Target temp value set on Inkbird
# Used to strip out values less than target-7 or greater target+7
# which are likely due to incorrect OCRing

TARGET="20.0"

LTARGET=$(echo "$TARGET - 7" | bc)
HTARGET=$(echo "$TARGET + 7" | bc)

cat temps | awk -F, '{ if ($2 >= $LTARGET && $2 <= $HTARGET ) print $1 "," $2 }' > temps.csv

gnuplot temp.plt
