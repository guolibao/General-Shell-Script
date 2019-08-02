find . -regex '.*\.\(c\|cpp\|\|h\)$'
# if want to open it vim vim

#find . -regex '.*\.\(c\|cpp\|\|h\)$' -exec vim '{}' '+'
#use :args in vim to see all the files 
#use :h 'hidden' so we can use :next, bnext, cnext (and so on) even if the buffer is modified
#:wn is for write file and edit next, so you can eyeball the change in vim if using argdo to do batch processing.
