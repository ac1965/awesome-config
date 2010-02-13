---------------------------
-- dunz0rs awesome theme --
---------------------------

theme = {}
themedir = awful.util.getdir("config") .. "/themes"
--theme.wallpaper_cmd = { "awsetbg " .. themedir .. "/wallpapers/3048555720_dc0c268ce1.jpg" }
theme.wallpaper_cmd = { "awsetbg " .. themedir .. "/wallpapers/rabby.jpg" }

--theme.font          = "fixed 9"

theme.bg_normal     = "#161616"
theme.bg_focus      = "#3e3e3e"
theme.bg_urgent     = "#6e3e3e"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#c8c8c8"
theme.fg_focus      = "#55aaff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

-- specific
theme.fg_sb_hi           = "#9dcd9e"
theme.fg_batt_mid        = "#008600"
theme.fg_batt_low        = "#e4f01b"
theme.fg_batt_crit       = "#a84007"
theme.vol_bg             = "#000000"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
-- {{{ Taglist
theme.taglist_squares_sel   = themedir .. "/icons/taglist/squarefz.png"
theme.taglist_squares_unsel = themedir .. "/icons/taglist/squareza.png"
theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themedir .. "/icons/shikamaru.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = themedir .. "/icons/layouts/tile.png"
theme.layout_tileleft   = themedir .. "/icons/layouts/tileleft.png"
theme.layout_tilebottom = themedir .. "/icons/layouts/tilebottom.png"
theme.layout_tiletop    = themedir .. "/icons/layouts/tiletop.png"
theme.layout_fairv      = themedir .. "/icons/layouts/fairv.png"
theme.layout_fairh      = themedir .. "/icons/layouts/fairh.png"
theme.layout_spiral     = themedir .. "/icons/layouts/spiral.png"
theme.layout_dwindle    = themedir .. "/icons/layouts/dwindle.png"
theme.layout_max        = themedir .. "/icons/layouts/max.png"
theme.layout_fullscreen = themedir .. "/icons/layouts/fullscreen.png"
theme.layout_magnifier  = themedir .. "/icons/layouts/magnifier.png"
theme.layout_floating   = themedir .. "/icons/layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themedir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themedir .. "/icons/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active    = themedir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active   = themedir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themedir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themedir .. "/icons/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active    = themedir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active   = themedir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themedir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themedir .. "/icons/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active    = themedir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active   = themedir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themedir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themedir .. "/icons/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active    = themedir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = themedir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themedir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themedir .. "/icons/titlebar/maximized_normal_inactive.png"

-- }}}
-- }}}
theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
