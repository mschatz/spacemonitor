#!/bin/sh

if [ $# -lt 2 ]
then
  echo "recordspace directory_to_check directory_for_logs"
  exit 1
fi

base=$1
logdir=$2
timestamp=`date +%Y.%m.%d:%H.%M.%S`
#base=/seq/schatz/mschatz/random
#logdir=/var/www/html/spacemonitor/random

echo "Running recordspace"
echo "  Checking: $base"
echo "  Recording to: $logdir"
echo "  Timestamp: $timestamp"

mkdir -p $logdir

du -k $base > $logdir/$timestamp.full.txt

cat $logdir/$timestamp.full.txt | sort -nr | awk '
     BEGIN {
        split("KB,MB,GB,TB", Units, ",");
     }
     {
        u = 1;
        while ($1 >= 1024) {
           $1 = $1 / 1024;
           u += 1
        }
        $1 = sprintf("%.1f %s", $1, Units[u]);
        print $0;
     }
    ' | head -1000 > $logdir/$timestamp.summary.txt

sort -nrk1 $logdir/$timestamp.full.txt | head -1000 | /root/bin/du_to_json.pl $base > $logdir/$timestamp.1000.json
ln -sf $timestamp.1000.json $logdir/latest.json

