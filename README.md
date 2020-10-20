<img alt="GitHub" src="https://img.shields.io/badge/version-v1.0-blue"> <img alt="GitHub" src="https://img.shields.io/github/license/anthares101/kali_volatility_installer">

# Kali Volatility installer

If you researched a bit, the Volatility releases are not up to date and if you want to have an updated version you need to get Volatility from its GitHub 
[repository](https://github.com/volatilityfoundation/volatility). If you dont use Kali Linux you can get Volatility from `apt`, even though, it is not the last version and i recommend getting Volatility from the GitHub repository (Should be easy if you can install or use pip for Python 2 unlike Kali).

## Disclaimer

I tested this script in Kali Linux only, it should work in all Linux distributions with Bash but you know, it is not tested ^^. Also, this script will append this line: `PATH="$HOME/volatility:$PATH"` to your `.bashrc` in order to add Volatility to your path so if you dont use Bash as your main shell you will need to add that line to the correct file (For example, if you use `zsh` add the line to your `.zshrc` file).

# The problem for Kali Users

If you use Kali Linux, you may have noticed that python 2 support is... not good in Kali last updates, pip for Python 2 is not even installed and you cant add it from Kali repositories. Volatility is affected by this because right now, it only works with Python 2 (I know they are working in a Python 3 version but is not done yet) and you need to  install some dependencies with pip, which is not available, so can be a bit tricky getting the last Volatility version to work properly.

# Solution

Well, i wrote a little script that will install the last volatility version available and all the dependecies needed to run it. The script will install pip too using the `get-pip.py` file, you can find more information about it [here](https://pip.pypa.io/en/stable/installing/).

The installer will also add Volatility to your path as `volatility2` (You will need to reopen the terminal for this changes to take effect) and if you need to update Volatility just rerun this installer (Wont duplicate anything dont worry about that).
