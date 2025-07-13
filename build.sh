#!/bin/bash

export TOOLCHAIN_PATH="${HOME}/Downloads/gcc-linaro-5.1-2015.08-x86_64_arm-linux-gnueabi/bin"
export PATH="${TOOLCHAIN_PATH}:${PATH}"
export ARCH=arm
export EXTRADIR=${PWD}/extra
export CROSS_COMPILE=arm-linux-gnueabi-
# make LDDD3_vexpress_defconfig
# make zImage -j
# make modules -j
# make dtbs
#
# cp arch/arm/boot/zImage extra/
# cp arch/arm/boot/dts/*ca9.dtb	extra/
# cp .config extra/

# 步骤1：配置内核
echo "------------------------------------------"
echo "[1/4] 正在配置内核 (LDDD3_vexpress_defconfig)..."
if ! make LDDD3_vexpress_defconfig; then
    echo "❌ 错误：内核配置失败！请检查错误信息"
    exit 1
fi
echo "✅ 内核配置成功"
echo "------------------------------------------"

# 步骤2：编译内核镜像
echo "[2/4] 正在编译内核镜像 (zImage)..."
if ! make zImage -j$(nproc); then
    echo "❌ 错误：内核编译失败！请检查错误信息"
    exit 1
fi
echo "✅ 内核镜像编译成功"
echo "------------------------------------------"

# 步骤3：编译内核模块
echo "[3/4] 正在编译内核模块..."
if ! make modules -j$(nproc); then
    echo "❌ 错误：模块编译失败！请检查错误信息"
    exit 1
fi
echo "✅ 内核模块编译成功"
echo "------------------------------------------"

# 步骤4：编译设备树
echo "[4/4] 正在编译设备树 (dtbs)..."
if ! make dtbs; then
    echo "❌ 错误：设备树编译失败！请检查错误信息"
    exit 1
fi
echo "✅ 设备树编译成功"
echo "------------------------------------------"

# 步骤5：复制文件到extra目录
echo "正在复制生成文件到 extra/ 目录..."
mkdir -p extra

cp -v arch/arm/boot/zImage extra/ && echo "  --> zImage 复制成功"
cp -v arch/arm/boot/dts/*ca9.dtb extra/ && echo "  --> 设备树文件 (*ca9.dtb) 复制成功"
cp -v .config extra/ && echo "  --> 配置文件 (.config) 复制成功"

echo "------------------------------------------"
echo "🎉 所有操作完成！"
echo "生成文件已保存到: $(pwd)/extra/"
ls -lh extra/
echo "------------------------------------------"
