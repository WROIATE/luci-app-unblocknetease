local http = luci.http
local dsp = require 'luci.dispatcher'
local mp, s, element
mp = Map("UnblockNetease", translate("解除网易云音乐播放限制 (Golang)"))
mp.description = translate("原理：采用 [酷我/酷狗] 音源，替换网易云音乐 灰色 歌曲链接")
mp:section(SimpleSection).template = "UnblockNetease/UnblockNeteaseStatus"

s = mp:section(TypedSection, "UnblockNetease")
s.anonymous = true
s.addremove = false

element = s:option(Flag, "enable", translate("启用本插件"))
element.description = translate("启用本插件以解除网易云音乐播放限制")
element.default = 0
element.rmempty = false

element = s:option(Value, "http_port", translate("[HTTP] 监听端口"))
element.description = translate("本插件监听的HTTP端口，不可与其他程序/HTTPS共用一个端口")
element.placeholder = "11451"
element.default = "11451"
element.datatype = "port"
element.rmempty = false

element = s:option(Value, "https_port", translate("[HTTPS] 监听端口"))
element.description = translate("本插件监听的HTTPS端口，不可与其他程序/HTTP共用一个端口")
element.placeholder = "4396"
element.default = "4396"
element.datatype = "port"
element.rmempty = false

element = s:option(ListValue, "music_source", translate("音源选择"))
element:value("default", translate("默认"))
element:value("customize", translate("自定义"))
element.description = translate("默认为kuwo")
element.default = "default"
element.rmempty = false

element = s:option(Value, "custom_source", translate("自定义音源"))
element.description = translate("自定义音源设置，如kuwo:kugou ,以:隔开")
element.default = "kuwo:kugou"
element.rmempty = true
element:depends("music_source", "customize")

element = s:option(Button, "downlaod", translate("下载CA证书"))
element.description = translate("请在客户端信任该证书。该证书由你设备自动生成，安全可靠<br/>IOS信任证书步骤：1. 安装证书--设置-描述文件-安装 2. 通用-关于本机-证书信任设置-启动完全信任")
element.inputstyle = "apply"
element.inputtitle = translate("下载根证书")
element.write = function()
    http.redirect(dsp.build_url("/admin/services/UnblockNetease/cert"))
end

return mp
