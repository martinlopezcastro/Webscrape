#!/bin/bash

Black="\e[1;90m"
Red="\e[1;91m"
Green="\e[1;92m"
Yellow="\e[1;93m"
Blue="\e[1;94m"
Purple="\e[1;95m"
Scraping
White="\e[1;97m"
clear
banner () {
echo -e "
${Blue}   
		${Blue}██╗  ██╗${Green}██╗${Red}██████╗ ██████╗ ███████╗${Yellow}███╗   ██╗    
		${Blue}██║  ██║${Green}██║${Red}██╔══██╗██╔══██╗██╔════╝${Yellow}████╗  ██║    
		${Blue}███████║${Green}██║${Red}██║  ██║██║  ██║█████╗  ${Yellow}██╔██╗ ██║    
		${Blue}██╔══██║${Green}██║${Red}██║  ██║██║  ██║██╔══╝  ${Yellow}██║╚██╗██║    
		${Blue}██║  ██║${Green}██║${Red}██████╔╝██████╔╝███████╗${Yellow}██║ ╚████║    
		${Blue}╚═╝  ╚═╝${Green}╚═╝${Red}╚═════╝ ╚═════╝ ╚══════╝${Yellow}╚═╝  ╚═══╝                                                                "
printf "\n\e[1;77m obtener correos electrónicos y números de teléfono de sitios web\e[0m\n\n"
echo -e "\e[0;96m                Creador: ${Red}Martin Lopez\n\n\n"                      
#echo -e "\e[0;96m                     Version: ${Red}1.0 Stable\n\n\n"                  
}
scanner () {
sleep 0.5
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Ingresa la url a escanear : \e[1;97m' url
url_validity='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
if [[ $url =~ $url_validity ]]
then 
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Extraer correos electrónicos del sitio web (s/n) : \e[1;97m' email
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Extraer números de teléfono del sitio web (s/n) : \e[1;97m' phone
if [ "$email" = "s" ] || [ "$email" = "s" ] || [ "$phone" = "s" ] || [ "$phone" = "s" ]; then
echo -e "$White[${Red}!$White] ${Red}El Scraping comenzo"
scraper
fi
sleep 0.4
echo -e "$White[${Red}!$White] ${Red}Saliendo....\n"
exit
else
echo -e "$White[$Red!$White] ${Red}Revisa tu url (inválida)"
scanner
fi
}
scraper () {
curl -s $url > temp.txt
if [ "$email" = "s" ] || [ "$email" = "s" ]; then
email_scraping
fi
if [ "$phone" = "s" ] || [ "$phone" = "s" ]; then
phone_scraping
fi
rm temp.txt
if [[ -f "email.txt" ]] || [[ -f "phone.txt" ]] ; then
sleep 0.4
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m ¿Quieres guardar los datos encontrados? (s/n) : \e[1;97m' save_output
if [ "$save_output" = "s" ] || [ "$save_output" = "s" ]; then
output
fi
fi
sleep 0.4
echo -e "$White[${Red}!$White] ${Red}Saliendo....\n"
rm email.txt phone.txt 2> /dev/null 
exit
}
email_scraping () {
grep -i -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' temp.txt | sort -u > email.txt
if [[ -s email.txt ]]; then
echo -e "$White[${Yellow}*$White] ${Yellow}Éxito en los correos electrónicos${White}"
cat email.txt
else 
echo -e "$White[${Red}!$White] ${Red}Emails no encontrado"
rm email.txt
fi
}
phone_scraping () {
grep -o '\([0-9]\{3\}\-[0-9]\{3\}\-[0-9]\{4\}\)\|\(([0-9]\{3\})[0-9]\{3\}\-[0-9]\{4\}\)\|\([0-9]\{10\}\)\|\([0-9]\{3\}\s[0-9]\{3\}\s[0-9]\{4\}\)' temp.txt | sort -u > phone.txt
if [[ -s phone.txt ]]; then
echo -e "$White[${Yellow}*$White] ${Yellow}Éxito con los números de teléfono${White}"
cat phone.txt
else 
echo -e "$White[${Red}!$White] ${Red}Numeros de teléfono no encontrado"
rm phone.txt
fi
}
output () {
sleep 0.4
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Ingrese el nombre de la carpeta : \e[1;97m' folder_name
if [ -d "$folder_name" ] 
then
echo -e "$White[${Red}!$White] ${Red}La carpeta ya existe"
output
fi
mkdir $folder_name
mv email.txt $folder_name 2> /dev/null
mv phone.txt $folder_name 2> /dev/null
sleep 0.3
echo -e "$White[${Green}*$White] ${Yellow}Guardado correctamente"
sleep 0.4
echo -e "$White[${Red}!$White] ${Red}Saliendo....\n"
exit
}
internet () {
sleep 0.5
echo -e "$White[$Red!$White] ${Red}Analizando si estas conectado a internet"
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
echo -e "$White[$Yellow*$White] ${Yellow}Conectado"
else
sleep 0.5
echo -e "$White[$Red!$White] ${Red}No tienes internet"
exit 
fi
}
banner
internet
scanner
