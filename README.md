# System-wide Autoscrolling on Linux

## About

This shell script makes automatic scrolling available system-wide on Linux systems.

The `xbindkeys` program is used to intercept the event of a middle mouse button click and to run the shell script instead.

If the middle mouse button is held down for a specified delay period, the script terminates the click event and activates automatic scrolling for as long as the button is held down. Otherwise, a normal click event is triggered if the button is released before the end of the delay time.

Optionally, the script also disables the Linux default behavior of copying and pasting the current selection when clicking the middle mouse button. Disabling this feature is useful to prevent accidental pasting.

## Setup

1. Install dependencies:

```
sudo apt install xdotool xsel xbindkeys
```

2. Copy paste the `.autoscroll.sh` and `.xbindkeysrc` files into your home directory.

3. Make the script executable:

```
chmod +x ~/.autoscroll.sh
```

4. The `xbindkeys` program will be started automatically at system startup. So the next time you log in, automatic scrolling should be available. You can also (re)start or stop it manually:

- (Re)start: `xbindkeys -p`
- Stop: `pkill xbindkeys`

Tested on Pop!\_OS 21.04

## Credits

Many thanks to [Azerothian and Cestarian](https://unix.stackexchange.com/questions/472398/can-i-make-middle-mouse-scrolling-on-linux-behave-more-like-autoscrolling-on-win) who wrote most of the script!

However, I had some problems with their proposed solution, which I fixed in my version:

- When using the `sxhkd` program instead of `xbindkeys`, the click event is not terminated but executed together with the autoscroll functionality. This easily triggers unwanted actions when you only want to use the autoscroll functionality. Therefore, in my opinion, it is better to distinguish between a short click event and a hold event to preserve the primary function of the middle mouse button as well as to provide the autoscroll functionality.
- The suggested way of disabling the middle mouse button pasting breaks copying with keyboard shortcuts for `terminal` and `gedit`. Also, it is not completely disabled, e.g. it is still available inside `terminal` and `gedit` but only once per selection. My opinion is that it is better to disable or enable this feature completely without affecting other copy and paste mechanisms.
