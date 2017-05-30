cat temps | grep -v ",$" | grep -v ",\." | grep -v ",[0-9]\." | grep -v ",0$" | grep -v ",28" | grep -v ",81" | grep -v ",10" | grep -v ",11" | grep -v ",88" | grep -v ",0^" | grep -v ",-" > temps.csv
gnuplot temp.plt
