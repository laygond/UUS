#USAGE: 
# $ sudo chmod +x uss.sh
# $ source uss.sh

#USER VARIABLES TO MODIFY
git_email="laygond_bryan@hotmail.com"
git_name="laygond"
venv_name="udacity"

# Configure git with your account for commits
git config --global user.email $git_email
git config --global user.name $git_name

# Update and upgrade packages
sudo apt-get update
sudo apt-get upgrade -y

# Install pip3
sudo apt-get install python3-pip

# Install virtual environment and set environmental variables
sudo pip3 install -U virtualenv virtualenvwrapper
echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
source ~/.bashrc

# Create Virtual Environment and activate it
#mkvirtualenv $venv_name -p python3
#workon $venv_name
virtualenv --system-site-packages -p python3 ./$venv_name
source ./$venv_name/bin/activate  # sh, bash, ksh, or zsh

# Install pkg within the udacity env
pip3 install --upgrade pip
pip3 list  # show packages installed within the virtual environment

# Install OpenCV 
pip3 install opencv-contrib-python

# Install TensorFlow
pip3 install tensorflow-gpu

# { # try

#     command1 &&
#     #save your output

# } || { # catch
#     # save log for exception 
# }
