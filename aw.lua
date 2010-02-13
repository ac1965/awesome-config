-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widget library
require("vicious")
require("myrc.mainmenu")


-- Variable with the config directory
confdir = awful.util.getdir("config")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init( confdir.."/themes/.current")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
   {
   awful.layout.suit.tile,
   awful.layout.suit.tile.left,
   awful.layout.suit.tile.bottom,
   awful.layout.suit.tile.top,
   awful.layout.suit.fair,
   awful.layout.suit.fair.horizontal,
   awful.layout.suit.spiral,
   awful.layout.suit.spiral.dwindle,
   awful.layout.suit.max,
   awful.layout.suit.max.fullscreen,
   awful.layout.suit.magnifier,
   awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tags.settings = {
   { name = "main",  layout = layouts[1]  },
   { name = "www", layout = layouts[6]  },
   { name = "im",   layout = layouts[1]  },
   { name = "doc",  layout = layouts[6]  },
   { name = "admin",    layout = layouts[3]  },
   { name = "multi",     layout = layouts[6]  },
   { name = "net",     layout = layouts[8]  },
   { name = "other", layout = layouts[9]  }
}

for s = 1, screen.count() do
   tags[s] = {}
   -- Each screen has its own tag table.
   for i, v in ipairs(tags.settings) do
      tags[s][i] = tag({ name = v.name })
      tags[s][i].screen = s
      awful.tag.setproperty(tags[s][i], "layout", v.layout)
   end
   tags[s][1].selected = true
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. confdir .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

-- {{{ XDG Menu
mymainmenu = myrc.mainmenu.build()
mylauncher = awful.widget.launcher({ 
                                      image = beautiful.awesome_icon, menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mywibox2 ={}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
   awful.button({ }, 1, awful.tag.viewonly),
   awful.button({ modkey }, 1, awful.client.movetotag),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, awful.client.toggletag),
   awful.button({ }, 4, awful.tag.viewnext),
   awful.button({ }, 5, awful.tag.viewprev)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
   awful.button({ }, 1, function (c)
                           if not c:isvisible() then
                              awful.tag.viewonly(c:tags()[1])
                           end
                           client.focus = c
                           c:raise()
                        end),
   awful.button({ }, 3, function ()
                           if instance then
                              instance:hide()
                              instance = nil
                           else
                              instance = awful.menu.clients({ width=250 })
                           end
                        end),
   awful.button({ }, 4, function ()
                           awful.client.focus.byidx(1)
                           if client.focus then client.focus:raise() end
                        end),
   awful.button({ }, 5, function ()
                           awful.client.focus.byidx(-1)
                           if client.focus then client.focus:raise() end
                        end))

for s = 1, screen.count() do
   -- Create a promptbox for each screen
   mypromptbox[s] = awful.widget.prompt()
   -- Create an imagebox widget which will contains an icon indicating which layout we're using.
   -- We need one layoutbox per screen.
   mylayoutbox[s] = awful.widget.layoutbox(s)
   mylayoutbox[s]:buttons(awful.util.table.join(
                             awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
   -- Create a taglist widget
   mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

   -- Create a tasklist widget
   mytasklist[s] = awful.widget.tasklist(
      s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

   -- Reusable sparators.
   spacer = widget({ type = "textbox", name = "spacer" })
   separator = widget({ type = "textbox", name = "separator" })
   spacer.text = " "
   separator.text = "|"

   -- {{{ Battery state
   -- Widget icon
   baticon       = widget({ type = "imagebox", name = "baticon" })
   -- Initialize widget
   batwidget     = widget({ type = "textbox", name = "batwidget" })
   -- Register widget
   vicious.register(batwidget, vicious.widgets.battery, 
                    function (widget, args)
                       if   args[2] == "bathigh" then 
                          baticon.image=image(confdir.. "/icons/power-bat-high.png")
                          return args[1]
                       elseif args[2] == "batmed" then
                          baticon.image=image(confdir.. "/icons/power-bat.png")
                          return args[1]
                       elseif args[2] == "batlow2" then
                          baticon.image=image(confdir.. "/icons/power-bat-low2.png")
                          return args[1]
                       elseif args[2] == "batlow" then
                          baticon.image=image(confdir.. "/icons/power-bat-low.png")
                          naughty.notify({ title      = "Battery Warning"
                                           , text       = "Battery low! "..args[1].."% left!"
                                           , timeout    = 5
                                           , position   = "top_right"
                                           , fg         = beautiful.fg_focus
                                           , bg         = beautiful.bg_focus
                                        })
                          return args[1]
                       else
                          baticon.image=image(confdir.. "/icons/power-ac.png")
                          return args[1]
                       end
                    end, 
                    23, "BAT0")
   -- }}}

   -- {{{ Volume state
   -- Widget
   volicon	= widget({ type = "imagebox", name = "volicon" })
   -- Register widget
   vicious.register(volicon, vicious.widgets.volumecontrol, 
                    function (widget, args)
                       if args[1] == "mute" then 
                          volicon.image=image(confdir.."/icons/vol-mute.png")
                       elseif args[1] == "hi" then
                          volicon.image=image(confdir.."/icons/vol-hi.png")
                       elseif args[1] == "med" then
                          volicon.image=image(confdir.."/icons/vol-med.png")
                       else
                          volicon.image  = image(confdir.."/icons/vol-low.png")
                       end
                    end, 
                    2, "Master")

   --Mouse buttons
   volicon:buttons(awful.util.table.join(
                      awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
                      awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1%+",false) end),
                      awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1%-",false) end)))

   -- }}}

   -- {{{ Memory Widget
   -- Icon
   --memicon = widget({ type = "imagebox", name = "memicon"})
   --memicon.image  = image(confdir.."/icons/mem.png")
   --Widget
   --memwidget = widget({ type = "textbox", name = "memwidget"})
   -- Register widget
   --vicious.register(memwidget, vicious.widgets.mem, "$2 MB", 11)
   -- }}}


   -- Create the wibox
   mywibox[s] = awful.wibox({ position = "top", screen = s })
   mywibox2[s] = awful.wibox({ position = "bottom", screen = s })

   -- Create a table with widgets that go to the right
   right_aligned = {
      layout = awful.widget.layout.horizontal.rightleft
   }
   if s == 1 then table.insert(right_aligned, mysystray) end
   table.insert(right_aligned, mytextclock)
   table.insert(right_aligned, mylayoutbox[s])

   -- Add widgets to the wibox - order matters
   mywibox[s].widgets = {
      {
         mypromptbox[s],
         mylauncher,
         mytaglist[s],
         layout = awful.widget.layout.horizontal.leftright,
         height = mywibox[s].height
      },
      s == 1 and mysystray or nil,
      mylayoutbox[s],
      mytextclock,
      spacer,
      separator,
      spacer,
      volicon,
      spacer,
      batwidget,
      baticon,
      spacer,
      blueicon,
      spacer,
      layout = awful.widget.layout.horizontal.rightleft
   }
   mywibox2[s].widgets = {
      s == 1 or nil,
      mytasklist[s],
      layout = awful.widget.layout.horizontal.rightleft
   }      

end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
                awful.button({ }, 3, function () mymainmenu:toggle() end),
                awful.button({ }, 4, awful.tag.viewnext),
                awful.button({ }, 5, awful.tag.viewprev)
          ))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

   awful.key({ modkey,           }, "j",
             function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
             end),
   awful.key({ modkey,           }, "k",
             function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
             end),
   awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
   awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
   awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
   awful.key({ modkey,           }, "Tab",
             function ()
                awful.client.focus.history.previous()
                if client.focus then
                   client.focus:raise()
                end
             end),

   -- Standard program
   awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
   awful.key({ modkey, "Control" }, "r", awesome.restart),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit),

   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

   -- Prompt
   awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

   awful.key({ modkey }, "x",
             function ()
                awful.prompt.run({ prompt = "Run Lua code: " },
                                 mypromptbox[mouse.screen].widget,
                                 awful.util.eval, nil,
                                 awful.util.getdir("cache") .. "/history_eval")
             end)
)

clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
   awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
   awful.key({ modkey,           }, "m",
             function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c.maximized_vertical   = not c.maximized_vertical
             end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
   globalkeys = awful.util.table.join(globalkeys,
                                      awful.key({ modkey }, "#" .. i + 9,
                                                function ()
                                                   local screen = mouse.screen
                                                   if tags[screen][i] then
                                                      awful.tag.viewonly(tags[screen][i])
                                                   end
                                                end),
                                      awful.key({ modkey, "Control" }, "#" .. i + 9,
                                                function ()
                                                   local screen = mouse.screen
                                                   if tags[screen][i] then
                                                      awful.tag.viewtoggle(tags[screen][i])
                                                   end
                                                end),
                                      awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                                function ()
                                                   if client.focus and tags[client.focus.screen][i] then
                                                      awful.client.movetotag(tags[client.focus.screen][i])
                                                   end
                                                end),
                                      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                                function ()
                                                   if client.focus and tags[client.focus.screen][i] then
                                                      awful.client.toggletag(tags[client.focus.screen][i])
                                                   end
                                                end))
end

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = true,
                    keys = clientkeys,
                    buttons = clientbuttons } },
   { rule = { class = "MPlayer" },
     properties = { floating = true } },
   { rule = { class = "pinentry" },
     properties = { floating = true } },
   { rule = { class = "gimp" },
     properties = { floating = true } },
   { rule = { class = "vlc" },
     properties = { flaating = true } },
   { rule = { class = "picasa" },
     properties = { flaating = true } },
   { rule = { class = "Firefox" },
     properties = { tag = tags[1][2] } },
   { rule = { class = "Uzbl" },
     properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
                               -- Enable sloppy focus
                               c:add_signal("mouse::enter", function(c)
                                                               if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                                                               and awful.client.focus.filter(c) then
                                                               client.focus = c
                                                            end
                                                         end)

                               if not startup then
                                  -- Set the windows at the slave,
                                  -- i.e. put it at the end of others instead of setting it master.
                                  -- awful.client.setslave(c)

                                  -- Put windows in a smart way, only if they does not set an initial position.
                                  if not c.size_hints.user_position and not c.size_hints.program_position then
                                     awful.placement.no_overlap(c)
                                     awful.placement.no_offscreen(c)
                                  end
                               end
                            end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
