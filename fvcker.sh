#!/bin/sh

clear

printf "\e[1;32m \n\n"

printf "Instalando requisitos..."
printf "Requisitando permissões..."

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
echo "Olá $USER, Bem vindo(a) ao FVCKER."
echo "Ferramenta desenvolvida para agilizar pentest em larga escala."
echo "Não somos responsáveis por mal uso, ou danos alheios causados pela ferramenta."
printf "\e[1;31m"
 
printf "\nDigite Nome do Alvo: (Exemplo: google): "

printf "\e[1;0m"
read -r nomedoalvo
printf "\e[1;31m"

printf "\nDigite URL: (Exemplo: google.com): "
printf "\e[1;0m"
read -r url;
printf "\e[1;31m"

echo $sep
echo $sep

mkdir "$nomedoalvo"
cd "$nomedoalvo" || exit

clear
echo $clr

printf "Procurando subdominios..."
subfinder -d "$url" -o subfinder.txt
assetfinder --subs-only "$url" | tee -a assetfinder.txt

clear

# Junta os resultados.
sort -u subfinder.txt subfinder.txt > domains.txt

printf "Filtrando dominios vivos..."
httpx-toolkit -l domains.txt -o alive.txt

clear

printf "Buscando endpoints..."
katana -list alive.txt > endpoints.txt

clear

printf "Procurando subdominios vulneráveis..."
subzy run --targets alive.txt --hide_fails > subzy.txt

clear

printf "Finalizado!"
clear

printf "Ver subdominios? (s/n)"
read -r showSubzy;

clear

printf "Ver endpoints? (s/n)"
read -r showEndpoints;

clear

if [ "$showSubzy" = "s" ]; then
    cat subzy.txt
fi

if [ "$showEndpoints" = "s" ]; then
    cat endpoints.txt
fi