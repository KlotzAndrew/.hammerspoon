#!/usr/bin/env bash

# Inspired by: https://github.com/meskarune/i3lock-fancy

set -e

tmp_image=/tmp/lock.png
color_value="60"

screencapture -m -x "$tmp_image"

color=$(/usr/local/bin/convert "$tmp_image" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
  -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');

if [[ $color -gt $color_value ]]; then # white background image and black text
  bw="black"
  icon="./circlelockdark.png"
else #black
  bw="white"
  icon="./circlelock.png"
fi

text="Type password to unlock"
hue=(-level "0%,100%,0.6")
effect=(-filter Gaussian -resize 10% -define "filter:sigma=1.5" -resize 1000%)
font=$(convert -list font | awk "{ a[NR] = \$2 } /family: $(fc-match sans -f "%{family}\n")/ { print a[NR-1]; exit }")

/usr/local/bin/convert "$tmp_image" "${hue[@]}" "${effect[@]}" -font "$font" -pointsize 26 -fill "$bw" -gravity center \
  -pointsize 36 -annotate +0+250 "$text" "$icon" -gravity center -composite  ~/screensaver/lock.png # "$image"

# /usr/local/bin/convert -scale 10% -blur 0x2.5 -resize 1000% "$image" \
#   -gravity center ~/.hammerspoon/lock-icon.png -composite ~/screensaver/lock.png
