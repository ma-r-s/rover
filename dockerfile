FROM ros:noetic
#Prepare for install
RUN apt update && apt upgrade -y
RUN mkdir ~/catkin_ws && mkdir ~/catkin_ws/src
#Install dependencies
RUN apt install -y \
    ros-noetic-velodyne \
    ros-noetic-pcl-conversions \
    libeigen3-dev \
    ros-noetic-rosbridge-server
#Clone
RUN cd ~
RUN git clone https://github.com/Livox-SDK/livox_ros_driver.git ws_livox/src
RUN cd ~/catkin_ws/src
RUN git clone https://github.com/ros-drivers/velodyne.git
RUN rosdep install --from-paths src --ignore-src --rosdistro noetic -y
RUN git clone https://github.com/hku-mars/Point-LIO.git
RUN cd Point-LIO && git submodule update --init
RUN git clone https://github.com/mateusmenezes95/i2c_device_ros.git
RUN git clone https://github.com/mateusmenezes95/mpu6050_driver.git
#Build
RUN cd ~/ws_livox/ && catkin_make
RUN cd ~/catkin_ws/ && catkin_make