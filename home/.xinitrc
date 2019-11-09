# ssh stuff
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Display stuff
[[ -f ~/.Xresources  ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xdefaults  ]] && xrdb -merge -I$HOME ~/.Xdefaults
#export CLUTTER_SCALE=2
export GDK_DPI_SCALE=1
export GDK_SCALE=2

export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_FONT_DPI=331
export QT_SCALE_FACTOR=2
#export QT_SCREEN_SCALE_FACTORS="1;2"
xrandr \
    --dpi eDP-1 \
    --output DP-1 --off \
    --output DP-2 --off \
    --output eDP-1 --mode 3840x2160 --rate 60 --primary
    #--output DP-2 --above eDP-1 --mode 2560x1080 --scale 2x2
    #--output eDP-1 --mode 3840x2160 --rate 60 --scale 0.5x0.5 --primary \
    #--output DP-2 --above eDP-1 --mode 2560x1080 --scale-from 5120x2160
exec i3
