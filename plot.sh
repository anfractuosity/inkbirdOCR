# Target temp value set on Inkbird
# Used to strip out values less than target-7 or greater target+7
# which are likely due to incorrect OCRing

TARGET="20.0"

export LTARGET=$(echo "$TARGET - 7" | bc)
export HTARGET=$(echo "$TARGET + 7" | bc)

# Hopefully not needed anymore
#cat temps | awk -F, '{ if ($2 >= ENVIRON["LTARGET"] && $2 <= ENVIRON["HTARGET"]) print $1 "," $2}' > temps.csv

cat temps > temps.csv

gnuplot temp.plt
