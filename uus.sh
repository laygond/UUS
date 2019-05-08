#USAGE: 
# $ sudo chmod +x uss.sh
# $ ./uss.sh

# Script starts here
sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get -y install python3-pip

sudo pip3 install virtualenv virtualenvwrapper
#$ sudo rm -rf ~/get-pip.py ~/.cache/pip
echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
source ~/.bashrc
mkvirtualenv py3cv4 -p python3

workon py3cv4
pip3 install opencv-contrib-python

# { # try

#     command1 &&
#     #save your output

# } || { # catch
#     # save log for exception 
# }
