#!/bin/sh

/root/bin/record_space.sh /seq/schatz /var/www/html/spacemonitor/seq-schatz &
/root/bin/record_space.sh /bluearc/data/schatz /var/www/html/spacemonitor/bluearc-data-schatz &
/root/bin/record_space.sh /bluearc/data/schatz2 /var/www/html/spacemonitor/bluearc-data-schatz2 &
/root/bin/record_space.sh /bluearc/datafc/schatz /var/www/html/spacemonitor/bluearc-datafc-schatz &
/root/bin/record_space.sh /bluearc/home/schatz /var/www/html/spacemonitor/bluearc-home-schatz &
/root/bin/record_space.sh /sonas-hs/schatz/hpc/data /var/www/html/spacemonitor/sonas-hs-schatz &

wait
