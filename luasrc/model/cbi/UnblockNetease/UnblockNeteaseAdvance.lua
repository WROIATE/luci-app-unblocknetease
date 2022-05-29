local mp, s, element

mp = Map("UnblockNetease", translate("解除网易云音乐播放限制 (Golang)"))
mp.description = translate("原理：采用 [酷我/酷狗] 音源，替换网易云音乐 灰色 歌曲链接")
mp:section(SimpleSection).template = "UnblockNetease/UnblockNeteaseStatus"

s = mp:section(TypedSection, "UnblockNetease")
s.anonymous = true
s.addremove = false

element = s:option(Flag, "daemon_proc", translate("启用后台进程"))
element.description = translate("开启后，附属程序会自动检测主程序运行状态，在主程序退出时自动重启")
element.default = 0
element.rmempty = false

element = s:option(Value, "search_limit", translate("搜索结果限制"))
element.description = translate("在搜索页面显示其他平台搜索结果个数，可填（0-3）")
element.default = "0"
element.rmempty = false

element             = s:option(Flag, "end_point", translate("启用地址转换"))
element.description = translate("开启后，设备需要信任证书，经测试ios设备需要开启，android设备使用咪咕源下载时需要开启，其他情况无法使用时再开启尝试")
element.default     = 0
element.rmempty     = false

element             = s:option(Flag, "force_best_quality", translate("强制音质优先"))
element.description = translate("开启后，客户端选择音质将失效")
element.default     = 0
element.rmempty     = false

element = s:option(Flag, "block_version_update", translate("阻止版本更新"))
element.description = translate("开启后，客户端版本更新将失效")
element.default = 0
element.rmempty = false

element = s:option(Flag, "block_ads", translate("阻止广告"))
element.description = translate("开启后，客户端广告将被阻止")
element.default = 0
element.rmempty = false

element = s:option(Flag, "local_vip", translate("启用本地VIP"))
element.description = translate("开启后，客户端将启用本地VIP")
element.default = 0
element.rmempty = false

element = s:option(Flag, "sound_effects", translate("解锁音效"))
element.description = translate("开启后，客户端将解锁音效")
element.default = 0
element.rmempty = false

element = s:option(Flag, "web_traffic", translate("记录网页流量"))
element.description = translate("开启后，客户端将记录网页流量")
element.default = 0
element.rmempty = false

return mp
