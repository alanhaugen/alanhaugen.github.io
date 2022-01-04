BEGIN {
    FS = "\t"
}

NR == 2 {
    print $2
}
