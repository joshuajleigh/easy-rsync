#!/bin/bash
#Greeting dialogue
echo "Welcome to the Area 51 file transfer tool! No copy rights, No gaurantees. Just use it fool."


# Ask for and check SOURCE
read -e -p "What is the filepath of the directory you want as the source? " SOURCE;
while [[ ! -d "$SOURCE" ]]; do
        echo "That isn't a real source, try again chump." ;
        read -e -p " What is the filepath of the directory you want as the source? " SOURCE;
done

# Ask for and check DESTINATION
read -e -p "What is the filepath of the directory you want as the destination?" DEST;
while [[ ! -d "$DEST" ]]; do
        echo "That isn't a real destination, try again chump.";
     read -e -p "What is the filepath of the directory you want as the destination? Remember the folder used as source is placed IN here " 
DEST;
done

#confirmation prompt continues on yes, exits on no
echo "Copying from " $SOURCE " to " $DEST " is this right?"
select yn in "Yes" "No"; do
        case $yn in
                Yes ) echo "Starting the backup process now.";break;;
                No ) echo "Backup cancelled."; exit;;
esac
done

# Correcting the destination so source folder goes where user would expect 
cd $DEST
cd ..
REALDEST="$PWD"

# rsync transfer including progress during transfer and stats at end
rsync -az --progress --stats $SOURCE $REALDEST

#optional additional confirmation of size of source and destination
#echo "Size of source"
#du -cg $SOURCE | sort -n | tail -1
#echo "Size of destination"
#du -cg $REALDEST | sort -n | tail -1


# This gives a human readable confirmation on success or failure of sync 
SOURCESIZE="$(du -cg $SOURCE | sort -n | tail -1 | sed 's/[^0-9]//g')"
DESTSIZE="$(du -cg $DEST | sort -n | tail -1 | sed 's/[^0-9]//g')"

if [ $SOURCESIZE -gt $DESTSIZE ] ; then
    echo "
________________________¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶________
____________________¶¶¶___________________¶¶¶¶_____
________________¶¶¶_________________________¶¶¶¶___
______________¶¶______________________________¶¶¶__
___________¶¶¶_________________________________¶¶¶_
_________¶¶_____________________________________¶¶¶
________¶¶_________¶¶¶¶¶___________¶¶¶¶¶_________¶¶
______¶¶__________¶¶¶¶¶¶__________¶¶¶¶¶¶_________¶¶
_____¶¶___________¶¶¶¶____________¶¶¶¶___________¶¶
____¶¶___________________________________________¶¶
___¶¶___________________________________________¶¶_
__¶¶____________________¶¶¶¶____________________¶¶_
_¶¶_______________¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶______________¶¶__
_¶¶____________¶¶¶¶___________¶¶¶¶¶___________¶¶___
¶¶¶_________¶¶¶__________________¶¶__________¶¶____
¶¶_________¶______________________¶¶________¶¶_____
¶¶¶______¶________________________¶¶_______¶¶______
¶¶¶_____¶_________________________¶¶_____¶¶________
_¶¶¶___________________________________¶¶__________
__¶¶¶________________________________¶¶____________
___¶¶¶____________________________¶¶_______________
____¶¶¶¶______________________¶¶¶__________________
_______¶¶¶¶¶_____________¶¶¶¶¶_____________________


Something is off!Take a look to see if anything important is missing!"
fi

if [ $SOURCESIZE -lt $DESTSIZE ] ; then
    echo "

                     ***                  ***
                    *****                *****
                    *****                *****
                     ***                  ***
          ***                                        ***
           ***                                      ***
            ***                                    ***
             ***                                  ***
               ***                              ***
                 ***                          ***
                   ***                      ***
                      **********************
                         ****************



SUCCESS!"
fi

if [ $SOURCESIZE" -eq "$DESTSIZE ] ; then
    echo "

                     ***                  ***
                    *****                *****
                    *****                *****
                     ***                  ***
          ***                                        ***
           ***                                      ***
            ***                                    ***
             ***                                  ***
               ***                              ***
                 ***                          ***
                   ***                      ***
                      **********************
                         ****************



SUCCESS!"
fi
