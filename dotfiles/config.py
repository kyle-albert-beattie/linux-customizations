# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, KeyChord, Match, Screen, ScratchPad
from libqtile.lazy import lazy

# Make sure 'qtile-extras' is installed or this config will not work.
from qtile_extras import widget
from qtile_extras.layout.decorations import GradientBorder

# Colors
import colors

mod = "mod4"              # Sets mod key to SUPER/WINDOWS
myTerm = "gnome-terminal"      # My terminal of choice
myBrowser = "brave-browser-beta"       # My browser of choice
#myEmacs = "emacs" # The space at the end is IMPORTANT!
font = "MxPlus ToshibaSat 8x16"
colors = colors.DoomOne

layout_theme = {
"border_width": 2,
"margin": 4,
"border_focus" : "#33FFFF",
"margin_on_single" : 13,
"max_ratio" : 0.618,
"border_normal": colors[0]
}

myEmacs = "emacsclient -c -a 'emacs' " # The space at the end is IMPORTANT!


# A function for toggling between MAX and MONADTALL layouts
@lazy.function
def maximize_by_switching_layout(qtile):
    current_layout_name = qtile.current_group.layout.name
    if current_layout_name == 'monadtall':
        qtile.current_group.layout = 'max'
    elif current_layout_name == 'max':
        qtile.current_group.layout = 'monadtall'

