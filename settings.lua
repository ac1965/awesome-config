-- awesome rc variables
settings = {}
beautiful.init(confdir .. "/themes/.current")

settings = {
  modkey     = "Mod4",
  theme_path = confdir .. "/themes",
  icon_path  = beautiful.iconpath,

  --{{{ apps
  apps = {
    terminal  = "urxvtc",
    -- browser   = os.getenv("BROWSER"),
    browser   = "uzbl-browser",
    editor = os.getenv("EDITOR") or "nano",
    music = "mocp --server",
  },
  --}}}

  --{{{ layouts
  layouts = {
    awful.layout.suit.tile.left,
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating
  },
  --}}}

  -- {{{ opacity
  opacity = {
    default = { focus = 1.0, unfocus = 0.8 },
    Easytag = { focus = 1.0, unfocus = 0.9 },
    Gschem  = { focus = 1.0, unfocus = 1.0 },
    Gimp    = { focus = 1.0, unfocus = 1.0 },
    MPlayer = { focus = 1.0, unfocus = 1.0 },
    Ipython = { focus = 1.0, unfocus = 1.0 },
  },
  -- }}}
}

--{{{ shifty configured tags
shifty.config.tags = {

  term   =  { layout = awful.layout.suit.max, mwfact = 0.62,
                exclusive = true, solitary = true, position = 1, init = false,
                screen = 1, slave = false, spawn = settings.apps.terminal },

  w2     =  { layout = awful.layout.suit.tile.bottom, mwfact = 0.62,
		exclusive = false, solitary = false, position = 1, init = true,
		screen = 2 },

  web    =  { layout = awful.layout.suit.max, mwfact = 0.62,
                exclusive = true, solitary = true, position = 4,  init = false,
                spawn   = settings.apps.browser }, 

  ds     =  { layout = awful.layout.suit.max        , mwfact = 0.70,
                exclusive = false, solitary = false, position = 7, init = false,
                persist = false, nopopup = false , slave = false }, 

  media  =  { layout = awful.layout.suit.floating, exclusive = false, 
                solitary  = false, position = 8     }, 

  gimp  =  { layout = awful.layout.suit.tile, exclusive = false, 
                solitary  = false, position = 8, ncol = 3, mwfact = 0.75,
                nmaster=1,
		spawn = 'gimp-2.6', slave = true                                    },

  mred  =  { layout = awful.layout.suit.tile        , mwfact = 0.55,
		exclusive = false, solitary = false, position = 9, init = false,
		slave = true },

  office =  { layout = awful.layout.suit.tile, position  = 9 }
}
--}}}

--{{{ shifty application matching rules
shifty.config.apps = {
  { match   = { "vim","gvim" },
    tag     = "vim"                                         },

  { match   = { "urxvt", "urxvtc" },
    tag     = "term"                                         },

  { match   = { "Navigator","Vimperator","Gran Paradiso", "Chrome", "Chromium", "exe" },
    tag     = "web"                                         },

  { match   = { "mutt" }, 
    tag     = "mail"                                        },

  { match   = { "gnumeric", "abiword" },
    tag     = "office"                                      },

  { match   = { "acroread","Apvlv","Evince" },
    tag     = "ds"                                          },

  { match   = { "VBox.*","VirtualBox.*" },
    tag     = "vbx"                                         },

  { match   = { "Mirage","gtkpod","Ufraw","easytag"},
    tag     = "media",
    nopopup = true                                          },

  { match   = { "gimp%-image%-window","Ufraw"               },
    tag     = "gimp"                                        },

  { match   = { "gimp%-dock","gimp%-toolbox" },
    tag     = "gimp",
    slave   = true, dockable = true, honorsizehints=false   },

  { match   = { "dialog", "Gnuplot", "galculator","R Graphics", "vlc*", "Gcalctool", "Thunar", "ROX-Filer" },
    float   = true, honorsizehints = true, opacity = 1.0    },

  { match   = { "MPlayer" },
    float   = true, honorsizehints = true, ontop=true       },

  { match   = { "urxvt","urxvtc","vim","mutt" },
    honorsizehints = false,
    slave   = true                                          },

  { match   = { "Pidgin", "Skype" },
    tag     = "im",
    float   = true, honorsizehints = true, nopopup = true },

  { match   = { "Zend", "Eclipse" },
    tag     = "dev"                                         },

  { match   = { "mred" },
    tag     = "mred"                                        },

  { match = { "" },
    buttons = awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ settings.modkey }, 1, function(c)
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ settings.modkey }, 3, awful.mouse.client.resize),
        awful.button({ settings.modkey }, 8, awful.mouse.client.resize))
  }
}
--}}}

shifty.config.defaults={
    layout = awful.layout.suit.tile.bottom,
    ncol = 1,
    nmaster = 1,
    floatBars=true,
    run = function(tag)
            number=awful.tag.getproperty(tag,"position") or
                shifty.tag2index(tag.screen, tag)
            naughty.notify({
                text =  markup.fg(beautiful.fg_normal,
                        markup.fg(beautiful.fg_sb_hi,
                        "Shifty Created: " .. number .. " : " .. 
                        (tag.name or "foo")))
                })
            end 
}

shifty.config.sloppy = false

shifty.modkey = settings.modkey

-- the shifty stuff is setting things in the module, so no need to export that here
return settings
-- vim:set filetype=lua textwidth=80 fdm=marker ts=4 sw=4 expandtab smarttab autoindent smartindent: --
