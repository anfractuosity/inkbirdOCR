set key off
set term png transparent truecolor
set title "Fermentation Temperature" textcolor rgb "orange" font "Helvetica,50" 
set object 1 rectangle from graph 0, graph 0 to graph 1, graph 1 behind fc rgbcolor 'white' fs noborder
set term png size 2000,1400 font "Helvetica,30" 
set xtics textcolor rgb "orange" 
set ytics textcolor rgb "orange" 
set output 'inkbird.png'
set datafile separator ','
set yrange [3:25]
set xdata time
set timefmt '%Y-%m-%d-%H%M'
set format x "%d %b %Y"
set xtics format "%d %b %Y %H\:%M"
set xtics rotate 90
set xtics 86400
plot 'temps.csv' using 1:2 with lines 