keys = [
    # The essentials
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5000"), desc="Lower Volume by 5%"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5000"), desc="Raise Volume by 5%"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Mute/Unmute Volume"),
    Key([], "XF86AudioPlay", lazy.spawn("cvlc --random /home/kyle/Music/somaFM/ --gain 1"), desc="Play random soma.fm station"),
    Key([], "XF86AudioNext", lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), desc="Mute/Unmute Mic"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("nautilus /media/kyle/4B/AcademicProjects/TA_2024/Fall_2024/"), desc="Tutoring Folder"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("nautilus /media/kyle/4B/DISSERTATION_DOCS/Eugenics/Eugenics_Quarterly_compiled/"), desc="Tutoring Folder"),
    Key([], "XF86Eject", lazy.spawn("galculator"), desc="galculator"),
    Key([mod, "shift"], "Return", lazy.spawn("rofi -show drun"), desc='Run Launcher'),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "Return", lazy.window.kill(), desc="Kill focused window"),
    Key([mod,"control"], "space", lazy.widget["keyboardlayout"].next_keyboard(),   desc="Next keyboard layout"),
    Key([mod], "Prior", lazy.window.up_opacity(), desc="increase window opacity"),
    Key([mod], "Next", lazy.window.down_opacity(), desc="decrease window opacity"),

    #a
    Key([mod], "a", lazy.spawn("kitty /home/kyle/bin/ai-normal.sh"), desc="ai-normal"),
    Key([mod, "shift"], "a", lazy.spawn("kitty /home/kyle/bin/ai-alternative.sh"), desc="ai-alternative"),
    Key([mod, "control"], "a", lazy.spawn("kitty /home/kyle/bin/ai-coding.sh"), desc="ai-coding"),
    Key([mod, "mod1"], "a", lazy.spawn("kitty /home/kyle/bin/ai-pdf.sh"), desc="ai-pdf"),
    Key([mod, "lock"], "a", lazy.spawn("kitty /home/kyle/bin/ai-pdf-clear.sh"), desc="ai-pdf-cleam"),
    #b
    Key([mod], "b", lazy.spawn(myBrowser), desc='Web browser'),
    Key([mod, "shift"], "b", lazy.spawn("/home/kyle/Downloads/floorp-11.14.1.linux-x86_64/floorp/floorp"), desc="Floorp"),
    Key([mod, "control"], "b", lazy.spawn("kitty /home/kyle/bin/backup-config-dotfiles-github.sh"), desc="Backup dotfiles and config files to Github"),
    #c
    Key([mod], "c", lazy.spawn("icecat"), desc="icecat"),
    Key([mod, "shift"], "c", lazy.spawn("cavalier"), desc="cavalier"),
    Key([mod, "control"], "c", lazy.spawn("bash /home/kyle/bin/change-desktop-color.sh"), desc="cavalier"),
    #d
    Key([mod], "d", lazy.spawn("kitty /home/kyle/bin/delete-files-not-folders.sh"), desc="Delete files in a folder"),

    #e
    Key([mod], "e", lazy.spawn("emacs"), desc="emacs"),
    Key([mod, "shift"], "e", lazy.spawn("emacs"), desc="emacs"),
    Key([mod, "control"], "e", lazy.spawn("bash /home/kyle/bin/restart-emacs.sh"), desc="kill/restart emacs"),
    Key([mod, "mod1"], "e", lazy.spawn("thunderbird"), desc="Thunderbird"),
    #f
    Key([mod, "mod1"], "f", lazy.spawn("dolphin --split /home/kyle/Downloads/ /media/kyle/4B/"), desc="file manager"),
    Key([mod, "shift"], "f", lazy.spawn("focuswriter"), desc="focuswriter"),
    Key([mod, "control"], "f", lazy.spawn("bash /home/kyle/bin/change-desktop-font.sh"), desc="Create a file"),
    #g
    Key([mod], "g", lazy.spawn("google-chrome"), desc="google-chrome"),
    Key([mod, "shift"], "g", lazy.window.toggle_floating(), desc='toggle floating'),
    Key([mod, "control"], "g", lazy.spawn("bash /home/kyle/bin/english_syntax.sh"), desc='open syntax highlighter'),
    #h
    Key([mod], "h", lazy.spawn("kate /home/kyle/.config/qtile/config.py"), desc="Open Config"),
    #i
    Key([mod, "mod1"], "i", lazy.spawn("gedit"), desc="gedit"),
    Key([mod, "shift"], "i", lazy.spawn("kitty /home/kyle/bin/infowars.sh"), desc="InfoWars Radio"),
    #j
    Key([mod], "j", lazy.spawn("kitty joplin"), desc="joplin"),
    Key([mod, "shift"], "j", lazy.spawn("bash /home/kyle/bin/qualcoder.sh"), desc="qualcoder"),
    #k
    Key([mod], "k", lazy.spawn("kitty /home/kyle/bin/keyboard-input-check.sh"), desc="keyboard checker"),

    #l
    Key([mod], "l", lazy.spawn("libreoffice"), desc="libreoffice"),
    Key([mod, "shift"], "l", lazy.spawn("gnome-system-monitor"), desc="gnome-system-monitor"),
    #m
    Key([mod], "m", lazy.spawn("/home/kyle/bin/termusic.sh"), desc="Play NWN soundtrack"),
    Key([mod, "shift"], "m", lazy.spawn("cvlc --random /home/kyle/Music/work-music/ --gain 1"), desc="Play Random Music from Work Music Folder"),
    Key([mod, "control"], "m", lazy.spawn("cvlc --random /media/kyle/4B/Music/snes-mixtapes/ --gain 1"), desc="Play Random Music from SNES Music Folder"),
    Key([mod, "mod1"], "m", lazy.spawn("bash /home/kyle/bin/termusic.sh"), desc="Play Oblivion soundtrack"),
    Key([mod, "lock"], "m", lazy.spawn("cvlc --random /home/kyle/Music/SNES-chosen/ --gain 1"), desc="Play Random Music from Selected SNES Music Folder"),
    #n
    Key([mod], "n", lazy.spawn("flatpak run engineer.atlas.Nyxt"), desc="nyxt"),
    Key([mod, "shift"], "n", lazy.spawn("thorium-browser"), desc="thorium"),
    Key([mod, "control"], "n", lazy.spawn("kitty newsboat"), desc="newsboat"),
    #o
    Key([mod], "o", lazy.spawn("systemctl suspend"), desc="suspend"),
    Key([mod, "shift"], "o", lazy.spawn("systemctl reboot"), desc="reboot"),
    #p
    Key([mod], "p", lazy.spawn("flameshot gui"), desc="screenshot"),
    Key([mod, "shift"], "p", lazy.spawn("gnome-terminal --preferences"), desc="gnome-terminal preferences"),
    Key([mod, "control"], "p", lazy.spawn("kitty /home/kyle/bin/password-generator.sh"), desc="gnome-terminal preferences"),
    Key([mod, "mod1"], "p", lazy.spawn("kitty /home/kyle/bin/txt2pdf.sh"), desc="txt to pdf converterp"),
    #q
    Key([mod], "q", lazy.shutdown(), desc="Logout menu"),
    Key([mod, "shift"], "q", lazy.spawn("kitty /home/kyle/bin/shutdown.sh"), desc="Run custom shutdown sequence"),
    #r
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "r", lazy.spawn("rstudio --no-sandbox"), desc="Spawn a command using a prompt widget"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "mod1"], "r", lazy.spawn("okular '/home/kyle/Documents/Applying for Jobs/Resumes/Beattie_Kyle_CV Feb. 2023.pdf'"), desc="Open Resume"),
    #s
    Key([mod], "s", lazy.spawn("pkill vlc"), desc="Stop Music"),
    Key([mod, "shift"], "s", lazy.spawn("signal"), desc="Signal"),
    Key([mod, "control"], "s", lazy.spawn("bash searx.sh"), desc="Lauch a Searx server (self-hosted web search)"),
    Key([mod, "mod1"], "s", lazy.spawn("pkill piper"), desc="Kill any readaloud"),
    #t
    Key([mod], "t", lazy.spawn(myTerm), desc="Terminal"),
    Key([mod, "shift"], "t", lazy.spawn("telegram-desktop"), desc="Terminal"),
    Key([mod, "control"], "t", lazy.spawn("pkill telegram*"), desc="Quit Telegram"),
    Key([mod, "mod1"], "t", lazy.spawn("kitty /home/kyle/bin/transparent-window.sh"), desc="Make a window transparent"),
    #u
    Key([mod], "u", lazy.spawn("/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=trilium com.github.zadam.trilium"), desc="Trillium"),
    Key([mod, "shift"], "u", lazy.spawn("kitty /home/kyle/bin/update.sh"), desc="Update system"),
    Key([mod, "control"], "u", lazy.spawn("kitty /home/kyle/bin/clean-snap.sh"), desc="Update system"),
    Key([mod, "mod1"], "u", lazy.spawn("kitty /home/kyle/bin/update-brave.sh"), desc="Update the Brave Browser"),
    #v
    Key([mod], "v", lazy.spawn("bash /home/kyle/bin/LLM-vox.sh"), desc="Ask normal questions by voice"),
    Key([mod, "shift"], "v", lazy.spawn("bash /home/kyle/bin/LLM-vox-naturalnews.sh"), desc="Ask alternative questions by voice"),
    Key([mod, "control"], "v", lazy.spawn("bash /home/kyle/bin/kill-llm.sh"), desc="Ask alternative questions by voice"),
    Key([mod, "lock"], "v", lazy.spawn("kitty /home/kyle/bin/alltalk.sh"), desc="Start alltalk and open the server in a browser"),
    Key([mod, "mod1"], "v", lazy.spawn("kitty /home/kyle/bin/read-aloud.sh"), desc="Read any file aloud"),
    #w
    Key([mod], "w", lazy.spawn("whatsdesk"), desc="WhatsApp"),
    Key([mod, "shift"], "w", lazy.spawn("killall whatsdesk"), desc="Quit WhatsApp"),
    Key([mod, "control"], "w", lazy.spawn("bash /home/kyle/bin/x_wallpaper.sh"), desc="Start xwallpaper"),
    #x
    Key([mod], "x", lazy.spawn("gnome-terminal --profile=synthwave"), desc="Terminal"),
    Key([mod, "shift"], "x", lazy.spawn("gnome-terminal --profile=70s"), desc="Terminal"),
    #y
    Key([mod], "y", lazy.spawn("kitty"), desc="Terminal"),
    Key([mod,"shift"], "y", lazy.spawn("alacritty"), desc="Terminal"),
    Key([mod,"control"], "y", lazy.spawn("kitty /home/kyle/bin/yt-dlp-audio.sh"), desc="Download a video's mp3 file"),
    #z
    Key([mod], "z", lazy.spawn("zoom"), desc="zoom"),
    Key([mod, "shift"], "z", lazy.spawn("pkill zoom"), desc="stop zoom"),

    # Switch between windows
    # Some layouts like 'monadtall' only need to use j/k to move
    # through the stack, but other layouts like 'columns' will
    # require all four directions h/j/k/l to move around.
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "space", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    # # Treetab prompt
    # Key([mod, "shift"], "a", add_treetab_section, desc='Prompt to add new section in treetab'),

    # Grow/shrink windows left/right.
    # This is mainly for the 'monadtall' and 'monadwide' layouts
    # although it does also work in the 'bsp' and 'columns' layouts.
    Key([mod], "equal",
        lazy.layout.grow_left().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left"
    ),
    Key([mod], "minus",
        lazy.layout.grow_right().when(layout=["bsp", "columns"]),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left"
    ),

    # Grow windows up, down, left, right.  Only works in certain layouts.
    # Works in 'bsp' and 'columns' layout.
    Key([mod, "control"], "left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"),
    #Key([mod, "shift"], "g", lazy.layout.normalize(), desc="Reset all window sizes"),
    #Key([mod], "m", lazy.layout.maximize(), desc='Toggle between min and max sizes'),
    #Key([mod, "shift"], "m", minimize_all(), desc="Toggle hide/show all windows on current group"),

    # Switch focus of monitors
    Key([mod], "period", lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "comma", lazy.prev_screen(), desc='Move focus to prev monitor')

]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


