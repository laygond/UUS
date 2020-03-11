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
      
      -s|--setup)
      # Install development tools, image and video I/O libraries, GUI packages, optimization libraries, and other packages:
      sudo apt-get install build-essential cmake unzip pkg-config
      sudo apt-get install libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
      sudo apt-get install libjpeg-dev libpng-dev libtiff-dev
      sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
      sudo apt-get install libxvidcore-dev libx264-dev
      sudo apt-get install libgtk-3-dev
      sudo apt-get install libopenblas-dev libatlas-base-dev liblapack-dev gfortran
      sudo apt-get install libhdf5-serial-dev
      sudo apt-get install python3-dev python3-tk python-imaging-tk
      shift # ditch current key argument once read
      ;;
      
      # ------- Install NVIDIA GPU ---------- 
      # https://www.tensorflow.org/install/source#tested_build_configurations
      # The folllowing build configuration combo will be installed:
      #tensorflow-gpu==1.12.0
      #cuda==9.0 (needs gcc and g++ v6)
      #cuDNN==7.1.4
      
      -n|--gpu)
      # Install NVIDIA GPU Driver
      sudo add-apt-repository ppa:graphics-drivers/ppa
      sudo apt-get update
      sudo apt install nvidia-driver-440  # Check latest options through: <$ ubuntu-drivers devices>
      echo "You must <$ sudo reboot now> for actions to take effect and later verify installation through <$ nvidia-smi>"
      shift # ditch current key argument once read
      ;;
      
      -c|--cuda)
      # Install CUDA Toolkit and cuDNN: 
      # https://www.pyimagesearch.com/2019/01/30/ubuntu-18-04-install-tensorflow-and-keras-for-deep-learning/
      #cuda==9.0 (needs gcc and g++ v6)
      sudo apt-get install gcc-6 g++-6
      wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
      sudo chmod +x cuda_9.0.176_384.81_linux-run
      echo "In the next section"
      echo -e "Select y for \"Install on an unsupported configuration\""
      echo -e "Select n for \"Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 384.81?\""
      echo -e "Keep all other default values (some are y  and some are n ). For paths, just press \"enter.\""
      sudo ./cuda_9.0.176_384.81_linux-run --override #The override uses gcc6 instead of default version
      echo -e "\n# NVIDIA CUDA Toolkit" >> ~/.bashrc
      echo "export PATH=/usr/local/cuda-9.0/bin:$PATH" >> ~/.bashrc
      echo "export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64" >> ~/.bashrc
      source ~/.bashrc
      nvcc -V
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
