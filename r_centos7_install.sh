#!/usr/bin/env bash

#
# r_centos7_install.sh
#
# Copyright (C) 2018 James Joseph Balamuta <balamut2@illinois.edu>
#
# Version 1.2.0 -- 07/02/18
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
# chmod +x ~/r_centos7_install.sh
# 
# # Run the file
# ./r_centos7_install.sh
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
                    libjpeg-turbo-devel

############# Install Latest RStudio IDE

# Download latest 64 bit version
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

############### Add R packages

# Create a script that installs R packages

# Warning: When taking RStudio Offline it's important that we double check that all dependencies are pre-installed
# RStudio's dependency manager does _not_ export a list of dependencies. This list can be found here:
#
# https://github.com/rstudio/rstudio/blob/master/src/gwt/src/org/rstudio/studio/client/common/dependencies/DependencyManager.java

cat <<- EOF > rpkg-install.R
# R Code Ahead to install packages!

# The following are packages used in STAT 385
pkg_list = c('tidyverse', 'rmarkdown', 'shiny',                                                  # EDA tools
            'flexdashboard', 'shinydashboard',
            'devtools', 'testthat', 'roxygen2', 'profvis', 'RSQLite',                           # Development tools
            'RcppArmadillo', 'rbenchmark', 'microbenchmark',                                    # C++ packages
            'zoo', 'xts', 'forecast',                                                           # TS packages
            'maps', 'maptools', 'mapproj', 'mapdata', 'ggmap',                                  # Mapping packages
            'GGally', 'ggrepel', 'ggraph', 'gganimate',
            'cowplot', 'gridExtra', 'patchwork',
            'tidytext', 'tm',
            'future', 'doParallel',
            'data.table',
            'lubridate',
            'survey', 'fivethirtyeight', 'nycflights13', 'babynames', 'neiss', 'ggplot2movies', # Data packages
            'caTools', 'bitops',                                                                # Dependencies that are out of date for rmarkdown
            'PKI', 'RCurl', 'RJSONIO', 'packrat', 'rstudioapi', 'rsconnect',                    # RSConnect
            'miniUI')

# Ncpus allows for quicker compilation.
install.packages(pkg_list, repos = "https://cran.rstudio.com", Ncpus = 4)

# Install some data packages on GitHub
devtools::install_github("kjhealy/socviz")
devtools::install_github("coatless/uiucdata")
devtools::install_github("coatless/ucidata")
EOF

# Run the script with sudo to write to `/usr/lib64/R/library`
sudo Rscript rpkg-install.R

# Clean up by removing the script
rm -rf rpkg-install.R

############## Update R Packages

# Updates packages in R site-wide library from the RStudio CDN for CRAN
# CRAN is given here: https://cloud.r-project.org
Rscript -e "update.packages(ask = FALSE, repos = 'https://cran.rstudio.com')"

############## Disable access to CRAN

# After we run updates, we need to disable querying external as it has been
# shown to cause a "lagged" RStudio client.

# We do this by setting the option for CRAN to point to a misc directory on the User's machine
mkdir ~/fakecran
echo 'options(repos = c(CRAN = "~/fakecran/"))' >> ~/.Rprofile


