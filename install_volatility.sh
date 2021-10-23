#! /bin/bash

# Status
STATUS=0

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m" # No Color

function printCommandResult {
	if [ $? -eq 0 ]; then
    	echo -e "[${GREEN}DONE${NC}]"
    	return 0
	else
		echo -e "[${RED}ERROR${NC}]"
		STATUS=-1
		return -1
	fi
}

function exitOnError {
	if [ $? -ne 0 ]; then
    	echo -e "\n${RED}Process aborted${NC}"
    	exit -1
    fi
}

# Elevate privileges
if [[ $UID -ne 0 ]]; then
   echo -e "\n${YELLOW}This script must be run as root${NC}"
   exec sudo ORIGINAL_USER=$UID "$0" "$@"
fi

# Remove volatility dir if necessary
INSTALLATION_DIR="/opt/vol"
echo -ne "Removing previous volatility installations...\t"
if [ -d $INSTALLATION_DIR ]; then rm -Rf $INSTALLATION_DIR; fi
printCommandResult
exitOnError

# Install packages
echo -ne "Installing packages...\t\t\t\t"
apt install -y python2 python-dev git build-essential python3-virtualenv &> /dev/null
printCommandResult
exitOnError

# Clone volatility
echo -ne "Cloning volatility...\t\t\t\t"
git clone "https://github.com/volatilityfoundation/volatility.git" $INSTALLATION_DIR &> /dev/null
printCommandResult
exitOnError

# Create virtual environment
echo -ne "Preparing Python environment...\t\t\t"
virtualenv -p python2 ${INSTALLATION_DIR}/venv &> /dev/null
printCommandResult
exitOnError

# Install dependencies
echo -ne "Installing dependencies...\t\t\t"
${INSTALLATION_DIR}/venv/bin/pip install distorm3==3.4.4 yara-python pycrypto pillow openpyxl ujson &> /dev/null
printCommandResult

# Add alias to path
ALIAS_STR="alias volatility='${INSTALLATION_DIR}/venv/bin/python /opt/vol/vol.py'"
USER_HOME_PATH="/home/$(id -un $ORIGINAL_USER)"
echo -ne "Adding alias for volatility to path...\t\t"
sed -i '/alias volatility.*/d' $USER_HOME_PATH/.bashrc
echo $ALIAS_STR >> $USER_HOME_PATH/.bashrc
if [ -f "${USER_HOME_PATH}/.zshrc" ]; then
	sed -i '/alias volatility.*/d' $USER_HOME_PATH/.zshrc
	echo $ALIAS_STR >> $USER_HOME_PATH/.zshrc
fi
printCommandResult

if [ $STATUS -eq 0 ]; then
	echo -e "\n${GREEN}All done! Enjoy the last volatility version! (Maybe you need to restart the shell)${NC}"
else
	echo -e "\n${YELLOW}All done! Some errors during installation, maybe volatility dont work as expected${NC}"
fi