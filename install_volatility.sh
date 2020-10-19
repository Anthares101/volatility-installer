#! /bin/bash

# Colors
RED="\e[31m"
GREEN="\e[32m"
NC="\e[0m" # No Color

function printCommandResult {
	if [ $? -eq 0 ]; then
    	echo -e "[${GREEN}DONE${NC}]"
    	return 0
	else
		echo -e "[${RED}ERROR${NC}]"
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

# Install pip for python 2 if necessary
echo -ne "Installing pip for python 2...\t\t\t"
if [ -f "${HOME}/.local/bin/pip" ] || [ -f "/usr/lib/python2.7/dist-packages/pip" ] || [ -f "/usr/lib/python/dist-packages/pip" ]; then 
	echo -e "[${GREEN}DONE${NC}]"
else
	python get-pip.py &> /dev/null
	printCommandResult
	exitOnError
fi

# Install dependencies
echo -ne "Installing dependencies...\t\t\t"
pip install distorm3==3.4.4 yara-python pycrypto pillow openpyxl ujson &> /dev/null
printCommandResult

# Create bash script for execution using path
echo -ne "Create bash script for execution...\t\t"
echo -e "#! /bin/bash\n\npython $HOME/volatility/vol.py \"\$@\"" > "${HOME}/volatility/volatility2.6"
chmod u+x "${HOME}/volatility/volatility2.6" &> /dev/null
printCommandResult

# Add to path
echo -ne "Add volatility to path...\t\t\t"
echo $PATH | grep -q  "$HOME/volatility"
if [ $? -ne 0 ]; then
	echo "PATH=\"\$HOME/volatility:\$PATH\"" >> "${HOME}/.bashrc"
fi
printCommandResult

echo -e "\n${GREEN}All done! Enjoy the last volatility version!${NC}"
