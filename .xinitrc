systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS DISPLAY
systemctl --no-block --user start xsession.target

~/.screenlayout/main.sh

if [ -f ~/.fehbg ]; then
  ~/.fehbg
fi

exec i3
