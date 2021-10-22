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
    fi
}

# Elevate privileges
if [[ $UID -ne 0 ]]; then
   echo -e "\n${YELLOW}This script must be run as root${NC}"
   exec sudo ORIGINAL_USER=$UID "$0" "$@"
fi

# Remove volatility dir if necesary
INSTALLATION_DIR="/opt/vol"
echo -ne "Removing previous volatility installations...\t"
if [ -d $INSTALLATION_DIR ]; then rm -Rf $INSTALLATION_DIR; fi
printCommandResult
exitOnError

# Install packages
echo -ne "Installing packages...\t\t\t\t"
apt install -y python2 git build-essential python3-virtualenv &> /dev/null
printCommandResult
exitOnError

# Clone volatility
echo -ne "Clone volatility to your home folder...\t\t"
git clone "https://github.com/volatilityfoundation/volatility.git" $INSTALLATION_DIR &> /dev/null
printCommandResult
exitOnError

echo -ne "Preparing Python environment...\t\t\t"
virtualenv -p python2 ${INSTALLATION_DIR}/venv &> /dev/null
printCommandResult
exitOnError

# Install dependencies
echo -ne "Installing dependencies...\t\t\t"
${INSTALLATION_DIR}/venv/bin/pip install distorm3==3.4.4 yara-python pycrypto pillow openpyxl ujson &> /dev/null
printCommandResult

# Add alias to path
ALIAS_STR="""alias volatility='${INSTALLATION_DIR}/venv/bin/python /opt/vol/vol.py'"""
USER_HOME_PATH="/home/$(id -un $ORIGINAL_USER)"
echo -ne "Add alias for volatility to path...\t\t"
# sed -i "/${ALIAS_STR}/d" $USER_HOME_PATH/.bashrc
echo $ALIAS_STR >> $USER_HOME_PATH/.bashrc
if [ -f "${HOME}/.zshrc" ]; then
	# sed -i "/${ALIAS_STR}/d" $USER_HOME_PATH/.zshrc
	echo $ALIAS_STR >> $USER_HOME_PATH/.zshrc
fi
printCommandResult

if [ $STATUS -eq 0 ]; then
	echo -e "\n${GREEN}All done! Enjoy the last volatility version! (Remember to restart the shell)${NC}"
else
	echo -e "\n${YELLOW}All done! Some errors during installation, maybe volatility dont work as expected${NC}"
fi
