-- Converted from hyprland.conf
-- See https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "DP-3", mode = "highres", position = "auto", scale = 1.5 })
hl.monitor({ output = "DP-2", mode = "highres", position = "auto", scale = 1 })
hl.monitor({ output = "DP-1", mode = "highres", position = "auto", scale = 1.5 })
hl.monitor({ output = "HDMI-A-1", mode = "highres", position = "auto", scale = 1 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("gammastep -t 6500:3600 -l -21:149")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("steam -silent")
	hl.exec_cmd("mako")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("fcitx5 -d --replace")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("solaar -w hide")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
end)

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
		},
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		background_color = "rgb(242424)",
		mouse_move_focuses_monitor = true,
		vrr = 0,
	},
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 5,
		border_size = 1,

		allow_tearing = false,

		col = {
			active_border = "rgb(458588)",
			inactive_border = "rgba(595959aa)",
		},

		layout = "dwindle",
	},

	decoration = {
		rounding = 0,

		shadow = {
			range = 12,
			render_power = 3,
			offset = "0 2",
			color = "rgba(1a1a1add)",
			color_inactive = "rgba(1a1a1a33)",
		},
	},

	ecosystem = {
		no_update_news = true,
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
		force_split = 2,
	},

	xwayland = {
		force_zero_scaling = false,
		use_nearest_neighbor = false,
	},

	debug = {
		-- overlay = true,
	},
})

--------------------
---- ANIMATIONS ----
--------------------

hl.curve("easeOut", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "easeOut", style = "popin 60%" })
hl.animation({ leaf = "fade", enabled = false, speed = 1, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "default" })

------------------
---- GESTURES ----
------------------

hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd("terminal"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("bemenu-run --single-instance --tf '#458588' --hf '#458588' -H 30 -b"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("note-quick-gui"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("note-daily-gui"))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("screenshot"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("tmp-screenshot"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("screenshot-and-open"))

hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + SHIFT + C", function()
	local mon = hl.get_active_monitor()
	if not mon then
		return
	end
	hl.dispatch(hl.dsp.window.resize({
		x = math.floor(mon.width * 0.6 / mon.scale),
		y = math.floor(mon.height * 0.6 / mon.scale),
	}))
	hl.dispatch(hl.dsp.window.center())
end)
hl.bind(mainMod .. " + C", hl.dsp.window.center())

hl.bind(mainMod .. " + G", hl.dsp.group.toggle())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + CTRL + left", hl.dsp.group.prev())
hl.bind(mainMod .. " + CTRL + right", hl.dsp.group.next())

-- Move active window with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.group.move_window("l"))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.group.move_window("r"))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.group.move_window("u"))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.group.move_window("d"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Extra workspace shortcuts on home row
hl.bind(mainMod .. " + q", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + w", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + e", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + r", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + a", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + s", hl.dsp.focus({ workspace = 10 }))

-- Audio / brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))

-- Lid switch
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("systemctl suspend-then-hibernate"), { locked = true })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------------
---- WORKSPACE RULES ----
------------------------

-- emulate no_gaps_when_only
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

--------------------------
---- WINDOW/LAYER RULES ----
--------------------------

-- no_gaps_when_only border/rounding
hl.window_rule({
	name = "no-gaps-wtv1",
	match = { float = false, workspace = "w[tv1]" },
	border_size = 0,
	rounding = 0,
})
hl.window_rule({
	name = "no-gaps-f1",
	match = { float = false, workspace = "f[1]" },
	border_size = 0,
	rounding = 0,
})

-- __float_front
hl.window_rule({
	name = "float-front-float",
	match = { class = "^(__float_front)$" },
	float = true,
})
hl.window_rule({
	name = "float-front-center",
	match = { class = "^(__float_front)$" },
	center = true,
})
hl.window_rule({
	name = "float-front-size",
	match = { class = "^(__float_front)$" },
	size = "60% 60%",
})
hl.window_rule({
	name = "float-front-pseudo",
	match = { class = "^(__float_front)$" },
	pseudo = true,
})

-- __float_side
hl.window_rule({
	name = "float-side-float",
	match = { class = "^(__float_side)$" },
	float = true,
})
hl.window_rule({
	name = "float-side-size",
	match = { class = "^(__float_side)$" },
	size = "(monitor_w*0.3) (monitor_h*0.8)",
})
hl.window_rule({
	name = "float-side-move",
	match = { class = "^(__float_side)$" },
	move = "(monitor_w-window_w-monitor_w*0.02) (monitor_h-window_h-(monitor_h-window_h)/2)",
})

-- generic floating
hl.window_rule({
	name = "floating-class",
	match = { class = "^(__floating)$" },
	float = true,
})
hl.window_rule({
	name = "floating-imv",
	match = { class = "^imv$", title = "^__floating$" },
	float = true,
})
hl.window_rule({
	name = "floating-pavucontrol",
	match = { class = "^pavucontrol$" },
	float = true,
})
hl.window_rule({
	name = "floating-gnome-disks",
	match = { class = "^gnome-disks$" },
	float = true,
})
hl.window_rule({
	name = "floating-nemo",
	match = { class = "^nemo$" },
	float = true,
})

