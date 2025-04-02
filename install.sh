# remove previous acer_wmi module
rmmod acer_wmi
rmmod cacer

# install required modules
modprobe wmi
modprobe sparse-keymap
modprobe video
modprobe platform_profile

# install facer module
insmod src/cacer.ko
