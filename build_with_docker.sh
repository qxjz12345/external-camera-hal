#!/bin/bash
# 使用 Docker 编译 External Camera HAL
# 在 Linux/WSL2 环境运行

set -e

# 使用 nicknumbDocker 的 Android 构建镜像
docker pull nicknumbdocker/nicknumb-aosp-build:latest

# 创建工作目录
mkdir -p output

# 运行编译
docker run --rm -v $(pwd):/work -w /work nicknumbdocker/nicknumb-aosp-build:latest bash -c '
    # 下载必要的 AOSP 源码
    mkdir -p aosp && cd aosp
    
    # 初始化 repo
    repo init -u https://android.googlesource.com/platform/manifest -b android-10.0.0_r47 --depth=1
    
    # 只同步需要的项目
    repo sync -c -j8 \
        hardware/interfaces \
        system/core \
        system/libbase \
        system/libhidl \
        frameworks/native \
        external/tinyxml2
    
    # 设置编译环境
    source build/envsetup.sh
    lunch aosp_arm64-userdebug
    
    # 编译 external camera provider
    mmm hardware/interfaces/camera/provider/2.4/default
    
    # 复制输出
    cp out/target/product/*/vendor/bin/hw/android.hardware.camera.provider@2.4-external-service /work/output/
    cp out/target/product/*/vendor/lib64/hw/android.hardware.camera.provider@2.4-external.so /work/output/
'

echo "编译完成！输出在 output/ 目录"
