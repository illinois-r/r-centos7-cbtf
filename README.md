## R and RStudio on a Secured CentOS 7 Environment

This repository provides a way to setup R and RStudio on a secured computing environment. 

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

