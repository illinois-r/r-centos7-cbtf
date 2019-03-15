#!/bin/bash

# Set Rstudio font to address bug where cursor
# leads text by a few centimeters
mkdir -p ~/.config/RStudio
cp /etc/cbtf-RStudio-desktop.ini ~/.config/RStudio/desktop.ini

# This sets up an empty (FAKE) CRAN repo to avoid users
# trying to connect to an unavailable REAL cran
# (due to security model) 
mkdir -p ~/cran

# This sets the cran mirror to the local (FAKE) repo and
# now includes a startup message 
cp /etc/cbtf-Rprofile ~/.Rprofile

# This disables the secure download feature of RStudio
# that prevents red warning text
cp /etc/cbtf-Renviron ~/.Renviron
