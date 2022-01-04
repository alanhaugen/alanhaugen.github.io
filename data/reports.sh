# Nucleocounter data format:
#  1 Source ID:	20210920-00002
#  2 Time (UTC):	2021-09-20 14:06:10
#  3 Sample ID:	
#  4 Protocol:	Count & Viability; 1.40 
#  5 Software version:	2.1.0.5
#  6 Secure Mode status:	Disabled
#  7 Signed by:	
#  8 Sample Media:	Via2-Cassette
#  9 User:	win10lab
# 10 Operator:	alan
# 11 Instrument:	S/N:9002020022100763
# 12 Tags:	
# 13 Comments:	
# 14 Total (cells/ml):	5.73E+04
# 15 Live (cells/ml):	5.24E+04
# 16 Ded (cells/ml):	4.89E+03
# 17 Viability (%):	91.5
# 18 Diameter (um):	21.3
# 19 Aggregates (%):	15.9
# 20 Debris Index:	25
# 21 Dilution Factor:	1
# 22 Status:	OK

for ((j=1; j<=6; j++))
do
    echo "#index $j\n# X Y\n"

    for i in ../data/NC/*.csv; do
        date_and_time=`awk -F "\t" 'NR == 2 { print $2 }' $i`
        sample_id=`awk -F "\t" 'NR == 3 { print $2 }' $i`
        total_cells_scientific=`awk -F "\t" 'NR == 14 { print $2 }' $i`
        live_cells_scientific=`awk -F "\t" 'NR == 15 { print $2 }' $i`
        diameter=`awk -F "\t" 'NR == 18 { print $2 }' $i`
        viability=`awk -F "\t" 'NR == 17 { print $2 }' $i`

        number=`echo $live_cells_scientific | sed -e 's/E.*//'`
        decimals=`echo $live_cells_scientific | sed -e 's/.*E+//'`
        live_cells=`echo $number \* 10^$decimals | bc` 
         
        date_1=`echo $date_and_time | sed -e 's/[[:space:]].*$//'` 
        date=`echo $data | sed -e 's/-//'` 

        sample_quantity=`echo $sample_id|grep -Eo '[0-9]+ml'`
        sample_quantity=`echo $sample_quantity|sed -e 's/ml//'`

        if [ -z "$sample_quantity" ]
        then
            sample_quantity=15
        fi

    # TODO: if log exists for date (which it should; make warning if not) display it
        if [[ "$sample_id" == *[Ff]$j* ]]
        then
            live_cells_total=`echo $live_cells \* $sample_quantity | bc`

            echo "  " $date $live_cells_total \#$i $live_cells $sample_id $sample_quantity #$i $sample_id
            #cat ../log/$date
        fi

    done

    echo "\n\n"
done
