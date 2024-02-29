#!/bin/bash



./hierarchy.sh



echo -e "\n[$] > Stowing configuration files..." &&
cd ../files/home/ &&
stow -t $HOME */ &&

cd ../assets/ &&
stow -t $HOME */ &&
echo -e "\n[$] > Done!\n"