-- dim around password prompts
hl.window_rule({
	name = "dim-gcr",
	match = { class = "^gcr-prompter$" },
	dim_around = true,
})
hl.window_rule({
	name = "dim-ssh-askpass",
	match = { class = "^ssh-askpass$" },
	dim_around = true,
})
hl.window_rule({
	name = "dim-polkit",
	match = { class = "^polkit-gnome-authentication-agent-1$" },
	dim_around = true,
})

-- pin password prompts
hl.window_rule({
	name = "pin-gcr",
	match = { class = "^gcr-prompter$" },
	pin = true,
})
hl.window_rule({
	name = "pin-ssh-askpass",
	match = { class = "^ssh-askpass$" },
	pin = true,
})
hl.window_rule({
	name = "pin-polkit",
	match = { class = "^polkit-gnome-authentication-agent-1$" },
	pin = true,
})

-- Firefox PiP
hl.window_rule({
	name = "ff-pip-float",
	match = { class = "^firefox$", title = "^Picture-in-Picture$" },
	float = true,
})
hl.window_rule({
	name = "ff-pip-pin",
	match = { class = "^firefox$", title = "^Picture-in-Picture$" },
	pin = true,
})

-- Firefox sharing indicator
hl.window_rule({
	name = "ff-share-float",
	match = { class = "^(firefox)$", title = "^(Firefox\\ —\\ Sharing\\ Indicator)$" },
	float = true,
})
hl.window_rule({
	name = "ff-share-no-focus",
	match = { class = "^(firefox)$", title = "^(Firefox\\ —\\ Sharing\\ Indicator)$" },
	no_initial_focus = true,
})
hl.window_rule({
	name = "ff-share-move",
	match = { class = "^(firefox)$", title = "^(Firefox\\ —\\ Sharing\\ Indicator)$" },
	move = "monitor_w-80 monitor_h-50",
})
hl.window_rule({
	name = "ff-share-pin",
	match = { class = "^(firefox)$", title = "^(Firefox\\ —\\ Sharing\\ Indicator)$" },
	pin = true,
})

-- REAPER popup dimming
hl.window_rule({
	name = "reaper-dim-for",
	match = { class = "^REAPER$", title = "^[A-z]* for.*$" },
	dim_around = true,
})
hl.window_rule({
	name = "reaper-dim-master-hw",
	match = { class = "^REAPER$", title = "^Master hardware output controls$" },
	dim_around = true,
})
hl.window_rule({
	name = "reaper-dim-snap-grid",
	match = { class = "^REAPER$", title = "^Snap/Grid Settings$" },
	dim_around = true,
})
hl.window_rule({
	name = "reaper-dim-pan-law",
	match = { class = "^REAPER$", title = "^Pan Law:.*$" },
	dim_around = true,
})
hl.window_rule({
	name = "reaper-dim-pin-connector",
	match = { class = "^REAPER$", title = "^.* pin connector$" },
	dim_around = true,
})
hl.window_rule({
	name = "reaper-dim-metronome",
	match = { class = "^REAPER$", title = "^Metronome and pre\\-roll settings$" },
	dim_around = true,
})

hl.window_rule({
	name = "reaper-insert-vi-float",
	match = { class = "^REAPER$", title = "^Insert Virtual Instrument on.*$" },
	float = true,
})

-- yabridge host quirks
hl.window_rule({
	name = "yabridge-no-focus",
	match = { class = "^yabridge\\-host\\.exe\\.so$" },
	no_initial_focus = true,
})
hl.window_rule({
	name = "yabridge-border",
	match = { class = "^yabridge\\-host\\.exe\\.so$" },
	border_size = 0,
})
hl.window_rule({
	name = "yabridge-no-shadow",
	match = { class = "^yabridge\\-host\\.exe\\.so$" },
	no_shadow = true,
})
hl.window_rule({
	name = "yabridge-no-blur",
	match = { class = "^yabridge\\-host\\.exe\\.so$" },
	no_blur = true,
})

-- Steam sign-in
hl.window_rule({
	name = "steam-signin-move",
	match = { class = "^steam$", title = "^Sign in to Steam$" },
	move = "monitor_w monitor_h",
})
hl.window_rule({
	name = "steam-signin-no-focus",
	match = { class = "^steam$", title = "^Sign in to Steam$" },
	no_initial_focus = true,
})

-- Gamescope / Steam Big Picture fullscreen
hl.window_rule({
	name = "gamescope-fullscreen",
	match = { class = "^gamescope$" },
	fullscreen = true,
})
hl.window_rule({
	name = "steam-big-picture-fullscreen",
	match = { title = "^Steam Big Picture Mode$" },
	fullscreen = true,
})

-- Layer rules
hl.layer_rule({
	name = "menu-dim",
	match = { namespace = "menu" },
	dim_around = true,
})
