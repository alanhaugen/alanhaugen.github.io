BEGIN {
    FS = "\t"
}

NR == 2 {
    print $2
}

NR == 3 {
    print $2
}

NR == 10 {
    print $2
}
