#!/bin/sh

clear

printf "\e[1;32m \n\n"

printf "Installing resources..."
printf "Requesting permission..."

printf "\n"

sudo apt install httpx-toolkit
sudo apt install subfinder
sudo apt install assetfinder

go install -v github.com/PentestPad/subzy@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest

sudo cp ~/go/bin/katana/bin/
sudo cp ~/go/bin/subzy/bin/

clear

sep="#===#===#===#===#===#===#===#===#===#===#===#===#===#===#===#===#===#===#===#===#"
clr="\n"

printf "\e[1;31m


      █████▒██▒   █▓ ▄████▄   ██ ▄█▀▓█████  ██▀███  
    ▓██   ▒▓██░   █▒▒██▀ ▀█   ██▄█▒ ▓█   ▀ ▓██ ▒ ██▒
    ▒████ ░ ▓██  █▒░▒▓█    ▄ ▓███▄░ ▒███   ▓██ ░▄█ ▒
    ░▓█▒  ░  ▒██ █░░▒▓▓▄ ▄██▒▓██ █▄ ▒▓█  ▄ ▒██▀▀█▄  
    ░▒█░      ▒▀█░  ▒ ▓███▀ ░▒██▒ █▄░▒████▒░██▓ ▒██▒
     ▒ ░      ░ ▐░  ░ ░▒ ▒  ░▒ ▒▒ ▓▒░░ ▒░ ░░ ▒▓ ░▒▓░
     ░        ░ ░░    ░  ▒   ░ ░▒ ▒░ ░ ░  ░  ░▒ ░ ▒░
     ░ ░        ░░  ░        ░ ░░ ░    ░     ░░   ░ 
                 ░  ░ ░      ░  ░      ░  ░   ░         v1.0.0
                ░   ░                               
"

echo $sep
echo $sep

printf "\n\e[1;0m"
echo "Hello $USER, Welcome to FVCKER."
echo "Tool developed to speed up large-scale pentests."
echo "We are not responsible for misuse or damage caused by the tool."
printf "\e[1;31m"
 
printf "\nTarget Name: (example: google): "

printf "\e[1;0m"
read -r nomedoalvo
printf "\e[1;31m"

printf "\nTarget URL: (example: google.com): "
printf "\e[1;0m"
read -r url;
printf "\e[1;31m"

echo $sep
echo $sep

mkdir "$nomedoalvo"
cd "$nomedoalvo" || exit

clear
echo $clr

printf "Finding Subdomains..."
subfinder -d "$url" -o subfinder.txt
assetfinder --subs-only "$url" | tee -a assetfinder.txt

clear

# Junta os resultados.
sort -u subfinder.txt subfinder.txt > domains.txt

printf "Filtering alive domains..."
httpx-toolkit -l domains.txt -o alive.txt

clear

printf "Looking for endpoints..."
katana -list alive.txt > endpoints.txt

clear

printf "Finding vulnerable subdomains..."
subzy run --targets alive.txt --hide_fails > subzy.txt

clear

printf "Finished!"
clear

printf "Do you want to see the subdomains? (y/n)"
read -r showSubzy;

clear

printf "Do you want to see the endpoints? (s/n)"
read -r showEndpoints;

clear

if [ "$showSubzy" = "y" ]; then
    cat subzy.txt
fi

if [ "$showEndpoints" = "y" ]; then
    cat endpoints.txt
fi