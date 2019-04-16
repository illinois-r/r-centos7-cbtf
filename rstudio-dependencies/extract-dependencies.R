library("stringr")

# Grab code from dependency manager file
code_lines = readLines("rstudio-dependencies/DependencyManger.java")

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

# Write in vector-form
cat(paste0("c(", paste0('"', unique_pkgs, '"', collapse = ","), ")"))
