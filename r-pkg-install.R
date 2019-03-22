#! /usr/bin/env RScript

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
