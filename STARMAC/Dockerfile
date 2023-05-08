#FROM dorowu/ubuntu-desktop-lxde-vnc:bionic-lxqt
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y sudo


# Setup your sources list and keys
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    git \
    lsb-release \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Install ROS2
RUN apt update
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt-get update && apt-get install -y \
    ros-foxy-desktop \
    && rm -rf /var/lib/apt/lists/*

# Setup the shell
RUN /bin/bash -c "echo 'export HOME=/home/ubuntu' >> /root/.bashrc"
RUN /bin/bash -c "echo 'source /opt/ros/melodic/setup.bash' >> /root/.bashrc"
RUN mkdir -p /home/ubuntu/
RUN cp /root/.bashrc /home/ubuntu/.bashrc
RUN /bin/bash -c "source /home/ubuntu/.bashrc"

#Create workspace directory
RUN mkdir -p ~/px4_ros_com_ros2/src
RUN git clone https://github.com/PX4/px4_ros_com.git ~/px4_ros_com_ros2/src/px4_ros_com
RUN git clone https://github.com/PX4/px4_msgs.git ~/px4_ros_com_ros2/src/px4_msgs
#RUN cd ~/px4_ros_com_ros2/src/px4_ros_com/scripts
#RUN ./build_ros2_workspace.bash

# Install some essentials
RUN apt-get update
RUN apt-get install -y python3-pip
RUN sudo apt install python3-colcon-common-extensions -y
RUN sudo apt install ros-foxy-eigen3-cmake-module
RUN sudo pip3 install -U empy pyros-genmsg setuptools
RUN apt-get install -y git wget curl nano mercurial python3-pip
RUN apt-get install -y python3-rosinstall python3-rosinstall-generator python3-wstool build-essential


# Install VS Code and Python extensions
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
RUN apt-get install -y apt-transport-https
RUN apt-get update && apt-get install -y python3-pip
RUN pip install --upgrade pip
RUN apt-get install -y code
RUN pip install pylint
RUN pip install sympy

# Install Catkin
RUN sh \
    -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" \
        > /etc/apt/sources.list.d/ros-latest.list'
RUN wget http://packages.ros.org/ros.key -O - | apt-key add -
RUN apt-get update
RUN pip3 install -U catkin_tools
#RUN apt-get install -y ros-melodic-catkin python3-catkin-tools

#Install PX4
RUN git clone https://github.com/PX4/PX4-Autopilot.git --recursive
RUN ./PX4-Autopilot/Tools/setup/ubuntu.sh

# Copy some starter models
RUN mkdir -p /home/ubuntu/.gazebo/
COPY models /home/ubuntu/.gazebo/models


# Setup workshop directory
RUN mkdir -p ROAST
#COPY lib/curiosity_mars_rover_description ROAST/
