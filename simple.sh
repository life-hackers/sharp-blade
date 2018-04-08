#!/bin/bash

# ideas from:
# https://www.imagemagick.org/script/connected-components.php
# https://stackoverflow.com/a/48558406/3672225

input=${1:-image.png}
in_dir=$(dirname "${input}")
out_dir=$in_dir/cropped
out_fn=`convert -ping "$input" -format "%t" info:`

if [ -z "$out_fn" ]; then
    exit 1
fi

list=`convert "$input" \
    -colorspace gray -negate -threshold 15%          \
		-morphology Erode:1 Octagon \
		-morphology Close Disk   \
    -define connected-components:verbose=true        \
    -define connected-components:area-threshold=200  \
    -connected-components 8 null:`

# split array https://stackoverflow.com/a/10586169/3672225
Old_IFS=$IFS
IFS=$'\n'

mkdir $out_dir
inx=0
for item in $list; do
	# trim https://stackoverflow.com/a/12973694/3672225
  item=`echo $item | xargs`
	# get vars
  bbox=`echo ${item} | cut -d\  -f2`
  color=`echo ${item} | cut -d\  -f5`
  # echo "color=$color; bbox=$bbox"
  
  if [ "$color" == "srgb(255,255,255)" ]; then
		fn=$out_dir/${out_fn}_${inx}.png
		echo cropping to $fn
    convert $input -crop $bbox +repage \
					-trim +repage $fn
		inx=$((inx + 1))
  fi
done

IFS=$Old_IFS

