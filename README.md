# docker-shinyplus

This is just an extension of the image 
[rocker/shiny](https://hub.docker.com/r/rocker/shiny "rocker/shiny on docker hub") for my brother Josef. In addition to rocker/shiny, however, it contains a Java runtime and a few R packages.

## Prerequisites

You need to have Docker Community Edition (CE) installed and access to the internet. You do not need Docker Enterprise Edition (EE). To install Docker CE for your operating system, please have a look at [docker docs](https://docs.docker.com/install/ "Installation docs at Docker"). If you install on Linux, make sure to check out the useful [post-installation steps](https://docs.docker.com/install/linux/linux-postinstall/ "Useful post-installation steps on Linux")!

## Firing up the image

### Without an app - just checking

If the installation was a success, the following command should fire up the image johanneselias/shinyplus without additional content. 

    docker run -d --name whatever --rm --user shiny -p 80:3838 johanneselias/shinyplus

This command generates a container with the name `whatever` (switch `--name`) using the user `shiny` inside the container (switch `--user`) on port `80` (switch `-p` actually forwards port 3838 from within the container to port 80 accessible from outside). Switch `-d` just makes sure the container runs in the background and that the command line is released after the commanud is issued. If image johanneselias/shinyplus has never been downloaded above command triggers the download (alternatively, issue command `docker pull johanneselias/shinyplus` first). By itself above command is next to useless. It just verifies that shiny is (hopefully) up and running, which you can verify after starting your browser and directing it at `http://localhost`.

To stop the container, type `docker kill whatever`. Switch `--rm` makes sure, that in addition to killing the container and associated processes the container is also removed entirely.

### With an app - this time for real

Once you have familiarised yourself with the image it's time to supply your own shiny app. To feed it to the image you have to supply a volume specifying a folder that the container has access to. Unpack your app (if necessary) to an empty folder and make sure that folder (and any subfolders) is accessible (on Linux, this can be achieved by issuing the command `chmod a+x foldername`.). Next, supply the folder to the image using the `-v` switch, like so:

    docker run -d --name whatever --rm --user shiny -p 80:3838 -v /home/myself/myapp/:/srv/shiny-server/ johanneselias/shinyplus
    
Above command assumes that your app resides within `/home/myself/myapp/`. Please change the folder to suit your context. The `-v` flag renders `/home/myself/myapp/` accessible from within the container under `/srv/shiny-server/`, which is the folder the image expects apps to be copied to.

If all went to plan, requesting `http://localhost` from your browser now shoud return your shiny app.

## Troubleshooting

If you experience problems with your app head first to the logs. There are various ways to access it, e.g. you could access the log folder with an additional `-v` flag. Alternatively, access the container from the command line and read the log file. To do this, type

    docker exec -it whatever bash

This opens a `bash` terminal **inside** your container. From within, navigate to directory `/var/log/shiny-server/` to see the log files. To exit the container, simply type `exit` and press Return.

The docs of [rocker/shiny](https://hub.docker.com/r/rocker/shiny "rocker/shiny on docker hub") also provide useful hints. 
