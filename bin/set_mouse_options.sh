SEARCH="Logitech Gaming Mouse G502"

if [ "$SEARCH" = "" ]; then
    exit 1
fi

ids=$(xinput --list | awk -v search="$SEARCH" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )

# Mouse Speed prop name has been changed.
# https://askubuntu.com/questions/905424/upgraded-16-04-to-17-04-now-unable-to-change-mouse-speed
for i in $ids
do
	xinput set-prop $i 'libinput Accel Speed' 0
	xinput set-prop $i 'libinput Accel Profile Enabled' 0, 1
done

# Set Mouse sensitivity
xset m 1/3 0
