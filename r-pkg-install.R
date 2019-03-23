#! /usr/bin/env RScript

#
# r-pkg-install.R
#
# Copyright (C) 2019 James Joseph Balamuta <balamut2@illinois.edu>
#
# Version 2.0.0 -- 03/22/19
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

# R Code Ahead to install packages!

# Dynamical detect physical cores...
Ncpus = parallel::detectCores(logical = FALSE)

# Cap number of cores used in installation to 3
if(Ncpus >= 4) {
    Ncpus = 3
} else {
    Ncpus = Ncpus
}

# Set the default number of cores to use for compiling code
# during package installation/updation and set the default mirror
# to the Cloud CDN for CRAN: https://cloud.r-project.org
options(Ncpus = Ncpus,
        repos = c("CRAN" = "https://cloud.r-project.org"))

# The following are packages used in STAT 385 / 430 DSPM
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

# Determine what packages are NOT installed already.
to_install_pkgs = pkg_list[!(pkg_list %in% installed.packages()[,"Package"])]

# Install the missing packages
if(length(to_install_pkgs)) {
    install.packages(to_install_pkgs)
}

# Check if any updates exist, if so... Install!
update.packages(ask = FALSE)

# Install some data packages on GitHub
devtools::install_github("kjhealy/socviz")
devtools::install_github("coatless/uiucdata")
devtools::install_github("coatless/ucidata")
