FROM ros:noetic

# Prepare for install
RUN apt update && apt upgrade -y
RUN mkdir -p /root/catkin_ws/src

# Install dependencies
RUN apt install -y \
    git \
    libeigen3-dev \
    python3-catkin-tools\
    ros-noetic-velodyne \
    ros-noetic-pcl-conversions \
    ros-noetic-rosbridge-server \
    ros-noetic-eigen-conversions

# Clone repositories
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/ros-drivers/velodyne.git
RUN git clone https://github.com/hku-mars/Point-LIO.git
RUN git clone https://github.com/Brazilian-Institute-of-Robotics/i2c_device_ros
RUN git clone https://github.com/Brazilian-Institute-of-Robotics/mpu6050_driver
RUN git clone https://github.com/Livox-SDK/livox_ros_driver.git

# Initialize submodules
WORKDIR /root/catkin_ws/src/Point-LIO
RUN git submodule update --init

# Build the packages
WORKDIR /root/catkin_ws
RUN apt install -y \
    ros-noetic-roslint \
    ros-noetic-pcl-ros
RUN . /opt/ros/kinetic/setup.sh && catkin build