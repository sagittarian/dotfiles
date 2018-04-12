# monitor setting aliases, most of them very old
# alias sethdmi="xrandr --output HDMI1 --auto --left-of LVDS1"
# alias setvga='xrandr --output VGA1 --auto --right-of LVDS1'
# alias setdp='xrandr --output DP1 --mode 1920x1080 --above eDP1'
# alias setdp='xrandr --output DP1 --mode 1152x864 --left-of eDP1'
# alias setdp='xrandr --output DP1 --mode 1280x1024 --above eDP1'
# alias hdmioff="xrandr --output HDMI1 --off"
# alias vgaoff='xrandr --output VGA1 --off'
# alias dpoff='xrandr --output DP1 --off'
# alias dualmonoff='xrandr --output DP1 --off --output DP2 --off'
# alias dualmon='xrandr --output DP2 --auto --right-of eDP1 --output DP1 --auto --right-of DP2'
# alias mon2='xrandr --output DP1-1 --auto --left-of eDP1'
# alias mon2off='xrandr --output DP1-1 --off'
# alias mon3='xrandr --output DP1-3 --auto --left-of eDP1 --output DP1-1 --auto --left-of DP1-3'
alias mon3x='xrandr --output VIRTUAL1 --off \
  --output eDP1 --mode 1366x768 --pos 3840x752 --rotate normal \
  --output DP1 --off --output HDMI2 --off --output HDMI1 --off \
  --output DP1-1 --mode 1920x1080 --pos 0x0 --rotate normal \
  --output DP1-2 --off \
  --output DP1-3 --mode 1920x1080 --pos 1920x216 --rotate normal --crtc 2'
alias mon3='xrandr --output VIRTUAL1 --off \
  --output eDP1 --mode 1366x768 --pos 3840x808 --rotate normal \
  --output DP1 --off --output HDMI2 --off --output HDMI1 --off \
  --output DP1-3 --mode 1920x1080 --pos 0x240 --rotate normal --crtc 2 \
  --output DP1-1 --off --output DP1-1 --mode 1920x1080 --pos 1920x0 --rotate normal'
alias mon3off='xrandr --output DP1-1 --off --output DP1-3 --off'

function xinput_set_prop () {
    deviceid=$(xinput list | grep -i $1 | ruby -n -e '$_ =~ /id=(\d+)/; puts $+')
    xinput set-prop $deviceid "$2" "$3"
}

#alias setmouse="xinput set-button-map \$(xinput list | grep -i mouse | grep -vi generic | perl -n -e'/id=(\d+)/ && print \$1') 3 2 1"
function setmouse {
    devids=$(xinput list | grep -Ei 'slave\s+pointer' | grep -i microsoft | python -c 'import sys, re; print("\n".join(re.findall(r"id=(\d+)", sys.stdin.read())))')
    for devid in $devids; do
        xinput set-button-map $devid 3 2 1
    done
}
alias touchpad-enable="xinput_set_prop touchpad 'Device Enabled' 1 && xinput_set_prop trackpoint 'Device Enabled' 1"
alias touchpad-disable="xinput_set_prop touchpad 'Device Enabled' 0 && xinput_set_prop trackpoint 'Device Enabled' 1"

#alias setmon="xrandr --output HDMI1 --auto --left-of LVDS1"

alias cycleworkspace="i3-msg move workspace to output left"
alias cycw="i3-msg move workspace to output left"
#alias cw="i3-msg move workspace to output left"
function cw () {
    dir=${1:-left}
    i3-msg move workspace to output $dir
}
alias cwr='cw right'
alias cwl='cw left'
alias flipw='i3-msg move workspace to output up'

alias gco="git checkout"
alias gci="git commit"
alias gd="git diff"
alias gbr="git branch"
alias gvi="git bisect visualize"
alias gbi="git bisect"

function swapgood () {
	alias good='git bisect bad'
	alias bad='git bisect good'
}
function unswapgood () {
	alias good='git bisect good'
	alias bad='git bisect bad'
}
unswapgood
