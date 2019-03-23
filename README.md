## R and RStudio on a Secured CentOS 7 Environment

This repository provides a way to setup R and RStudio on a secured computing environment. In particular, the setup routine will:

- Download and Install on CentOS 7
    - _R_ 
    - _RStudio_
    - Assortment of _R_ Packages into a site-wide library
- Embeds notice on session start regarding CRAN access.
- Establishes and redirects CRAN install package requests to
  a local directory.
- [Disable RStudio Features requiring Internet Access](https://support.rstudio.com/hc/en-us/articles/210990438-Disabling-RStudio-Features)
    - Disables posting to RPubs or Shiny Apps 
    - Disables RStudio Check for Updates
    - Disables HTTPS Secure Download Warning 
        - **Note:** Not relevant as CRAN cannot be accessed.
- Setups a help function in the global environment to open
  intranet documentation when called.
    
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

### Demo


![Show Startup Procedure](https://i.imgur.com/FGV3U8z.gif)

