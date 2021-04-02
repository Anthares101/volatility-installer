<img alt="GitHub" src="https://img.shields.io/badge/version-v1.2-blue"> <img alt="GitHub" src="https://img.shields.io/github/license/anthares101/kali_volatility_installer">

# Kali Volatility installer

If you researched a bit, the Volatility releases are not up to date and if you want to have an updated version you need to get Volatility from its GitHub 
[repository](https://github.com/volatilityfoundation/volatility). If you dont use Kali Linux you can get Volatility from `apt`, even though, it is not the last version and i recommend getting Volatility from the GitHub repository (Should be easy if you can install or use pip for Python 2 unlike Kali).

## Disclaimer

I tested this script in Kali Linux only, it should work in all Linux distributions with Bash but you know, it is not tested ^^. Also, this script will append this line: `PATH="$HOME/volatility:$PATH"` to your `.bashrc` and `.zshrc` in order to add Volatility to your path so if you dont use Bash or Zsh as your main shell you will need to add that line to the correct file.

# The problem for Kali Users

If you use Kali Linux, you may have noticed that you cant use `pip2` and if you use `pip` it will install the dependencies for Python 3. Volatility is affected by this because right now, it only works with Python 2 (I know they are working in a Python 3 version but is not done yet) and you need to  install some dependencies with pip, which is not available, so can be a bit tricky getting the last Volatility version to work properly.

## Prerequisites

- Install `python-dev` with `sudo apt install python-dev` before executing this installer
- Make sure you have `python2` installed in your system. You can install it with `sudo apt install python2`
- Install pip for python 2 in your system. If `sudo apt install python-pip` is not working for you, you can try the next steps:
    - `wget https://bootstrap.pypa.io/pip/2.7/get-pip.py`
    - `python get-pip.py`
    - Add the line `PATH="$HOME/.local/bin:$PATH"` to `.zshrc` or `.bashrc` file
- Once you hace pip for Python 2 installed run: `pip install --upgrade setuptools`

## Solution

Well, i wrote a little script that will install the last Volatility version available and all the dependecies needed to run it.

The installer will also add Volatility to your path as `volatility2` (You will need to reopen the terminal for this changes to take effect) and if you need to update Volatility just rerun this installer (Wont duplicate anything dont worry about that).
