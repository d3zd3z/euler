#! /bin/bash

i=1
while [[ $i < 999 ]]; do
	if [[ -f pr$i.hs ]]; then
		ii=$(printf "pr%03d.hs" $i)
		git mv pr$i.hs $ii
	fi

	i=$[ $i + 1 ]
done
