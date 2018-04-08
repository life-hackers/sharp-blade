infile="image.png"
inname=`convert -ping $infile -format "%t" info:`
OLDIFS=$IFS
IFS=$'\n'
arr=(`convert $infile -blur 0x5 -auto-level -threshold 99% -type bilevel +write tmp.png \
-define connected-components:verbose=true \
-connected-components 8 \
null: | tail -n +2 | sed 's/^[ ]*//'`)
num=${#arr[*]}
IFS=$OLDIFS

for ((i=0; i<num; i++)); do
  #echo "${arr[$i]}"
  color=`echo ${arr[$i]} | cut -d\  -f5`
  bbox=`echo ${arr[$i]} | cut -d\  -f2`
  echo "color=$color; bbox=$bbox"
  
  if [ "$color" = "gray(0)" ]; then
    convert $infile -crop $bbox +repage -fuzz 10% -trim +repage ${inname}_$i.png
  fi
done

