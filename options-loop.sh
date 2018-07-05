
echo "Beginning of the file " "$OPTIND"
# getopts optstring name [args]
# * if a : is before a character, it will suppress errors
# * if a character is followed by a collon, the option is expected to have an argument
# which should be separated it from white space
# * The colon (:) or (?) may not be used as option characters
# :sp --> :s is for suppressing error, p is another argument
# :s:p --> :s suppress error s: for one argment must followed to s
# so seems only one option can have a suppress error in the beginning
# :yd:nDRS --> y suppress errors, d must follow argument, n D R S is other options
while getopts :sp OPT; do
    echo $OPTIND
    case $OPT in
	s|+s)
	    echo "polly want a banana " $OPTARG
	    ;;
	p)
	    echo "Polly want a pear" $OPTARG
	    ;;
	*)   # ./script           ---with out any argument will not trigger into here, only wrong args will come here
	    echo "usage: `basename $0` [+-s} [--] ARGS..."
	    exit 2
    esac
done
echo "before $*"
# shift n removes n strings from the positional parameters list
# thus shift $(($OPTIND-1)) removes all the options that have been
# pasted by getopts from the parameter list, and so 
shift `expr $OPTIND - 1`	# remove the args followed
echo "after $*"			# so after shift we can confirm, no argment any more
OPTIND=1 # reset the OPTIND to original value



# Test cases
# (1)
# options-loop.sh -s -p

# Output
# Beginning of the file  1
# 2
# polly want a banana 
# 3
# Polly want a pear
# before -s -p
# after 


# (2)
# options-loop.sh -p -s

# output:
# Beginning of the file  1
# 2
# Polly want a pear
# 3
# polly want a banana 
# before -p -s
# after 
