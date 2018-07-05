rotate () {
    RCOUNT="0"
    SLEEPSEC=1
    while [ 1 ]; do
	RCOUNT=$((RCOUNT + 1))
	case $RCOUNT in
	    1)
		echo -e "-\c"
		sleep $SLEEPSEC
		echo -e "\b\c"
		;;
	    2)
		echo -e '\\'"\c"
		sleep $SLEEPSEC
		echo -e "\b\c"
		;;
	    3)
		echo -e "|\c"
		sleep 1
		echo -e "\b\c"
		;;
	    4)
		echo -e "/\c"
		sleep 1
		echo -e "\b\c"
		;;
	    *)
		RCOUNT="0"
		echo -e "\b\c"
		
	esac
    done
}

# test!!! as below

# rotate &

# BG_PID=$!
# echo guo

# run some long process
# for x in {1..20}; do
#     sleep 1
# done

# echo "reach here"
# kill $BG_PID

# Another for showing process in percentage
percentage () {
    echo -ne '#####               (25%)\r'
    sleep 3
    echo -ne '##########          (50%)\r'
    sleep 3
    echo -ne '###############     (75%)\r'
    sleep 3
    echo -ne '####################(100%)\r'
    sleep 1
    echo -ne '\n'
}

# test code as below
# percentage


