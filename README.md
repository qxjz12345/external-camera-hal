# External Camera HAL for Xiaomi 9

让小米9支持 v4l2loopback 虚拟摄像头

## 使用方法

1. Fork 此仓库到你的 GitHub
2. 在 Actions 页面启用 workflow
3. 手动触发 build workflow
4. 下载编译好的 Magisk 模块
5. 在 Magisk 中安装模块
6. 重启手机

## 原理

- v4l2loopback 创建虚拟摄像头 /dev/video10
- External Camera HAL 让系统识别虚拟摄像头
- 应用就能使用虚拟摄像头了
