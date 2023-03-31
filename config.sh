#./bin/bash
# Usage: sudo bash ./config.sh
#
# Если нет доступа ->
# sudo chmod u+x config.sh

RED='\033[0;31m' 
Green='\033[0;32m'
NC='\033[0m'

INCLUDE_DOCKER=0

echo -e 'Auto software install script.'
echo -e 'Include Docker?'

read -r -n1 -p "(y/n) >>" dockerChoice
    case $dockerChoice in
    [yY]*)
        echo -e "${Green}\nDocker will be included in installation.${NC}"
        INCLUDE_DOCKER=1
        ;;
    [nN]*)
        echo -e "${Green}\nDocker will ${RED}NOT${Green} be included in installation.${NC}"
        ;;
    *)
        echo -e "${RED}\nPlease select a proper option...${NC}"
        exit
        ;;
    esac

cd ~
sudo apt update

sudo apt -y install git #git
echo -e "${Green}\nGit is installed successfully.${NC}"
sudo apt -y install curl #for nvm
echo -e "${Green}\nCurl is installed successfully.${NC}"
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash #nvm

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm

source ~/.bashrc
echo -e "${Green}\nNVM is installed successfully.${NC}"
nvm install node #node
echo -e "${Green}\nNode is installed successfully.${NC}"

snap install slack --classic #slack
echo -e "${Green}\nSlack is installed successfully.${NC}"

sudo snap install code --classic #vscode
echo -e "${Green}\nVSCode is installed successfully.${NC}"

sudo snap install postman #postman
echo -e "${Green}\nPostman is installed successfully.${NC}"

mkdir tempDir
cd tempDir

sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo rm /var/lib/dpkg/lock-frontend
sudo dpkg --configure -a

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb #chrome
sudo dpkg -i google-chrome-stable_current_amd64.deb
cd ..
rm -rf ./tempDir
echo -e "${Green}\nGoogle Chrome is installed successfully.${NC}"


if [ $INCLUDE_DOCKER == 1 ] 
then
   curl https://get.docker.com/ | sudo sh #docker
   source ~/.bashrc
fi

