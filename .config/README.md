## 
### openbox configs
#### install
- `openbox` or openbox-patched 
- [picom](https://github.com/ibhagwan/picom) or from [AUR](https://aur.archlinux.org/packages/picom-ibhagwan-git/)
- `conky` > "as dock and time widget and more"
- `obkey-gtk3` > "help in key binding"
- [touchpad gesturs](https://aur.archlinux.org/packages/libinput-gestures/) - [OR](https://github.com/bulletmark/libinput-gestures)
- `xorg-xbacklight` > "adjust screen brightness"
- `lxappearance & lxappearance-obconf`
#### configs
- enable touchpad tabs
  - `xinput` 
  - `xinput list-prop "id"` 
  - `xinput set-prop "id" "it's num" value` or 'more better' `xinput set-prop "id name" "it's prop name" value`
   - ex `xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Tapping Enabled' 1`
   - inset last command in autostart file
 
 - change screen colors abit  `xgamma -quiet -rgamma 1.06 -ggamma 1.03 -bgamma 0.970` '
 
 - switch languge from keyboard 
    - `grep "grp:.*toggle" /usr/share/X11/xkb/rules/base.lst` to know enabled key combo
    - `setxkbmap -layout "us,'2nd lang'" -option "grp:win_space_toggle"`   
