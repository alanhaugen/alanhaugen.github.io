for i in ../data/NC/*.csv; do
    awk -f process_nc.awk $i
done
