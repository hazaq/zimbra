#!/bin/bash 


usage () {
        echo -e "\n"
        echo "Usage:"
        echo -e "\t$0 user@domain -s|-r [-t]"
        echo -e "\t-s for sender or -r for recipient"
        echo -e "\t-t to view log trace Optional"
        echo -e "\n"
}

arg_check () {

        if [[ "$1" != *@* ]]; then
                echo "Incorect email id "
                usage
                exit
        fi

        sanity=`su - zimbra -c "zmprov -l gaa | grep -i -e $1 "`
        if [ -z $sanity ]; then
                echo "$user does not exist"
                echo "Good Bye"
                exit 0
        fi

        if [ $2 != '-r' ] && [ $2 != '-s' ]; then
                echo "Incorrect argument for send or recieve"
                usage
                exit 0
        fi

        if [[ $3 != '-t' ]] && [[ $3 != '' ]]; then
                echo "Incorrect argument for trace"
                usage
                exit 0 
        fi
} 


logdays=`ls /var/log | grep -i zimbra.log- | wc -l`
count=0
user=$1
check=$2
view=$3
arg_check $user $check $view

echo -e "\n$logdays days of log available "
echo "Enter the number of days "
read days


for i in `ls /var/log | grep -i zimbra.log | tail -n $days`
do

        timestamp=`echo $i | sed 's/zimbra.log-//' | sed 's/.gz//g'`

        if [[ $view = '-t' ]]; then
                echo "View emails sent by user $user on $timestamp "
                echo "Press Enter to continue..............."
                read
                /opt/zimbra/libexec/zmmsgtrace -s $user /var/log/$i 2> /dev/null
        fi

        count=$(($(/opt/zimbra/libexec/zmmsgtrace $check $user /var/log/$i 2> /dev/null | grep -i 'Message ID' | wc -l) + $count)) 
done

if [ $check = '-s' ]; then
        word='sent'
elif [ $check = '-r' ]; then
        word='recieved'
fi
echo "Total emails $word in last $days days"
echo $count

