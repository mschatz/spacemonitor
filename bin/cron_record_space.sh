#!/bin/sh

outdir=/var/www/vhosts/yellowstone.cshl.edu/spacemonitor

/root/bin/record_space.sh /seq/schatz $outdir/seq-schatz &
/root/bin/record_space.sh /bluearc/data/schatz $outdir/bluearc-data-schatz &
/root/bin/record_space.sh /bluearc/data/schatz2 $outdir/bluearc-data-schatz2 &
/root/bin/record_space.sh /bluearc/datafc/schatz $outdir/bluearc-datafc-schatz &
/root/bin/record_space.sh /bluearc/home/schatz $outdir/bluearc-home-schatz &
/root/bin/record_space.sh /sonas-hs/schatz/hpc/data $outdir/sonas-hs-schatz &
/root/bin/record_space.sh /home $outdir/yellowstone-home &

wait
