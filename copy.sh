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
     read -e -p "What is the filepath of the directory you want as the destination? Remember the folder used as source is placed IN here " DEST;
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
REALDEST="$(PWD -P)"
echo $REALDEST

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
________________  .___.____     
\_   _____/  _  \ |   |    |    
 |    __)/  /_\  \|   |    |    
 |     \/    |    \   |    |___ 
 \___  /\____|__  /___|_______ \
     \/         \/            \/
No Dinosaur, no love.

Something is off!

Take a look to see if anything important is missing!"

else 
echo "Happy Dino!
 __      __.__      ._.
/  \    /  \__| ____| |
\   \/\/   /  |/    \ |
 \        /|  |   |  \|
  \__/\  / |__|___|  /_
       \/          \/\/
               __
              / _)
     _/\/\/\_/ /
   _|         /
 _|  (  | (  |
/__.-'|_|--|_|
               

SUCCESS!"
fi
