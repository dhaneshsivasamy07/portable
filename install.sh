#!/bin/bash

# run: bash workspace.sh
# replace: /home/$USER/Desktop/
# with: /home/$USER/Desktop/

# directories
mkdir -p /home/$USER/Desktop/tools/{web,mobile,lang,reverse}
mkdir /home/$USER/.local/bin/

# update and upgrade
sudo apt-get update -y && sudo apt-get upgrade -y

# install apt tools
sudo apt-get install -y fzf xclip tmux curl git seclists docker.io python3-pip python3.11-venv openjdk-17-jdk-headless openjdk-17-jre-headless openjdk-11-jdk-headless openjdk-11-jre-headless jq

# Nahamsec find everydomain of a company
# curl -s https://crt.sh/\?o\=org\&output\=json | tee org.txt
# cat org.txt | jq -r '.[].common_name' | sed 's/\*//g' | sort -u 

# tools
##################################################################### lang
## go
echo "Please provide me with the latest go url:- "
# https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
read gourl
wget -O /tmp/go.tar.gz $gourl
tar -C ~/.local/bin/ -xzf /tmp/go.tar.gz

##################################################################### web tools
## nuclei
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

## assetfinder
# assetfinder --subs-only domain.com | tee assetfinder_domains.txt
go install -v github.com/tomnomnom/assetfinder

## subfinder
# subdinfer -d domain.txt -o subfinder_domain.txt
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# waybackurls
# cat domains.txt | waybackurls > urls
go install -v github.com/tomnomnom/waybackurls@latest


## httpx
# cat domains_reconned.txt | httpx -status-code -title -tech-detect
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# gf
git clone https://github.com/tomnomnom/gf.git /home/$USER/Desktop/tools/web/gf/
cd /home/$USER/Desktop/tools/web/gf/
go build
echo 'source /home/$USER/Desktop/tools/web/gf/gf-completion.bash' >> ~/.zshrc
## submodule
mkdir /home/$USER/.gf
git clone https://github.com/1ndianl33t/Gf-Patterns /tmp/gf-temp/
mv /tmp/gf-temp/*.json ~/.gf

## wordlists
mkdir /home/$USER/Desktop/tools/web/wordlists/
git clone https://github.com/trickest/wordlists /home/$USER/Desktop/tools/web/wordlists/tricktest_wdlist

## zdns + sugben
#### Better Usage
# cat ~/Desktop/tools/web/zdns/subdomains.txt | subgen -d "domain.com" | /home/$USER/Desktop/tools/web/zdns/zdns A | tee a_data.txt
# cat a_data.txt | jq -r "select(.data.answers[0].name) | .name" | sort -u | tee subgen_zdns_domain.txt 
git clone https://github.com/zmap/zdns.git /home/$USER/Desktop/tools/web/zdns
cd /home/$USER/Desktop/tools/web/zdns/
go build
go install -v github.com/pry0cc/subgen

## massdns
sudo apt install massdns

## shuffledns
go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest

## trufflehog
docker pull trufflesecurity/trufflehog
mkdir /home/$USER/Desktop/tools/web/trufflehog
# docker run --rm -it -v "/tmp:/tmp" -v "$PWD:/pwd" trufflesecurity/trufflehog github --only-verified --org=
echo "docker run --rm -it -v '/tmp:/tmp' -v '$PWD:/pwd' trufflesecurity/trufflehog github --only-verified --org=org" > /home/$USER/Desktop/tools/web/trufflehog/README.md

##################################################################### mobile tools
## adb
wget -O /tmp/pt.zip https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip -d /home/$USER/Desktop/tools/mobile/ /tmp/pt.zip

## jadx 
sudo apt-get install -y jadx jd-gui

## apktool
sudo apt-get install -y apktool

mkdir /home/$USER/Desktop/tools/mobile/venv
## frida
python3 -m venv /home/$USER/Desktop/tools/mobile/venv/frida_venv/
source /home/$USER/Desktop/tools/mobile/venv/frida_venv/bin/activate
pip install frida-tools
frida --version
deactivate

## objection
python3 -m venv /home/$USER/Desktop/tools/mobile/venv/objection_venv/
source /home/$USER/Desktop/tools/mobile/venv/objection_venv/bin/activate
pip install objection
deactivate

## drozer
docker pull withsecurelabs/drozer
mkdir /home/$USER/Desktop/tools/mobile/drozer/
echo "docker run --net host -it withsecurelabs/drozer console connect --server <phone IP address>" > /home/$USER/Desktop/tools/mobile/drozer/README.md

## mobsf
docker pull opensecurity/mobile-security-framework-mobsf:latest
mkdir /home/$USER/Desktop/tools/mobile/mobsf/
echo "docker run -it --rm -p 8000:8000 opensecurity/mobile-security-framework-mobsf:latest" > /home/$USER/Desktop/tools/mobile/mobsf/README.md


##################################################################### reverse
## radamsa
git clone https://gitlab.com/akihe/radamsa.git /home/$USER/Desktop/tools/reverse/radamsa && cd /home/$USER/Desktop/tools/reverse/radamsa && make && sudo make install

## fuzzers
mkdir /home/$USER/Desktop/tools/reverse/fuzzers/
echo "https://github.com/zjuchenyuan/dockerized_fuzzing" > /home/$USER/Desktop/tools/reverse/fuzzers/README.md

## zzuf
# wget -O /tmp/zzuf/ https://github.com/samhocevar/zzuf/releases/download/v0.15/zzuf-0.15.tar.gz 
# cd /tmp/zzuf/
# ./configure
# make
sudo apt-get install zzuf 

## ghidra
echo "Please provide me with the latest ghidra url:- "
# https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.4_build/ghidra_10.4_PUBLIC_20230928.zip
read ghidraurl
wget -O /tmp/ghidra.zip $ghidraurl
unzip -d /home/$USER/Desktop/tools/reverse/ /tmp/ghidra.zip

## 

# PATH
export PATH=$PATH:/home/$USER/Desktop/tools/mobile/platform-tools/:/home/$USER/.local/bin/go/bin:/home/$USER/go/bin/:/home/$USER/Desktop/tools/web/zdns/:/home/$USER/Desktop/tools/web/gf/
