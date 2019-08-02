#USAGE: 
# $ sudo chmod +x uss.sh
# $ source uss.sh

#TO DO: 
# prevent the EV to be added to .bashrc if they already exist
# finish GPU tensorflow option 

#USER VARIABLES TO MODIFY
git_email="laygond_bryan@hotmail.com"
git_name="laygond"
venv_name="udacity"
gpu_ON=false 

# Run all options
if [$1 = -a || $1 = --all]
then
  shift # ditch current key argument once read
  $1=-g
  $2=-d
  $3=-u
  $4=-t
fi

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
  
      -g|--github)
      git config --global user.email $git_email
      git config --global user.name $git_name
      shift # ditch current key argument once read
      ;;
      
      -d|--dropbox)
      sudo apt-get install curl
      curl "https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o /tmp/dropbox_uploader.sh
      sudo chmod +x /tmp/dropbox_uploader.sh
      sudo install /tmp/dropbox_uploader.sh /usr/local/bin/dropbox_uploader
      shift # ditch current key argument once read
      ;;
      
      -u|--update)
      sudo apt-get update
      sudo apt-get upgrade -y
      shift # ditch current  key argument once read
      ;;
      
      -t|--tree)
      sudo apt-get install tree
      shift # ditch current key argument once read
      ;;
      
      *)    # unknown option
      echo "unknown option passed"
      shift # ditch current key argument once read
      ;;
  esac
done


#echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
#echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc


#-------------------
# Install pip3
#sudo apt-get install python3-pip

# Install virtual environment and set environmental variables
#sudo pip3 install -U virtualenv virtualenvwrapper
#echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
#echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
#echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
#echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
#source ~/.bashrc

# Create Virtual Environment and activate it
#mkvirtualenv $venv_name -p python3
#workon $venv_name
#virtualenv --system-site-packages -p python3 ./$venv_name
#source ./$venv_name/bin/activate  # sh, bash, ksh, or zsh

# Install pkg within the udacity env
#pip3 install --upgrade pip
#pip3 list  # show packages installed within the virtual environment

# Install OpenCV 
#pip3 install opencv-contrib-python

# Install TensorFlow 
#if $gpu_ON
#	pip3 install tensorflow-gpu==1.2  #Make sure version compatible with your CUDA version 
#pip3 install tensorflow




#--------------------------------------
# { # try

#     command1 &&
#     #save your output

# } || { # catch
#     # save log for exception 
# }

#
