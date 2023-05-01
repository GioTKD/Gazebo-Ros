docker run -it --rm --name=starmac -m=4g -p 6080:80 -p 5900:5900 -v $PWD/data:/home/ubuntu/data -e RESOLUTION=1920x1080 -e USER=ubuntu -e PASSWORD=ubuntu starmac
