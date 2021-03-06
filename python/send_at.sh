#!/bin/bash
EOL="\r"
echo Introduce Virtual Serial Port to send data:
read SP
echo -e "\nUsing port $SP, to change port write -c name_of_port"

while [ "1" = "1" ]; do
   echo -e "\nSend message or write -x to exit"
   read -r MSG MSG2
   if [ "$MSG" = "-x" ]; then
      echo Exiting...
      exit
   elif [ "$MSG" = "-c" ]; then
      SP=$MSG2
      echo -e "\nPort changed to $SP"
   elif [ "$MSG" = "-r" ]; then
      echo -en $MSG2 > $SP
      echo ""
      echo "Sent: <$MSG2> to port $SP"
   else 
      echo -en $MSG$EOL > $SP
      echo ""
      echo "Sent: <$MSG> to port $SP"
   fi
done

