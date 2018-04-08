#!/bin/bash

# debugger

input=${1:-image.png}
in_dir=$(dirname "${input}")
out_dir=$in_dir/cropped
out_fn=`convert -ping "$input" -format "%t" info:`

# https://stackoverflow.com/a/28429090/3672225
#
# convert img.png -fill none -stroke red \
#   -draw "rectangle 0,1543 822,2767"        \
#   -draw "rectangle 0,155 800,1370"         \
#   -draw "rectangle 1169,836 871,1893"       \
#   -draw "rectangle 1164,818 876,6"       \
#   -draw "rectangle 1163,819 877,956"       \
#   x.png

list=`convert "$input" \
    -colorspace gray -negate -threshold 15%          \
		-morphology Erode:1 Octagon \
		-morphology Close Disk   \
    -define connected-components:verbose=true        \
    -define connected-components:area-threshold=100  \
    -connected-components 8 null:`
		# debug.png`

echo "$list"

