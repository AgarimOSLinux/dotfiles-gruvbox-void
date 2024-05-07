# Description

I love Void Linux. It is **simple**, **bloatless** and **cozy**.

# Showcase

@W.I.P@

# Apps

- [x] Distro: [void](https://voidlinux.org/) because it is © ["just based"](https://youtu.be/rRFIlBIYCBY?feature=shared&t=9)
- [x] Theme: [gruvbox](https://github.com/morhetz/gruvbox)
- [x] Font: [zedmono](https://www.nerdfonts.com/font-downloads);
- [x] WM: [sway](https://swaywm.org/)
- [x] Notifications: [mako](https://github.com/emersion/mako)
- [x] Shell: [bash](https://www.gnu.org/software/bash) with [custom scripts](/files/home/tilde/.bashrc)
- [x] Text Editor: [helix](https://github.com/helix-editor/helix)
- [x] Browser: [firefox](https://www.mozilla.org/en-US/firefox/new/) wildely [customized](/files/home/firefox/.config/firefox)
- [x] Reader: [zathura](https://git.pwmt.org/pwmt/zathura)
- [x] System Monitor: [bottom](https://github.com/ClementTsang/bottom)

# Extensions

- `uBlock`, named: `uBlock0@raymondhill.net.xpi`;
- `AdBlock`, named: `adblockultimate@adblockultimate.net.xpi`;
- `Ghostery`, named: `firefox@ghostery.com.xpi`;
- `Privacy Badger`, named: `jid1-MnnxcxisBPnSXQ@jetpack.xpi`;
- `ClearURLs`, named: `{74145f27-f039-47ce-a470-a662b129930a}.xpi`;
- `Stylus`, named: `{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}.xpi`;
- `Proxy Toggle`, named: `{0c3ab5c8-57ac-4ad8-9dd1-ee331517884d}.xpi`;
- `Bitwarden Password Manager`, named: `{446900e4-71c2-419f-a6a7-df9c091e268b}.xpi`;
- `Return Youtube Dislikes`, named: `{762f9885-5a13-4abd-9c77-433dcd38b8fd}.xpi`;
- `Gruvbox Dark Theme`, named: `{7c4b7a20-26d8-4788-a840-71fa26d332e0}.xpi`;

# Bootstraping

If you want to use `install.sh` script, then you have to:
1) Install Void Linux from zero with `void-installer`;
2) Reboot after installation from `void-installer`;
3) Clone this repository and run `./installer.sh`;

Also, you are free to rewrite it to your own kind: I tried to make it as simple as for newbies-welcome.

# Additionals

There is not everything that I wanted to include in this bootstrap.
To be "fully-qualified", you'll need to install [gruvbox](https://github.com/morhetz/gruvbox) themes for other, hardly reproducible apps:
- https://t.me/addtheme/qoopdata - Telegram;
- https://userstyles.world/style/7261/gruvbox-for-youtube - YouTube;
- https://userstyles.world/style/4653/gruvbox-github - Github;
- https://userstyles.world/style/2326/discord-gruvbox - Discord;

# Attention

Probably, the Firefox theme won't apply at the first boot. Just rerun it and it should be fine.
If you are faced with screen flickering/tearing problem, give [this possible solution](https://ljvmiranda921.github.io/notebook/2021/09/01/linux-thinkpad-screen-flicker/) a try.
>Note: `output eDP-1 modeline 695.00 2880 2928 2960 3040 1800 1803 1809 1906 +hsync -vsync`
