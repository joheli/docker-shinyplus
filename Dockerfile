# base
FROM rocker/shiny:3.6.0

# Install java and rJava
RUN apt-get -y update && apt-get install -y \
   default-jdk \
   r-cran-rjava

# Install further R packages
RUN Rscript -e "install.packages(c('dplyr', 'EnvStats','ggplot2', 'readxl', 'tidyr', 'tools', 'simmer', 'shinyMatrix', 'shinyjs', 'shinyWidgets', 'xlsx'), repos = 'http://ftp.gwdg.de/pub/misc/cran')" 

# start
CMD ["/usr/bin/shiny-server.sh"]