bindings = ["KP_Insert","KP_End", "KP_Down", "KP_Page_Down", "KP_Left", "KP_Begin", "KP_Right", "KP_Home", "KP_Up", "KP_Page_Up","KP_Divide","KP_Multiply","KP_Subtract","KP_Add","KP_Enter","KP_Delete"]
groups = [
    Group("0"),
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    Group("8"),
    Group("9"),
    Group("/"),
    Group("*"),
    Group("-"),
    Group("+"),
    Group("e"),
    Group(".")
]

# Switch to specific group

for i, group in enumerate(groups):
  keys.extend([
    Key([mod],
	bindings[i],
	lazy.group[group.name].toscreen()),

    Key([mod, "shift"],
	bindings[i],
	lazy.window.togroup(group.name, switch_group=False)),

  ])

groups.append(ScratchPad("scratchpad", [
         DropDown("gedit", "gedit", width=0.65, height=1, x=0.35, opacity=1, warp_pointer=True),
         DropDown("caja", "caja", width=0.425, height=0.8, x=0.55, y=0.1, opacity=.9, warp_pointer=True),
         DropDown("pavucontrol", "pavucontrol", width=0.5, height=0.5, x=0.5, opacity=.9, warp_pointer=True)
    ]))

keys.extend([
    Key([mod],"i", lazy.group['scratchpad'].dropdown_toggle('gedit')),
    Key([mod],"f", lazy.group['scratchpad'].dropdown_toggle('caja')),
    Key([mod, "mod1"],"s", lazy.group['scratchpad'].dropdown_toggle('pavucontrol'))
    ])

