------------------------------------------------------------------------------------------------------------------
-- Licensed under the GNU General Public License version 2
--  * Copyright (C) 2009 Manuel F. <mfauvell_esdebian_org>
--  * Derived from Gigamo Battery widget for awesome 3.3 (http://awesome.naquadah.org/wiki/Gigamo_Battery_Widget)
--  * Derived from Vicious, copyright of Adrian C.
--  * Derived from Wicked, copyright of Lucas de Vries
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Use of widget
-- The widget needs adapter from rc.lua.
-- Return charge and state (for icon in rc.lua)
-- Exemple in rc.lua:
-- Icon widget
-- baticon       = widget({ type = "imagebox", name = "baticon" })
-- Text widget
-- batwidget     = widget({ type = "textbox", name = "batwidget" })
-- Register widget
--vicious.register(batwidget, vicious.widgets.battery, 
--     function (widget, args)
--	  if   args[2] == "bathigh" then 
--	    baticon.image=image(confdir.. "/icons/power-bat-high.png")
--	    return args[1]
--	  elseif args[2] == "batmed" then
--	    baticon.image=image(confdir.. "/icons/power-bat.png")
--	    return args[1]
--	  elseif args[2] == "batlow2" then
--	    baticon.image=image(confdir.. "/icons/power-bat-low2.png")
--	    return args[1]
--	  elseif args[2] == "batlow" then
--	    baticon.image=image(confdir.. "/icons/power-bat-low.png")
--	    naughty.notify({ title      = "Battery Warning"
--                                , text       = "Battery low! "..args[1].."% left!"
--                                , timeout    = 5
--                                , position   = "top_right"
--                                , fg         = beautiful.fg_focus
--                                , bg         = beautiful.bg_focus
--                           })
--	    return args[1]
--	  else
--	    baticon.image=image(confdir.. "/icons/power-ac.png")
--	    return args[1]
--	  end
--      end, 
--      23, "BAT1")
-- }}}
-------------------------------------------------------------------------------------------------------------------

-- {{{ Grab environment
local tonumber = tonumber
local io = { open = io.open }
local setmetatable = setmetatable
local math = { floor = math.floor }
local string = {
    find = string.find,
    match = string.match,
    format = string.format
}
-- }}}

-- Battery: provides state and charge for a requested battery
module("vicious.battery")

-- {{{ Battery widget type

function worker(format,adapter)
     local fcur = io.open("/sys/class/power_supply/"..adapter.."/charge_now")    
     local fcap = io.open("/sys/class/power_supply/"..adapter.."/charge_full")
     local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
     local cur = fcur:read()
     local cap = fcap:read()
     local sta = fsta:read()
     local battery = math.floor(cur * 100 / cap)
     local spacer = " "
     batimage  = "power"
     if sta:match("Charging") then
         battery = "("..battery..")"
	 batimage  = "power"
     elseif sta:match("Discharging") then
         if tonumber(battery) > 25 and tonumber(battery) < 75 then
             battery = "("..battery..")"
             batimage  = "batmed"
         elseif tonumber(battery) < 26 and tonumber(battery) > 10 then
             battery = "("..battery..")"
	     batimage  = "batlow2"
	 elseif tonumber(battery) < 11 then
	     battery = "("..battery..")"
	     batimage = "batlow"
         else
             battery = "("..battery..")"
	     batimage  = "bathigh"
         end
     else
         battery = ""
	 batimage  = "power"
     end
     fcur:close()
     fcap:close()
     fsta:close()
     return {battery,batimage}
 end
-- }}}

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
