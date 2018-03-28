#!/bin/bash 

logdays=`ls /var/log | grep -i zimbra.log- | wc -l`
count=0
echo "Enter the email ID"
read user

sanity=`su - zimbra -c "zmprov -l gaa | grep -i -e $user"`

if [ -z $sanity ]; then
        echo "$user does not exist"
        echo "Good Bye"
        exit 0
fi

echo -e "\n$logdays days of log available "
echo "Enter the number of days "
read days

echo "View email log trace [y|n]"
read view


for i in `ls /var/log | grep -i zimbra.log | tail -n $days`
do

        timestamp=`echo $i | sed 's/zimbra.log-//' | sed 's/.gz//g'`

        if [ $view = 'y' ]; then
                echo "View emails sent by user $user on $timestamp "
                echo "Press Enter to continue..............."
                read
                /opt/zimbra/libexec/zmmsgtrace -s $user /var/log/$i 2> /dev/null
        fi

        count=$(($(/opt/zimbra/libexec/zmmsgtrace -s $user /var/log/$i 2> /dev/null | grep -i 'Message ID' | wc -l) + $count))
done

echo "Total emails sent in last $days days"
echo $count

