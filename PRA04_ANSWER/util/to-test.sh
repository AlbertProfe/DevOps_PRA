#!/bin/bash

# https://sleeplessbeastie.eu/2012/11/07/how-to-remove-comments-from-a-shell-script/
        
# example script
              
echo "# test";# echo "# test"

# check the first parameter
if [ "$1" = "#" ]; then 
  # test couple of different cases
  echo "#"; # output # character 
  echo '\#'; # output # character '#' for test purpose
  echo \#\#\#; # comment # comment # comment '# comment'
  echo \#
  echo \#;
  echo \#; # comment
fi
# end of the script
            