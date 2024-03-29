# docker-shinyplus

This is just an extension of the image 
[rocker/shiny](https://hub.docker.com/r/rocker/shiny "rocker/shiny on docker hub") for my brother Josef. In addition to `rocker/shiny`, however, it contains a Java runtime engine and a few R packages (e.g. 'simmer', 'ggplot2', 'dplyr', etc.).

## Prerequisites

You need to have Docker Community Edition (CE) installed and your computer needs access to the internet to download the image. You do **not** need Docker Enterprise Edition (EE). 

To install Docker CE for your operating system, please head to [docker docs](https://docs.docker.com/install/ "Installation docs at Docker"). If you install on Linux, make sure to check out the useful [post-installation steps](https://docs.docker.com/install/linux/linux-postinstall/ "Useful post-installation steps on Linux").

## Firing up the image

### Without an app - just checking

If the installation of Docker CE was a success, the following command should fire up the image `johanneselias/shinyplus`:

    docker run -d --name whatever --rm --user shiny -p 80:3838 johanneselias/shinyplus

This command generates a container with the name `whatever` (switch `--name`) using the user `shiny` inside the container (switch `--user`). It opens a server on port `80` (switch `-p` actually forwards port 3838 from within the container to port 80 accessible from outside). Switch `-d` makes sure the container runs in the background. If image `johanneselias/shinyplus` has never been downloaded, above command automatically triggers the download (alternatively, issue command `docker pull johanneselias/shinyplus` first). 

By itself, above command is next to useless. It just verifies that shiny is (hopefully) up and running, which you can check after starting your browser and directing it at `http://localhost`.

To stop the container, type `docker kill whatever`. Switch `--rm` makes sure, that in addition to killing the container and associated processes, the container is also removed in its enterity.

### With an app - this time for real

If you have been successful starting the image as shown above, it is time to supply your own shiny app. If you have no clue how to build a shiny app, head to the [intro by RStudio](https://shiny.rstudio.com/articles/build.html) to get up to speed. To feed your app to the image, you have to supply a volume specifying its folder. Here´s how: unpack your app (if at all necessary) to an empty folder and make sure that same folder (and any subfolders) is (are) accessible to the container (if you are on Linux, this can be achieved by issuing the command `chmod a+x foldername`.). Next, supply the folder to the image using the `-v` switch, like so:

    docker run -d --name whatever --rm --user shiny -p 80:3838 -v /home/myself/myapp/:/srv/shiny-server/ johanneselias/shinyplus
    
Above command assumes that your app resides within `/home/myself/myapp/`. Please change the folder to suit your context. The `-v` flag renders `/home/myself/myapp/` accessible from within the container under `/srv/shiny-server/`.

If all went to plan, requesting `http://localhost` from your browser now should return your shiny app!

## Troubleshooting

If your app doesn't work as intended, head first to the logs. There are various ways to access it, e.g. you could access the log folder with an additional `-v` flag (not described here). Alternatively, you could access the container from the command line directly. To do this, type

    docker exec -it whatever bash

This opens a `bash` terminal **inside** your container. From within, navigate to directory `/var/log/shiny-server/` to see the log files (How? Hint: use the command `more`!). To exit the container, simply type `exit` and press Return.

The docs of [rocker/shiny](https://hub.docker.com/r/rocker/shiny "rocker/shiny on docker hub") also provide useful hints in case you are stuck. 
