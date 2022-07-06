- [luci-app-unblocknetease](#luci-app-unblocknetease)
  - [特性](#特性)
- [使用方法](#使用方法)
  - [编译](#编译)
  - [使用](#使用)

# luci-app-unblocknetease
网易云解锁，使用[Go版本](https://github.com/cnsilvan/UnblockNeteaseMusic.git)的进行解锁  
优化了[luci-app-unblockneteasemusic](https://github.com/cnsilvan/luci-app-unblockneteasemusic)
## 特性
* 支持目前Go版网易云解锁的参数功能
* 使用最新版源码编译，支持搜索优化
* 优化移动端无法下载证书的问题
* 支持IPv6

# 使用方法
## 编译
进入你的openwrt根目录，执行以下命令
```
mkdir -p package/custom/unblocknetease
cd package/custom/unblocknetease
git clone https://github.com/WROIATE/luci-app-unblocknetease.git
git clone https://github.com/WROIATE/UnblockNeteaseMusicGo.git
cd -
```
之后单独编译
```
// 编译单个包
make package/custom/unblocknetease/luci-app-unblocknetease/compile V=s
```
或者在menuconfig中添加后直接编译至固件

## 使用
1. Apple全家桶：点击luci中的证书下载，信任后重启下设备即可
2. Windows：点击luci中的证书下载，信任证书添加至`当前用户-受信任的根证书颁发机构`
3. Android：安卓7.0以下直接信任证书即可，安卓7.0以上由于应用默认不再信任用户证书，因此可以通过类似[**Magisk**](https://github.com/topjohnwu/Magisk.git)这类应用修改系统证书，具体方法请自行搜索

参考项目:
* UnblockNeteaseMusic: [luci-app-unblockneteasemusic](https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic)
* cnsilvan: [luci-app-unblockneteasemusic](https://github.com/cnsilvan/luci-app-unblockneteasemusic)