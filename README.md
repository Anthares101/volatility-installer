<img alt="GitHub" src="https://img.shields.io/badge/version-v1.0-blue"> <img alt="GitHub" src="https://img.shields.io/github/license/anthares101/kali_volatility_installer">

# Kali Volatility installer

If you researched a bit, the Volatility releases are not up to date and if you want to have an updated version you need to get Volatility from its GitHub 
[repository](https://github.com/volatilityfoundation/volatility). If you dont use Kali Linux you can get Volatility even from `apt` so you dont really need this.

# The problem for Kali Users

If you use Kali Linux, you may have noticed that python 2 support is... not good in Kali last updates, pip for Python 2 is not even installed and you cant add it from Kali 
repositories. Volatility is affected by this because right now, it only works with Python 2 (I know they are working in Python 3 version but is not done yet) and you need to 
install some dependencies.

As i said before, pip for Python 2 is not available in Kali and getting the last volatility version to work can be a bit tricky.

# Solution

Well, i wrote a little script that will install the last volatility version available and all the dependecies needed to run it. The script will install pip too using the 
`get-pip.py` file, thanks to this [post](https://forums.kali.org/showthread.php?48570-New-Kali-build-cannot-install-pip-for-python2-7) from the Kali forums for it.

The installer will also add Volatility to your path as `volatility2.6` (You will need to reopen the terminal for this changes to take effect) and if you need to update 
Volatility just rerun the this installer (Wont duplicate anything dont worry about that).

# Disclaimer

I tested this script in Kali Linux only, it should work in all linux distributions with bash but you know, is not tested ^^. Also, this script will append this line:
`PATH="$HOME/volatility:$PATH"` to your `.bashrc` in order to add Volatility to your path so if you dont use Bash as your main shell you will need to add that line to the
correct file (For example, if you use `zsh` add the line to your `.zshrc` file).
