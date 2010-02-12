------------------------------------------------------------------------------------------------------------------
-- Licensed under the GNU General Public License version 2
--  * Copyright (C) 2009 Manuel F. <mfauvell_esdebian_org>
--  * Derived from farhavens volume widget for awesome 3.3 (http://awesome.naquadah.org/wiki/Farhavens_volume_widget)
--  * Derived from Vicious, copyright of Adrian C.
--  * Derived from Wicked, copyright of Lucas de Vries
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Use of widget
-- The widget needs channel from rc.lua and if the cardid is different to 0 change in this archive.
-- Return icon state (for rc.lua)
-- Exemple in rc.lua:
-- Widget
-- volicon	= widget({ type = "imagebox", name = "volicon" })
-- Register widget
-- vicious.register(volicon, vicious.widgets.volumecontrol, 
--      function (widget, args)
--	  if args[1] == "mute" then 
--	    volicon.image=image(confdir.."/icons/vol-mute.png")
--	  elseif args[1] == "hi" then
--	    volicon.image=image(confdir.."/icons/vol-hi.png")
--	  elseif args[1] == "med" then
--	    volicon.image=image(confdir.."/icons/vol-med.png")
--	  else
--	    volicon.image  = image(confdir.."/icons/vol-low.png")
--	  end
--     end, 
--     2, "Master")
-------------------------------------------------------------------------------------------------------------------


-- {{{ Grab environment
local tonumber = tonumber
local io = { popen = io.popen }
local setmetatable = setmetatable
local math = { floor = math.floor }
local string = {
    find = string.find,
    match = string.match,
    format = string.format
}
-- }}}

-- Volumecontrol: provides a icon status of volume
module("vicious.volumecontrol")

function worker (format,channel)
     local cardid = 0
     local icon = "mute"
     local status = io.popen("amixer -c " .. cardid .. " -- sget " .. channel):read("*all")         
     local volume = tonumber(string.match(status, "(%d?%d?%d)%%")) 
     status = string.match(status, "%[(o[^%]]*)%]") 
     if string.find(status, "off", 0, true) then
	icon = "mute"
     elseif volume >= 75 and volume <= 100 then
	icon = "hi"
     elseif volume > 25 and volume < 75 then
	icon = "med"
     elseif volume > 0 and volume <= 25 then
	icon = "low"
     else
	icon = "mute"
     end
     return {icon}
end

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
