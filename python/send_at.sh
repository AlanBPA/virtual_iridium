#!/bin/bash
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
   else 
      echo -en $MSG > $SP
      echo ""
      echo "Sent: <$MSG> to port $SP"
   fi
done

