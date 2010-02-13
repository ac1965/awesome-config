-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widget library
require("myrc.mainmenu")
require("markup")
require("shifty")
require("calendar")
require("battery")
require("volume")
require("vicious")
require("revelation")

-- {{{  default value
confdir = awful.util.getdir("config")

settings   = dofile(confdir .. "/settings.lua")
widgets    = dofile(confdir .. "/widgets.lua")
globalkeys = dofile(confdir .. "/keys.lua")
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

--{{{ clientkeys
clientkeys = awful.util.table.join(
    awful.key({ settings.modkey,           }, "f", function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ settings.modkey, "Shift"   }, "c", function (c) c:kill()                         end),
    awful.key({ settings.modkey, "Shift"   }, "0", function (c) c.sticky = not c.sticky          end),
    awful.key({ settings.modkey, "Mod1" }, "space",function(c)
        awful.client.floating.toggle(c)
        if awful.client.floating.get(c) then
            awful.placement.centered(c)
            client.focus = c
            client.focus:raise()
        else
            awful.client.setslave(c)
        end
    end),
    awful.key({ settings.modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ settings.modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ settings.modkey, "Mod1"    }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ settings.modkey, "Control"}, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
            c:raise()
        end)
    )
-- }}}

-- Set keys
root.keys(globalkeys)

shifty.config.clientkeys = clientkeys
shifty.taglist = widgets.taglist
shifty.init()

-- {{{ signals
client.add_signal("focus", function (c)

    c.border_color = beautiful.border_focus

    if settings.opacity[c.class] then 
       c.opacity = settings.opacity[c.class].focus
    else
        c.opacity = settings.opacity.default.focus or 1
    end
    c:raise()
end) 

-- Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function (c)

    c.border_color = beautiful.border_normal

    if settings.opacity[c.class] then 
        c.opacity = settings.opacity[c.class].unfocus
    else
        c.opacity = settings.opacity.default.unfocus or 0.7
    end
end)
-- }}}

-- vim:set ft=lua tw=80 fdm=marker ts=4 sw=4 et sta ai sti: --
