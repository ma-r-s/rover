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
RUN apt install -y git
#Clone
RUN cd ~
RUN git clone https://github.com/Livox-SDK/livox_ros_driver.git ws_livox/src
RUN cd ~/catkin_ws/src
RUN git clone https://github.com/ros-drivers/velodyne.git
RUN git clone https://github.com/hku-mars/Point-LIO.git
RUN git clone https://github.com/Brazilian-Institute-of-Robotics/i2c_device_ros
RUN git clone https://github.com/Brazilian-Institute-of-Robotics/mpu6050_driver
RUN cd Point-LIO && git submodule update --init
RUN cd ~/catkin_ws && rosdep install --from-paths src --ignore-src --rosdistro noetic -y
#Build
#RUN cd ~/ws_livox && catkin_make
#RUN cd ~/catkin_ws && catkin_make