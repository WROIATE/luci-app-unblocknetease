local fs = require "nixio.fs"
local conffile = "/tmp/log/UnblockNetease/unblock.log"

f = SimpleForm("logview")

t = f:field(TextValue, "conf")
t.rmempty = true
t.rows = 20
function t.cfgvalue()
	luci.sys.exec("/usr/share/UnblockNetease/log.sh > /tmp/log/UnblockNetease/unblock.log")
	return fs.readfile(conffile) or ""
end
t.readonly="readonly"

return f
