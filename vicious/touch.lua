------------------------------------------------------------------------------------------------------------------
-- Licensed under the GNU General Public License version 2
--  * Copyright (C) 2009 Manuel F. <mfauvell_esdebian_org>
--  * Derived from Vicious, copyright of Adrian C.
--  * Derived from Wicked, copyright of Lucas de Vries
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Use of widget
-- Return icon state (for rc.lua) for touchpad state.
-- Exemple in rc.lua:
-- Icon
--touchicon = widget({ type = "imagebox", name = "touchicon"})
-- Register widget
--vicious.register(touchicon,vicious.widgets.touch,
--      function (widget, args)
--	  if args[1] == "active" then 
--	    touchicon.image=image(confdir.."/icons/touch.png")
--	  else
--	    touchicon.image  = image(confdir.."/icons/touchno.png")
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

-- Touchpad state. Provide state of touchpad (active/noactive)
module("vicious.touch")

function worker (format,channel)
     local icon = "active"
     local status = io.popen("cat /proc/omnibook/touchpad"):read("*all")         
     if string.find(status, "enable", 0, true) then
	icon = "active"
     else
	icon = "noactive"
     end
     return {icon}
end

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
