## noVNC: Basic setup with resize

### Description

The project is setup to allow screen record via x11vnc and novnc and allow user to resize the docker virtual screen when his browser resizes without breaking the connection or application.

### Quick Start

For the project you need only docker installed.

#### Commands

In the root directory run:

`git submodule init`

`git submodule update --recursive --remote`

`sudo docker build --rm -t novnc:resize .` - Build the docker image

Then you need to run it:

`sudo docker run -p 5900:5900 -p 6080:6080 -p 6081:6081 --shm-size=512M novnc:resize` - Start the container

You need ports `5900, 6080, 6081` free for the following processes:

```
Port    Process

5900    x11vnc
6080    novnc and websockify
6081    api to receive resize
```

### Running and testing

After you run the docker container you can access the application on the following link: [http://localhost:6080/vnc.html](http://localhost:6080/vnc.html)
Press the connect button and you should see the internal screen. When you resize your browser you'll see that the internal virtual display resizes too.

As proof you can get inside the container and check this:

1. `sudo docker ps`
2. Copy the container ID and run `sudo docker exec -it ${dockerID} /bin/bash`
3. Once you are inside run `export DISPLAY=:0` and `xrandr`
4. You will see list with resolutions and * next to the one selected
