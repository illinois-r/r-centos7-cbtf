## R and RStudio on a Secured CentOS 7 Environment

![Show Startup Procedure](https://i.imgur.com/PTUmOOf.gif)

This repository provides a way to setup R and RStudio on a secured computing environment. In particular, the setup routine will:

- Download and Install on CentOS 7
    - Development Tools
    - _R_ 
    - _RStudio_
    - Assortment of _R_ Packages into a site-wide library
- Embeds notice on session start regarding CRAN access.
- Establishes and redirects CRAN install package requests to
  a local directory.
- Alerts users that `install.packages()` is disabled in console R, R GUI,
  and RStudio IDE.
- [Disable RStudio Features requiring Internet Access](https://support.rstudio.com/hc/en-us/articles/210990438-Disabling-RStudio-Features)
    - Disables posting to RPubs or Shiny Apps 
    - Disables RStudio Check for Updates
    - Disables HTTPS Secure Download Warning 
        - **Note:** Not relevant as CRAN cannot be accessed.
- Sets up a help function in the global environment to open
  intranet documentation on environment when called.
    
### Usage

To roll out the secure environment, the computer must
initially be connected to the internet. 

From there, we apply different configuration settings to
suppress internet connections.

```sh
# Download latest version
wget -O master.zip http://github.com/coatless/r-centos7/archive/master.zip

# Unzip and delete the zip
unzip master.zip; rm master.zip

# Change directory
cd master/

# Allow the file to execute
chmod +x ~/setup-centos7-r.sh

# Run the file
./setup-centos7-r.sh
```

### Computer-based Testing Facility (CBTF) Deployment

Within this video, there is a brief walkthrough of opening RStudio and writing in RMarkdown on a computer configured securely in the [Computer-based Testing Facility (CBTF)](https://cbtf.engr.illinois.edu/) at the [University of Illinois at Urbana-Champaign (UIUC)](https://illinois.edu).

[![Sample video showing an earlier rendition of R in a secure environment](https://img.youtube.com/vi/6oaPvo4TIFk/0.jpg)](https://www.youtube.com/watch?v=6oaPvo4TIFk)

**Note:** This video shows a slightly outdated version. 

More details can be found at: 

- [Overriding RStudio's Startup Hook Inside Rprofile](https://thecoatlessprofessor.com/programming/r/overriding-rstudios-startup-hook-inside-rprofile/)
- [Improving the Secured Computer-based Testing Environment for R on Centos 7 Using Rprofile and Renviron](https://thecoatlessprofessor.com/programming/r/improving-the-secured-computer-based-testing-environment-for-r-on-centos-7-using-rprofile-and-renviron/)
- [R and RStudio in a Secured Environment on Centos 7](https://thecoatlessprofessor.com/programming/r/r-and-rstudio-in-a-secured-environment-on-centos-7/)
