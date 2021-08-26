#!/bin/dash
# Autoscroll on middle mouse button hold.

autoscrolldelay=0.2 # Period in seconds during which the middle mouse button must be held down before the click event is terminated and autoscroll is activated. If it is released before then, a normal click event is fired.
disableclickpaste=1 # Disables the default Linux behavior of copying and pasting the current selection in the case of a normal middle mouse button click event.
enableverticalscroll=1
enablehorizontalscroll=1

middlemousebutton=2
mousescrollup=4
mousescrolldown=5
mousescrollleft=6
mousescrollright=7

eval $(xdotool getmouselocation --shell)
starty=$Y
startx=$X
toggle=$middlemousebutton
firstiteration=1

while [ "$toggle" = "$middlemousebutton" ]
do
    eval $(xdotool getmouselocation --shell)
    curry=$Y
    currx=$X
    
    if [ $enableverticalscroll -eq 1 ]
    then
        if [ $curry -gt $starty ]
        then
            speedy=$(expr $curry / 100 - $starty / 100)
            if [ $speedy -gt 0 ]
            then
                xdotool click --repeat $speedy --delay 1 $mousescrolldown
            fi
        else
            speedy=$(expr $curry / 100  - $starty / 100  | sed 's:-::')
            if [ $speedy -gt 0 ]
            then
                xdotool click --repeat $speedy --delay 1 $mousescrollup
            fi
        fi
    fi

    if [ $enablehorizontalscroll -eq 1 ]
    then
        if [ $currx -gt $startx ]
        then
            speedx=$(expr $currx / 100 - $startx / 100)
            if [ $speedx -gt 0 ]
            then
                xdotool click --repeat $speedx --delay 1 $mousescrollright
            fi
        else
            speedx=$(expr $currx / 100  - $startx / 100  | sed 's:-::')
            if [ $speedx -gt 0 ]
            then
                xdotool click --repeat $speedx --delay 1 $mousescrollleft
            fi
        fi
    fi

    if [ $firstiteration = 1 ]
    then
        firstiteration=0
        sleep $autoscrolldelay
        if [ "$(xinput --list "Virtual core pointer" | grep -i -m 1 "Button state:" | grep -o "[$middlemousebutton]\+")" != "$middlemousebutton" ]
        then # Fire normal middle mouse button click event.
            if [ $disableclickpaste -eq 1 ]
            then # Disable copying and pasting of current selection.
                echo -n | xsel -n -i
            fi
            xdotool click $middlemousebutton
            exit
        fi
    fi

    toggle=$(xinput --list "Virtual core pointer" | grep -i -m 1 "Button state:" | grep -o "[$middlemousebutton]\+")
    sleep 0.02
done
