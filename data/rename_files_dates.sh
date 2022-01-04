# TODO: Make PROJECT_ROOT variable
for i in *; do
    newname=`echo $i|awk -f ~/master/scripts/rename_files_dates.awk` # TODO: Change ~/master to $PROJECT_ROOT
    echo "renaming: " $i " => " $newname
    mv $i $newname
done
