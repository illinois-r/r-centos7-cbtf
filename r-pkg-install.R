#! /usr/bin/env RScript

#
# r-pkg-install.R
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

#### Configure Package Setup ----

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


#### RStudio IDE Packages ----

# RStudio Required Packages
#
# Warning: When taking RStudio Offline it's important that we double check that
# all dependencies are pre-installed RStudio's dependency manager does
# _not_ export a list of dependencies.
#
# The list of dependencies can be found here:
# https://github.com/rstudio/rstudio/blob/master/src/gwt/src/org/rstudio/studio/client/common/dependencies/DependencyManager.java
rstudio_pkgs = c(
    "xml2",
    "htmltools",
    "htmlwidgets",
    "jsonlite",
    "r2d3",
    "R6",
    "stringi",
    "httpuv",
    "crayon",
    "plumber",
    "packrat",
    "RCurl",
    "openssl",
    "rstudioapi",
    "yaml",
    "rsconnect",
    "evaluate",
    "digest",
    "highr",
    "markdown",
    "stringr",
    "Rcpp",
    "knitr",
    "base64enc",
    "rprojroot",
    "mime",
    "rmarkdown",
    "miniUI",
    "xtable",
    "sourcetools",
    "promises",
    "rlang",
    "later",
    "shiny",
    "png",
    "reticulate",
    "rstan",
    "readr",
    "haven",
    "readxl",
    "RJDBC",
    "rJava",
    "RODBC",
    "mongolite",
    "profvis",
    "keyring",
    "odbc",
    "shinytest",
    "testthat",
    "devtools",
    "DBI",
    "RSQLite"
)

#### Class Package Requirements ----

### STAT 385
stat385_pkgs =
    c('rmarkdown',                                              # EDA tools
      'purrr', 'dplyr', 'ggplot2',
      'tidyr', 'lubridate',
      'readxl', 'readr',                                        # Read data
      'jsonlite', 'haven',
      'httr', 'rvest',                                          # Web Scraping
      'xml2',
      'tidyverse',                                              # Tidyverse-catch all.
      'shiny', 'flexdashboard', 'shinydashboard',               # Interactive Interfaces
      'devtools', 'testthat',                                   # Development tools
      'roxygen2', 'profvis',
      'covr',
      'RSQLite', 'dbplyr',                                      # Database tools
      'Rcpp', 'RcppArmadillo',                                  # C++ packages
      'rbenchmark', 'microbenchmark',                           # Code Timing Tools
      'zoo', 'xts', 'forecast',                                 # Time Series Analysis
      'maps', 'maptools', 'mapproj',                            # Mapping packages
      'mapdata', 'ggmap', 'leaflet',
      'leaflet.extra',
      'GGally', 'ggrepel', 'ggraph', 'gganimate',               # Graphing Tools
      'cowplot', 'gridExtra', 'patchwork',
      'tidytext', 'tm',                                         # Text manipulation
      'future', 'doParallel',                                   # Parallelization
      'data.table',                                             # Data Manipulation
      'survey', 'fivethirtyeight', 'nycflights13',              # Data packages
      'babynames', 'neiss', 'ggplot2movies'
      )

### STAT 430 DSPM ----

stat430dspm_pkgs = c(
    "rmarkdown",
    "jsonlite",
    "xml2",
    "RSQLite",
    "data.table",
    "ggplot2",
    "stringr",
    "dplyr",
    "tibble",
    "tidyr",
    "rbenchmark",
    "microbenchmark",
    "Rcpp",
    "RcppArmadillo",
    "latticeExtra",
    "shiny",
    "shinydashboard",
    "flexdashboard",
    "devtools",
    "RUnit",
    "testthat",
    "covr",
    "roxygen2",
    "littler"
)

### STAT 432: Basics of Statistical Learning

stat432_pkgs = c(
  "caret",
  "class",
  "cluster",
  "dendextend",
  "dplyr",
  "e1071",
  "ellipse",
  "extraTrees",
  "factoextra",
  "FNN",
  "gam",
  "gbm",
  "ggplot2",
  "ggridges",
  "ggthemes",
  "glmnet",
  "ISLR",
  "janitor",
  "kableExtra",
  "kernlab",
  "klaR",
  "knitr",
  "leaps",
  "lubridate",
  "mlbench",
  "nnet",
  "plotrix",
  "pROC",
  "purrr",
  "randomForest",
  "readr",
  "rmarkdown",
  "rpart",
  "rpart.plot",
  "rsample",
  "rvest",
  "sparcl",
  "tibble",
  "tidyverse",
  "tree"
)

### CE 202 ----

ce202_pkgs = c(
  "tidyverse",
  "ggplot",
  "knitr",
  "rmarkdown",
  "readxl"
)

### Your class here ----

# deptnamenumber_pkgs = c("", ...)

### Combine packages used across classes  ----

# Master package list
pkg_list = Reduce(union,
                  list(rstudio_pkgs,
                       stat385_pkgs,
                       stat430dspm_pkgs,
                       stat432_pkgs,
                       ce202_pkgs
                       #, deptnamenumber_pkgs # Your course here
                       )
                  )


#### Install packages from CRAN  ----

# Determine what packages are NOT installed already.
to_install_pkgs = pkg_list[!(pkg_list %in% installed.packages()[,"Package"])]

# Install the missing packages
if(length(to_install_pkgs)) {
    install.packages(to_install_pkgs, quiet = TRUE)
}

# Check if any updates exist, if so... Install!
update.packages(ask = FALSE, quiet = TRUE)

#### GitHub-only packages  ----

# Install some data packages on GitHub
devtools::install_github("kjhealy/socviz")
devtools::install_github("coatless/uiucdata")
devtools::install_github("coatless/ucidata")
