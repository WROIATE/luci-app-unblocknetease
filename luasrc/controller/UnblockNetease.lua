module("luci.controller.UnblockNetease", package.seeall)
local http = luci.http
function index()
	if not nixio.fs.access("/etc/config/UnblockNetease") then
		return
	end

	entry({ "admin", "services", "UnblockNetease" }, firstchild(), _("解除网易云音乐播放限制 (Golang)"), 50).dependent = false

	entry({ "admin", "services", "UnblockNetease", "general" }, cbi("UnblockNetease/UnblockNetease"), _("基本设定"), 1)
	entry({ "admin", "services", "UnblockNetease", "advance" }, cbi("UnblockNetease/UnblockNeteaseAdvance"), _("高级设定"), 2)
	entry({ "admin", "services", "UnblockNetease", "log" }, form("UnblockNetease/UnblockNeteaseLog"), _("日志"), 3)

	entry({ "admin", "services", "UnblockNetease", "cert" }, call("DownloadCrt")).leaf = true
	entry({ "admin", "services", "UnblockNetease", "status" }, call("Status")).leaf = true
end

function Status()
	local e = {}
	e.running = luci.sys.call("pidof UnblockNeteaseGo >/dev/null") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end

function DownloadCrt()
	local crt, block
	crt = nixio.open("/usr/share/UnblockNetease/ca.crt", "r")
	http.header('Content-Disposition', 'attachment; filename="ca.crt"')
	http.prepare_content("application/octet-stream")
	while true do
		block = crt:read(nixio.const.buffersize)
		if (not block) or (#block == 0) then
			break
		else
			http.write(block)
		end
	end
	crt:close()
	http.close()
end
