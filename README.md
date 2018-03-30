# zimbra
Generic zimbra scripts
### get_email_stat.sh
This scripts takes zimbra user email address as an arugument and give you the total number of email sent or received by that email address.  
If -r is passed as the second argument it will output total email received and -s for email sent.   
You can also ask the script to give a log trace of the email sent or received by passing in '-t' argument.

Usage:   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;get_email_stat.sh user@domain -s|-r [-t]  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-s for sender or -r for recipient  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-t to view log trace Optional  

Example:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To get total number of email sent by user@example.com 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;get_email_stat.sh user@example.com -s

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This will do just like above example and give you the log trace
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;get_email_stat.sh user@example.com -s -t

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This will give you the total number of email recevied by the user
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;get_email_stat.sh user@example.com -r
