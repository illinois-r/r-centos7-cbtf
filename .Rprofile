# Add to the global environment a way to easily
# reach the help documentation on the CBTF website.
help_cbtf = function() {

    cbtf_help_url = "https://cbtf.engr.illinois.edu/home.html"

    message("Opening: ", cbtf_help_url)
    utils::browseURL(cbtf_help_url)
}

# Construct a welcome message that respects console window space
# Output the startup message in red text to differentiate from console

message("Note: ")
message("Installing packages from CRAN is disabled.")
message("All required R packages have already been installed.")

# Display where software documentation for R and RStudio is on CBTF website
# TODO: Add to CBTF website!!

# message(
#   strwrap(
#     paste0("For help using R and RStudio in the CBTF, please see the documentation at: ",
#     "https://cbtf.engr.illinois.edu/home.html")
#   )
# )

# Set the location of packages to a trash repository
options(repos = c("CRAN" = "file://~/cran"))
