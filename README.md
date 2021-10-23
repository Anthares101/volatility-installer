<img alt="GitHub" src="https://img.shields.io/badge/version-v1.2-blue"> <img alt="GitHub" src="https://img.shields.io/github/license/anthares101/kali_volatility_installer">

# Volatility installer

If you researched a bit, the Volatility releases are not up to date and if you want to have an updated version you need to get Volatility from its GitHub 
[repository](https://github.com/volatilityfoundation/volatility). You could get Volatility from `apt`, even though, it is not the last version and I recommend getting Volatility from the GitHub repository.

## Why this installer?

Installing Volatility from the repository can be a bit tricky beacuse of all the needed dependencies, some of them even need a certain version in order to work since Volatility use Python 2. To avoid this process every time I needed to setup a fresh Linux install, I decided to create this script.

The script will install all the Python dependencies in a virtual environment so don't worry about your local Python installation.

## Disclaimer

The script should work in all Linux distributions with Bash and the `apt` packet manager but it is only tested in Ubuntu and Kali. The installation process will create an alias to your `.bashrc` or `.zshrc` in order to execute Volatility from any location. If you dont use Bash or Zsh as your main shell you will need to add the alias yourself (Sorry!).

# Uninstalling Volatility

If you want to uninstall follow this steps:
- Delete the `/opt/vol/` directory
- The script also installs the packages `python2`, `python-dev`, `git`, `build-essential` and `python3-virtualenv` if missing so in case you don't need them just uninstall them manually
- Remove the `alias volatility=...` line in you `.bashrc` or `.zshrc` file
