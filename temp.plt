set key off
set term png
set term png size 1000,400
set output 'inkbird.png'
set datafile separator ','
set yrange [10:30]
set xdata time
set timefmt '%Y-%m-%d-%H%M'
set format x "%d %b %Y"
set xtics format "%d %b %Y %H\:%M"
set xtics rotate 90
set xtics 86400
plot 'temps.csv' using 1:2 with lines 
