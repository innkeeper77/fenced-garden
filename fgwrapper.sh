#!/bin/bash

# Wrapper to start the fenced garden control panel from inside its working directory, reverting user back to orig. directory when done

cd /opt/fencedgarden
./mainmenu.sh
cd -
