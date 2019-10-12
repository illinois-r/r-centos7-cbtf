library("stringr")

# Download the latest version
download.file(
    "https://github.com/rstudio/rstudio/blob/master/src/gwt/src/org/rstudio/studio/client/common/dependencies/DependencyManager.java?raw=1",
    "rstudio-dependencies/DependencyManager.java"
)

# Grab code from dependency manager file
code_lines = readLines("rstudio-dependencies/DependencyManager.java")

# Data style:
#
# Dependency.cranPackage("htmltools", "0.3.6")
#
# Goal: Retrieve "htmltools"
# Search pattern is should be:
pattern = '.*\\.cranPackage\\("(.*?)".*'

# Extract all lines with the pattern
code_lines = code_lines[str_detect(code_lines, pattern)]

# Retrieve from the string the desired output
pkgs = str_replace_all(code_lines, pattern = pattern, "\\1")

# Take only the unique packages
unique_pkgs = unique(pkgs)

# Take a snapshot and store it as a text file with 1 package per line
writeLines(unique_pkgs, con = "rstudio-dependencies/list-dependencies.txt")

# Write in vector-form
cat(paste0("c(", paste0('"', unique_pkgs, '"', collapse = ","), ")"))
