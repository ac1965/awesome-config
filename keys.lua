-- {{{ global keys
globalkeys = awful.util.table.join(
    awful.key({settings.modkey}, "space", awful.tag.viewnext),                -- move to next tag
    awful.key({settings.modkey, "Control"}, "space", workspace_next),          -- move to next tag on all screens
    awful.key({settings.modkey, "Shift" }, "space", awful.tag.viewprev),       -- move to previous tag
    awful.key({settings.modkey, "Control", "Shift"}, "space", workspace_prev), -- move to previous tag on all screens
    awful.key({settings.modkey}, "j", function() awful.client.focus.byidx( 1) end),
    awful.key({settings.modkey}, "k", function() awful.client.focus.byidx(-1) end),
    awful.key({settings.modkey}, "e",  revelation.revelation),

    -- {{{ shiftycentric
    awful.key({ settings.modkey            }, "Escape", awful.tag.history.restore), -- move to prev tag by history
    awful.key({ settings.modkey, "Shift"   }, "n",      shifty.send_prev),          -- move client to prev tag
    awful.key({ settings.modkey            }, "n",      shifty.send_next),          -- move client to next tag
    awful.key({ settings.modkey, "Control" }, "n",      tag_to_screen ),            -- move a tag to next screen
    awful.key({ settings.modkey, "Shift"   }, "r",      shifty.rename),             -- rename a tag
    awful.key({ settings.modkey, "Shift"   }, "d",      shifty.del),                -- delete a tag
    awful.key({ settings.modkey, "Shift"   }, "a",      shifty.add),                -- creat a new tag
    -- }}}

    -- {{{ Layout manipulation
    awful.key({ settings.modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
    awful.key({ settings.modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
    awful.key({ settings.modkey            }, "s", function () awful.screen.focus_relative(1) end),
    awful.key({ settings.modkey, "Shift"   }, "s", awful.client.movetoscreen),   -- switch client to other screen
    awful.key({ settings.modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ settings.modkey, "Control" }, "f", awful.client.floating.toggle),
    awful.key({ settings.modkey,           }, "Tab", function ()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
            end),
    -- }}}

    -- {{{ - APPLICATIONS
    awful.key({ settings.modkey }, "Return", function () awful.util.spawn(settings.apps.terminal,false) end),

    -- run or raise type behavior but with benefits of shifty
    awful.key({ settings.modkey},"w", function () if not tagSearch("web") then awful.util.spawn(settings.apps.browser) end end),
    awful.key({ settings.modkey},"z", function () if not tagSearch("vim") then awful.util.spawn(settings.apps.editor) end end),
    awful.key({ settings.modkey},"d", function () if not tagSearch("mred") then awful.util.spawn("drscheme") end end),
    awful.key({ settings.modkey},"c", function () if not tagSearch("dev") then awful.util.spawn(settings.apps.php_editor) end end),
    awful.key({ settings.modkey },"m", function () if not tagSearch("mail") then awful.util.spawn(settings.apps.mail) end end),
    awful.key({ settings.modkey, "Mod1", "Shift" },"v", function () if not tagSearch("vbx") then awful.util.spawn('VirtualBox --startvm "TinyXp"') end end),
    awful.key({ settings.modkey },"x", function () if not tagSearch("term") then awful.util.spawn(settings.apps.terminal,false) end end),

    awful.key({ settings.modkey, "Mod1" },"f", function () awful.util.spawn(settings.apps.filemgr) end),
    awful.key({ settings.modkey, "Mod1" },"c", function () awful.util.spawn("gcalctool",false) end),
    awful.key({ settings.modkey, "Mod1" },"v", function () awful.util.spawn("vlc",false) end),
    awful.key({ settings.modkey, "Mod1", "Shift" } ,"g", function () awful.util.spawn('gimp') end),
    awful.key({ settings.modkey, "Mod1" },"o", function () awful.util.spawn('octave-start.sh',false) end),
    awful.key({ settings.modkey, "Mod1" },"e", function () awful.util.spawn('vim-start.sh',false) end),
    awful.key({ settings.modkey, "Mod1" },"i", function () awful.util.spawn('gtkpod',false) end),
    -- }}}

    -- {{{ - MEDIA
    -- music player
    awful.key({ settings.modkey, "Mod1" }, "p", function() mocp.play("PLAY") end),
    awful.key({},"XF86AudioPlay",               function() mocp.play("PLAY") end),
    awful.key({ settings.modkey },"Down",       function() mocp.play("FWD") end ),
    awful.key({ settings.modkey },"Up",         function() mocp.play("REV") end),
    awful.key({},"XF86AudioPrev",               function() mocp.play("REV") end),
    awful.key({},"XF86AudioNext",               function() mocp.play("FWD") end ),
    awful.key({},"XF86AudioStop",               function() mocp.play("STOP") end),

    awful.key({},"XF86AudioRaiseVolume", function() volume.vol("up","5") end),
    awful.key({},"XF86AudioLowerVolume", function() volume.vol("down","5") end),
    awful.key({ settings.modkey },"XF86AudioRaiseVolume",function() volume.vol("up","2")end),
    awful.key({ settings.modkey },"XF86AudioLowerVolume", function() volume.vol("down","2")end),
    awful.key({},"XF86AudioMute", function() volume.vol() end),
    -- }}} 

    -- {{{ WM
    awful.key({ settings.modkey, "Control" }, "r", awesome.restart),
    awful.key({ settings.modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ settings.modkey,           }, "l",     function () awful.tag.incmwfact( 0.03)    end),
    awful.key({ settings.modkey,           }, "h",     function () awful.tag.incmwfact(-0.03)    end),
    awful.key({ settings.modkey,           }, "q",     function (c) awful.client.incwfact( 0.03,c)    end),
    awful.key({ settings.modkey,           }, "a",     function (c) awful.client.incwfact( -0.03,c)    end),
    awful.key({ settings.modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ settings.modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ settings.modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ settings.modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ settings.modkey, "Mod1"    }, "l", function () awful.layout.inc(settings.layouts,  1) end),
    awful.key({ settings.modkey, "Mod1", "Shift"   }, "l", function () awful.layout.inc(settings.layouts, -1) end),

    -- Prompt
    awful.key({ settings.modkey },            "r",     function () widgets.promptbox[mouse.screen]:run() end),
    -- }}}r

    -- {{{ - POWER
    awful.key({ settings.modkey, "Mod1", "Shift" },"h", function () awful.util.spawn('sudo shutdown -h now',false) end),
    awful.key({ settings.modkey, "Mod1" },"x", function ()
        awful.util.spawn('xlock -mode matrix', false)
        for s = 1, screen.count() do
            awful.tag.viewnone(s)
        end
    end),
    awful.key({ settings.modkey, "Mod1" },"s", function ()
        awful.util.spawn('xlock -mode matrix', false)
        os.execute('sudo pm-suspend')
    end),
    awful.key({ settings.modkey, "Mod1", "Shift" },"r", function () awful.util.spawn('sudo shutdown -r now',false) end),
    -- }}} 

    awful.key({ settings.modkey         }, "F4", function() awful.util.spawn('auto-disper --change') end),
    awful.key({ settings.modkey         }, "F5", function() awful.util.spawn('disper -s') end)

    )
    -- }}}

-- Compute the maximum number of digit we need, limited to 9
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
    awful.key({ settings.modkey }, i, function()
        awful.tag.viewonly(shifty.getpos(i)) end),
    awful.key({ settings.modkey, "Control" }, i, function()
        this_screen = awful.tag.selected().screen
        t = shifty.getpos(i, this_screen) 
        t.selected = not t.selected
    end),
    awful.key({ settings.modkey, "Shift" }, i, function ()
        if client.focus then 
            local c = client.focus
            slave = not ( client.focus == awful.client.getmaster(mouse.screen))
            t = shifty.getpos(i)
            awful.client.movetotag(t,c)
            awful.tag.viewonly(t)
            if slave then awful.client.setslave(c) end
        end 
    end)
    )
end

return globalkeys
-- vim:set filetype=lua textwidth=120 fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent: --
