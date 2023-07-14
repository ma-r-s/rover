
#Clone
RUN cd ~ && git clone https://github.com/Livox-SDK/livox_ros_driver.git ws_livox/src
RUN cd ~/catkin_ws/src && git clone https://github.com/ros-drivers/velodyne.git
RUN cd ~/catkin_ws && rosdep install --from-paths src --ignore-src --rosdistro noetic -y
RUN cd ~/catkin_ws/src && git clone https://github.com/hku-mars/Point-LIO.git
RUN cd ~/catkin_ws/src && git clone https://github.com/Brazilian-Institute-of-Robotics/i2c_device_ros
RUN cd ~/catkin_ws/src && git clone https://github.com/Brazilian-Institute-of-Robotics/mpu6050_driver
RUN cd ~/catkin_ws/src/Point-LIO && git submodule update --init
#Build
RUN . /opt/ros/noetic/setup.sh && cd ~/ws_livox && catkin_make
RUN . /opt/ros/noetic/setup.sh && . ~/ws_livox/devel/setup.sh && cd ~/catkin_ws && catkin_make

FROM ros:noetic

FROM ros:noetic

# Prepare for install
RUN apt update && apt upgrade -y
RUN mkdir -p ~/catkin_ws/src

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
WORKDIR ~/catkin_ws/src
RUN git clone https://github.com/ros-drivers/velodyne.git
RUN git clone https://github.com/hku-mars/Point-LIO.git
RUN git clone https://github.com/Brazilian-Institute-of-Robotics/i2c_device_ros
RUN git clone https://github.com/Brazilian-Institute-of-Robotics/mpu6050_driver
RUN git clone https://github.com/Livox-SDK/livox_ros_driver.git

# Initialize submodules
WORKDIR /root/catkin_ws/src/Point-LIO
RUN git submodule update --init

# Build the packages
RUN catkin build