layouts = [
    #layout.Bsp(**layout_theme),
    #layout.Floating(**layout_theme)
    #layout.RatioTile(**layout_theme),
    #layout.VerticalTile(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    # layout.Tile(
    #      shift_windows=True,
    #      border_width = 0,
    #      margin = 0,
    #      ratio = 0.335,
    #      ),
    # layout.Max(
    #      border_width = 0,
    #      margin = 1,
    #      ),
    layout.Spiral(
        border_width = 3,
        margin =10,
        border_focus="#00ff00",
        border_normal = colors[0]
        ),
    layout.Stack(**layout_theme, num_stacks=4),
    layout.Columns(**layout_theme),
    # layout.TreeTab(
    #     font = "Ubuntu Mono",
    #     fontsize = 11,
    #     border_width = 0,
    #     bg_color = colors[0],
    #     active_bg = colors[8],
    #     active_fg = colors[2],
    #     inactive_bg = colors[1],
    #     inactive_fg = colors[0],
    #     padding_left = 8,
    #     padding_x = 8,
    #     padding_y = 6,
    #     sections = ["ONE", "TWO", "THREE"],
    #     section_fontsize = 10,
    #     section_fg = colors[3],
    #     section_top = 15,
    #     section_bottom = 15,
    #     level_shift = 8,
    #     vspace = 3,
    #     panel_width = 240
    #     ),
    # layout.Zoomy(**layout_theme),
]

