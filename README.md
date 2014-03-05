spacemonitor
============

HTML TreeMap of your current disk usage. Great for keeping an eye on large, multi-user filesystems with an interactive version of 'du' as displayed in a tree map.

Installation
------------

1. Configure cron_record_space.sh
    
    Edit bin/cron_record_space.sh with the directories you wish to monitor and the path to record the log files. Multiple directories can be monitored, as long as the results are written into the same basic path, such as
    /var/www/html/spacemonitor/dir_1
    /var/www/thml/spacemonitor/dir_2



2. Install into crontab

    Edit your cron to run the script at least once a day
    5 4 * * * /root/bin/cron_record_space.sh
    
    

3. Configure apache for SSI

    Edit your httpd.conf file to enable SSI by adding +Includes to your Options line and index.shtml to your DirectoryIndex (see conf/httpd.conf)



4. Configure the viewer.

    Copy html/* to the base directory of your website (/var/www/html/spacemonitor/). Note the script is NOT safe, and will gladly process any file specified by the QUERY_STRING.
