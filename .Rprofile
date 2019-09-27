#
# .Rprofile
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

###############################################################################
# Disabling package installation when using R GUI or RStudio IDE.
#
# On R startup inside of either the R GUI or RStudio IDE, the settings provided
# within this Rprofile are loaded. In particular, the Rprofile setups
# intercepts for `install.packages`, disables CRAN, and displays a startup
# message letting users know packages are pre-installed.
#
# There is a companion .Renviron file that sets specific RStudio environment
# variables to further disable the environment configuration.
###############################################################################

.First = function() {
    ## Local CRAN ----

    ## Initialize an empty local CRAN repository.
    ## Note: In this setup, we are not placing package
    ## sources or binaries into this location.
    local_user_cran = file.path(Sys.getenv("HOME"), "cran")
    dir.create(local_user_cran, showWarnings = FALSE)

    ## Set the location of packages to the empty local CRAN.
    ## Ensure that the appropriate RStudio Secure warning is handled.
    options(repos = c("CRAN" = paste0("file://", local_user_cran)))

    # Exit if a human isn't present (e.g. run from an Rscript / R CMD)
    if (!interactive()) {
        return()
    }

    ## CBTF Help Messages ----

    ## Hard coded help documentation location
    ## TODO: Update to where docs are on the CBTF website!!

    cbtf_help_url = "https://cbtf.engr.illinois.edu/for-students/software-RStudio.html"

    ## Open the URL for students to view help documentation
    help_cbtf = function(url = cbtf_help_url) {
        message("Opening help documentation at: ", url)
        utils::browseURL(url)
    }

    ## Place the help function into the global environment
    ## TODO: Enable when documentation is present
    base::assign("help_cbtf", help_cbtf, envir = globalenv())

    ## Provide startup messages in red text to indicate the status of
    ## package installation and environment specific documentation

    wrap_msg = function(x) {
        message(paste(strwrap(x), collapse = "\n"))
    }

    cbtf_disabled_cran_msg = function() {
        message("Note: ")
        wrap_msg("Installing packages from CRAN is disabled.")
        wrap_msg(
            "Packages required by:\n STAT 385, STAT 430 DSPM, STAT 432, and CE 202\n have been pre-installed. \n"
        )
    }

    cbtf_documentation_msg = function() {
        wrap_msg("For help with R and RStudio in the CBTF, please consult the help guide by using the `help_cbtf()` function.")
    }

    cbtf_welcome_msg = function() {
        cbtf_disabled_cran_msg()
        cbtf_documentation_msg()
    }

    ## Disable install.packages ----

    ## Override an R function in a package.
    shim_pkg_func = function(name, pkgname, value) {

        ## Ensure package is loaded.
        ## If the package is not on the search path, we cannot modify it!
        pkg_env_name = paste0("package:", pkgname)
        if (!pkg_env_name %in% search()) {
            # Load the library
            library(pkgname, character.only = TRUE)
        }

        # Retrieve package environment
        env = as.environment(pkg_env_name)
        #pkg_ns_env = asNamespace(pkgname)

        # Unlock environment where the function/variable is found.
        base::unlockBinding(name, env)

        # Make the assignment into the environment with the new value
        base::assign(name, value, envir = env)

        # Close the environment
        base::lockBinding(name, env)
    }

    ## Provide an alternative install.packages(...) routine
    install_packages_shim = function(...) { cbtf_disabled_cran_msg() }

    ## Setup a shim to override the install.packages() function
    if(Sys.getenv("RSTUDIO") == "1") {
        ## Establishes a delayed registration of the shim after
        ## RStudio's startup procedure occurs. This procedure overwrites settings
        ## sometimes established in .Rprofile. Thus, we need a delayed
        ## component to ensure we're preventing
        ## install.packages() from being delayed
        ## c.f. https://github.com/rstudio/rstudio/issues/1579#issuecomment-495706255
        setHook("rstudio.sessionInit", function(newSession) {
            if (newSession)
                shim_pkg_func("install.packages", "utils", install_packages_shim)
        }, action = "append")
    } else {
        ## Establish the shim for _R_ terminal sessions or R GUI.
        ## Attempting to establish the hook with RStudio would result
        ## in its initialization procedure overwrite this shim.
        shim_pkg_func("install.packages", "utils", install_packages_shim)
    }

    ## Display the welcome bumper
    cbtf_welcome_msg()
}