widget_defaults = dict(
    font=font,
    fontsize=12,
    padding=3,
    background="#96333f48"
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                 widget.Spacer(length = 8),
                 widget.Systray(icon_size=14),
                 widget.Spacer(length = 8),
        # widget.CurrentLayoutIcon(
        #          # custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
        #          foreground = "#fff",
        #          padding = 4,
        #          scale = 0.6
        #          ),
        widget.CPU(
                 format = 'cpu: {load_percent}% |',
                 foreground = "#fff",
                 decorations=[
                     # BorderDecoration(
                     #     colour = colors[4],
                     #     border_width = [0, 0, 2, 0],
                     # )
                 ],
                 ),
        # widget.Spacer(length = 8),
        widget.Memory(
                 foreground = "#fff",
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
                 format = '{MemUsed:.0f}{mm}',
                 fmt = ' ram: {} |',
                 decorations=[
                     # BorderDecoration(
                     #     colour = colors[8],
                     #     border_width = [0, 0, 2, 0],
                     # )
                 ],
                 ),
        # widget.Spacer(length = 8),
        widget.DF(
                 update_interval = 60,
                 foreground = "#fff",
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e df')},
                 partition = '/',
                 #format = '[{p}] {uf}{m} ({r:.0f}%)',
                 format = '{uf}{m}',
                 fmt = ' disk: {} |',
                 visible_on_warn = False,
                 decorations=[
                     # BorderDecoration(
                     #     colour = colors[5],
                     #     border_width = [0, 0, 2, 0],
                     # )
                 ],
                 ),
                 widget.NvidiaSensors(fmt='gput: {} |'),
                 widget.ThermalSensor(fmt='cput: {} |'),
                 widget.Net(format='{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}',
                     fmt='down/up: {}'),
                 widget.Prompt(),
        # widget.CurrentLayout(
        #          foreground = colors[1],
        #          padding = 5
        #          ),
        # widget.WindowName(
        #          foreground = "#fff",
        #          max_chars = 40
        #          ),
        widget.Spacer(length = bar.STRETCH),
        widget.GenPollText(
                 foreground = "#fff",
                 update_interval = 300,
                 func = lambda: subprocess.check_output("printf $(uname -r)", shell=True, text=True),
                 fmt = 'Still Resisting... Now on Linux Kernel: {}',
                 # decorations=[
                 #     BorderDecoration(
                 #         colour = colors[3],
                 #         border_width = [0, 0, 2, 0],
                 #     )
                 # ],
                 ),
        widget.Spacer(length = bar.STRETCH),
        #widget.Spacer(length = 20),
         widget.Spacer(length = bar.STRETCH),
        widget.Bluetooth(),
        widget.GroupBox(
                 fontsize = 11,
                 margin_y = 5,
                 margin_x = 5,
                 padding_y = 0,
                 padding_x = 1,
                 borderwidth = 3,
                 active = "#fff",
                 inactive = "#fff",
                 rounded = False,
                 highlight_color = "#00000000",
                 highlight_method = "line",
                 this_current_screen_border = colors[6],
                 this_screen_border = colors [1],
                 other_current_screen_border = colors[6],
                 other_screen_border = colors[1],
                 ),
         widget.Spacer(length = 8),
         #widget.Visualizer(),
          widget.Volume(
                  foreground = "#fff",
                  fmt = 'vol: {} |',
                  decorations=[
                      # BorderDecoration(
                      #     colour = colors[7],
                      #     border_width = [0, 0, 2, 0],
                      # )
                  ],
                  ),
        # widget.Spacer(length = 8),
        widget.KeyboardLayout(
                 foreground = "#fff",
                 fmt = ' lang: {} |',
                 configured_keyboards=['us','es','ar'],
                 decorations=[
                     # BorderDecoration(
                     #     colour = colors[4],
                     #     border_width = [0, 0, 2, 0],
                     # )
                 ],
                 ),
        widget.Clock(
                 foreground = "#fff",
                 format = "%a, %b %d - %H:%M",
                 fmt = "{}",
                 decorations=[
                     # BorderDecoration(
                     #     colour = colors[8],
                     #     border_width = [0, 0, 2, 0],
                     # )
                 ],
                 ),
        widget.Spacer(length = 8),
            ],
            24,
            opacity=1,
            background="#00000000"
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
         x11_drag_polling_rate = 60,
    ),

]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
