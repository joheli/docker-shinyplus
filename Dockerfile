# base
FROM rocker/shiny:3.6.0

# Install further R packages
RUN Rscript -e "install.packages(c('dplyr','ggplot2','tidyr', 'shinyWidgets'), repos = 'http://ftp.gwdg.de/pub/misc/cran')" 

# start
CMD ["/usr/bin/shiny-server.sh"]
