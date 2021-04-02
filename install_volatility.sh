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

# Remove volatility dir if necesary
echo -ne "Removing previous volatility installations...\t"
if [ -d "${HOME}/volatility" ]; then rm -Rf "${HOME}/volatility"; fi
printCommandResult
exitOnError

# Clone volatility
echo -ne "Clone volatility to your home folder...\t\t"
git clone "https://github.com/volatilityfoundation/volatility.git" "${HOME}/volatility" &> /dev/null
printCommandResult
exitOnError

# Install dependencies
echo -ne "Installing dependencies...\t\t\t"
python2 -m pip install distorm3==3.4.4 yara-python pycrypto pillow openpyxl ujson &> /dev/null
printCommandResult

# Create bash script for execution using path
echo -ne "Create bash script for execution...\t\t"
echo -e "#! /bin/bash\n\npython2 $HOME/volatility/vol.py \"\$@\"" > "${HOME}/volatility/volatility2"
chmod u+x "${HOME}/volatility/volatility2" &> /dev/null
printCommandResult

# Add to path
echo -ne "Add volatility to path...\t\t\t"
echo $PATH | grep -q  "$HOME/volatility"
if [ $? -ne 0 ]; then
	echo "PATH=\"\$HOME/volatility:\$PATH\"" >> "${HOME}/.bashrc"
	if [ -f "${HOME}/.zshrc" ]; then
		echo "PATH=\"\$HOME/volatility:\$PATH\"" >> "${HOME}/.zshrc"
	fi
fi
printCommandResult

if [ $STATUS -eq 0 ]; then
	echo -e "\n${GREEN}All done! Enjoy the last volatility version!${NC}"
else
	echo -e "\n${YELLOW}All done! Some errors during installation, maybe volatility dont work as expected${NC}"
fi
