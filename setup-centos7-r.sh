#!/usr/bin/env bash

#
# setup-centos7-r.sh
#
# Copyright (C) 2019 James Joseph Balamuta <balamut2@illinois.edu>
#
# Version 2.5.1 -- 09/26/19
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#

######################################
# # Allow the file to execute
# chmod +x ~/setup-centos7-r.sh
#
# # Run the file
# ./setup-centos7-r.sh
######################################

############## Add Development Tools

# Install development tools
sudo yum groupinstall -y "Development Tools"

############## Install Latest R Version

# Add the latest release of Extra Packages for Enterprise Linux
sudo yum install -y epel-release

# Install R from the repository
sudo yum install -y R

############## Add additional system libraries

# Enables parsing XML
sudo yum install -y libxml2-devel

# These libraries relate to web scraping technology and are needed by rvest + devtools
# Let me know if they are no-go and I'll whip something else up.
sudo yum install -y libcurl-devel \
                    openssl-devel \
                    libssh2-devel \
                    libpng-devel  \
                    libjpeg-turbo-devel \ 
                    unixODBC-devel `# required for ODBC` \
                    libsodium-devel

############# Install Latest RStudio IDE

# Download latest 64 bit version
#
# For other download links, please see:
# http://thecoatlessprofessor.com/tutorials/downloading-and-installing-rstudio-desktop/
wget -O rstudio-latest-x86_64.rpm https://www.rstudio.org/download/latest/stable/desktop/redhat64/rstudio-latest-x86_64.rpm

# Install it
sudo yum install -y --nogpgcheck rstudio-latest-x86_64.rpm

# Remove the installer
rm rstudio-latest-x86_64.rpm

# Add icon to desktop
# Based on: https://superuser.com/questions/806448/how-to-make-a-desktop-icon-on-centos-7
cp RStudio.desktop ~/Desktop/RStudio.desktop

# Enable permissions
chmod 755 ~/Desktop/RStudio.desktop

############### Add and update R packages

# Warning: When taking RStudio Offline it's important that we double check that
# all dependencies are pre-installed RStudio's dependency manager does
# _not_ export a list of dependencies.
#
# The list of dependencies can be found here:
# https://github.com/rstudio/rstudio/blob/master/src/gwt/src/org/rstudio/studio/client/common/dependencies/DependencyManager.java

# Run the script with sudo to write to `/usr/lib64/R/library`
sudo Rscript r-pkg-install.R

# Clean up by removing the script
rm -rf r-pkg-install.R

############## Disable access to CRAN

# After we run updates, we need to disable querying external as it has been
# shown to cause a "lagged" RStudio client.
#
# We do this inside of a .Rprofile that is loaded when R is started in either
# R GUI or RStudio IDE by:
# 1. Setting the option for CRAN to point to a misc directory on the user's machine
# 2. Providing a shim for install.packages()
#
# We further disable RStudio's internet options by setting
# environment variables in .Renviron

# Deploy Rprofile and Renviron to user directory
# Note: Probably best to use the *.site variants in `R_HOME/etc/*.site`
cp .Rprofile ~/.Rprofile
cp .Renviron ~/.Renviron

