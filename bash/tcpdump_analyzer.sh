#!/bin/sh
#$Revision$
##################################################################################################
#This script consider the trace to analyze was taken using the command tcpdump -vvv host [hosts] #
#Paramenters : TCPDUMP output and PORT in the receiving HOST                                     #
#It gives the number of Connections request (SYN Flag), the number of acknowledgments sent by    #
#the receiving HOST (SYN/ACK flags) as well as the RESET connections (RST Flag)                  #
##################################################################################################


if [ -z $1 ]; then
        echo "Usage : tcpdump_File   PORT"
        exit
fi
FILE=$1
shift
PORT=$*
FLAG=S
SYN_ACK_FILE=SYN_ACK
TEMPFILE2=temp2
TEMPFILE3=temp3
TEMP_ONLYSYN=SYN
OUTPUT_SYNC=Output_justSYN.txt
OUTPUT_SYN_ACK=Output_AYN_ACK.txt
RST_ACK_FILE=RST
#In this file is stored all well-Established connections
RESULT_EST_CONN=Establised_conn_${PORT}.txt

######### CREATE TEMPORTALS FILES #############

cat $FILE | grep $PORT | grep ' S ' | grep ' ack ' | awk '{print $11}' >$SYN_ACK_FILE
cat $FILE | grep $PORT | grep ' S ' | grep win | grep -v ' ack '| awk '{print $9}' | cut -d: -f1>$TEMP_ONLYSYN
cat $FILE | grep $PORT | grep ' R ' | grep ' ack ' | awk '{print $11}' >$RST_ACK_FILE



############### FUNCTIONS ####################

Count_nonACK(){
                C_noACK=`wc -l $TEMP_ONLYSYN|cut -f3`
                echo "  Sending Hosts has sent ${C_noACK} (Synchronize - Connection establishment) flags"
}

Check_noACK(){
        COUNTER_NOSYNC=0
        COUNTER_SYN_ACK=0
        for  l in ` cat $TEMP_ONLYSYN` 
                do 
                        #grep -c $l $FILE
                        let n=$l+1
                        grep $n $FILE >temp_positv
                        
                        if [ -e temp_positv ]
                                then
                                if [ -s temp_positv ]
                                        then
                                           let COUNTER_SYN_ACK=$COUNTER_SYN_ACK+1
                                           #echo "SYN --> SYN ACK"
                                           #grep $l $FILE>>$OUTPUT_SYN_ACK 
                                           #grep $n $FILE>>$OUTPUT_SYN_ACK
                                        else
                                           #grep $l$FILE>>$OUTPUT_SYNC
                                           let COUNTER_NOSYNC=$COUNTER_NOSYNC+1
                                fi
                        fi

                done 
          echo "        ${COUNTER_NOSYNC} SYN were no answer by the server"
          echo "        ${COUNTER_SYN_ACK} SYN were properly answer by server"
}


Check_SynAck(){
                for i in `cat $SYN_ACK_FILE`
                        do
                                let j=$i-1
                                grep $j $FILE | awk '{print $2}' >$TEMPFILE2
                
                for m in `cat $TEMPFILE2`
                         do
                                echo "----------------------------------------">>$RESULT_EST_CONN
                                grep $m $FILE>>$RESULT_EST_CONN
                        done

                #grep $i $FILE
        done
}

Count_reject(){
        C_RST=`wc -l $RST_ACK_FILE`
        echo "  Server Hosts has sent ${C_RST} (RESET) flags"
        

}

 
################ MAIN ##############
Count_nonACK
Check_noACK
Count_reject
Check_SynAck

