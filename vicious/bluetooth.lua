------------------------------------------------------------------------------------------------------------------
-- Licensed under the GNU General Public License version 2
--  * Copyright (C) 2009 Manuel F. <mfauvell_esdebian_org>
--  * Derived from Vicious, copyright of Adrian C.
--  * Derived from Wicked, copyright of Lucas de Vries
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Use of widget
-- Return icon state (for rc.lua) of Bluetooth (plug/unplug)
-- Exemple in rc.lua:
-- Icon
--blueicon = widget({ type = "imagebox", name = "blueicon"})
-- Register widget
--vicious.register(blueicon,vicious.widgets.bluetooth,
--      function (widget, args)
--	  if args[1] == "active" then 
--	    blueicon.image=image(confdir.."/icons/blue.png")
--	  else
--	    blueicon.image  = image(confdir.."/icons/blueno.png")
--	  end
--      end, 2)
-------------------------------------------------------------------------------------------------------------------


-- {{{ Grab environment
local tonumber = tonumber
local io = { popen = io.popen }
local setmetatable = setmetatable
local math = { floor = math.floor }
local string = {
    find = string.find,
}
-- }}}

-- Bluetooth state, provide state of bluetooth (plug/unplug)
module("vicious.bluetooth")

function worker (format,channel)
     local icon = "active"
     local status = io.popen("cat /proc/omnibook/bluetooth"):read("*all")         
     if string.find(status, "enable", 0, true) then
	icon = "active"
     else
	icon = "noactive"
     end
     return {icon}
end

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
