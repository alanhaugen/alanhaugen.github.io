BEGIN {
    FS = "-"
}

{
    if (length($2) == 1) {
        $2 = 0$2
    }
    if (length($1) == 1) {
        $1 = 0$1
    }

    printf("%s-%s-%s-%s\n",$3,$2,$1,$4)
}
