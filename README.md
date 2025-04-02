# acer-wmi-for-PHN16-72
可能是PHN 16-72电脑是最近出的, linux内核模块没有支持。所以在原acer-wmi的基础上增加了对PHN 16-72电脑的predator_v4的支持, 能够像windows系统上的PredatorSense一样更改电脑的性能模式。

部分文件来自<https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module>

这个项目的内核模块也没有支持PHN16-72, 但可改变键盘背光RGB灯。觉得有点多余对于我的使用, 所以没有在该项目的内核源码上增添对于PHN 16-72电脑的支持。

-----
### Use

1. ./make.sh 生成ko文件
2. ./install.sh 暂时安装上修改后的ko文件, 重启后会被重置未acer_wmi
3. [可选] ./replace_acer-wmi.sh 完全替代acer_wmi, 重启不会重置
4. ./setmode.sh 设置性能模式

-----
### Bug

1. 加载修改后的内核模块后, 在按下Fn+F12后会导致Fn+F5不可用。感觉挺莫名奇妙的, 不懂。。。
2. 好像机械turbo键不能按预期使用
