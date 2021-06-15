#!/bin/bash -xe

export DISPLAY=:0


# Split a string from the second parameter till string end
split_string() {
	local i=0
	local string=''

	for eachline in $1
		do
			if [ $i -gt $2 ]
				then
					string=$string" "$eachline
			fi
		i=$((i + 1))
	done

	echo $string
}

# Set Width and Height
w=${1-1920}
h=${2-1920}
res=${3-1}

w=$(($w*$res))
h=$(($h*$res))

# The max width and height are defined based no the resolution added to Xvfb on startup in run.sh
maxw=1920
maxh=1920
minw=480
minh=480

if [ $w -gt $h ]
	then
		aspect=$(echo "$w/$h" | bc -l)

		if [ $w -gt $maxw ]
			then
				w=$maxw
				h=$(echo "$maxw/$aspect" | bc)
		elif [ $w -lt $minw ]
			then
				w=$minw
				h=$(echo "$minw/$aspect" | bc)
		fi

		if [ $h -gt $maxh ]
			then
				h=$maxh
				w=$(echo "$maxh*$aspect" | bc)
		elif [ $h -lt $minh ]
			then
				h=$minh
				w=$(echo "$minh*$aspect" | bc)
		fi
else	
		aspect=$(echo "$h/$w" | bc -l)

		if [ $h -gt $maxh ]
			then
				h=$maxh
				w=$(echo "$maxh/$aspect" | bc)
		elif [ $h -lt $minh ]
			then
				h=$minh
				w=$(echo "$minh/$aspect" | bc)
		fi

		if [ $w -gt $maxw ]
			then
				w=$maxw
				h=$(echo "$maxw*$aspect" | bc)
		elif [ $w -lt $minw ]
			then
				w=$minw
				h=$(echo "$minw*$aspect" | bc)
		fi
fi

# Get the needed resolution info
CVT=$(cvt $w $h)
resolution=$(echo $CVT | cut -d "\"" -f 2)
rest=$(echo $CVT | cut -d "\"" -f 3)

export DISPLAY=:0

# Create, add and apply the new mode resolution
xrandr --newmode $resolution $rest || true
xrandr --addmode screen $resolution || true 
xrandr --output screen --mode $resolution || true