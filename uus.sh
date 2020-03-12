#USAGE: 
# $ sudo chmod +x uss.sh
# $ source uss.sh

#TO DO: 
# prevent the EV to be added to .bashrc if they already exist
# wait for user to confirm by pressing enter after reading cuda instructions
# automate for installing latest nvidia driver
# finish GPU tensorflow option 

#USER VARIABLES TO MODIFY
git_email="laygond_bryan@hotmail.com"
git_name="laygond"
venv_name="udacity"
gpu_ON=false 
tensorflow_gpu=1.12.0
cuda=9.0
cuda_link=https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
cuDNN=7.4.1

# ------- NOTES on How to Install NVIDIA GPU ---------- 
# Check the following link to know the possible software combinations:
# - https://www.tensorflow.org/install/source#tested_build_configurations
#
# Obtain cuda_link
# 1 - go to https://developer.nvidia.com/cuda-toolkit-archive
# 2 - perform these steps for your version https://s3-us-west-2.amazonaws.com/static.pyimagesearch.com/ubuntu1804-tf-keras/ubuntu1804_dl_install_cudatoolkit.mp4.gif 
#
# Download cuDNN library
# 1 - Download cuDNN from https://developer.nvidia.com/cudnn after login in
#     and agreeing to the terms (you need an account)
# 2 - Click on “Archived cuDNN Releases”
# 3 - Choose your version. For example “cuDNN (v7.4.1) for CUDA (9.0)” and “cuDNN Library for Linux”
#
# My reference were:
# - https://www.pyimagesearch.com/2019/01/30/ubuntu-18-04-install-tensorflow-and-keras-for-deep-learning/
# - https://dennisnotes.com/note/20180528-ubuntu-18.04-machine-learning-setup/
# 

# Run Options
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
  
      -g|--github)
      # Sets all your Github Info
      git config --global user.email $git_email
      git config --global user.name $git_name
      shift # ditch current key argument once read
      ;;
      
      -d|--dropbox)
      # Install Dropbox Uploader to upload from Terminal
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
       
      -n|--gpu)
      # Install latest NVIDIA GPU Driver
      sudo add-apt-repository ppa:graphics-drivers/ppa
      sudo apt-get update
      sudo apt install nvidia-driver-440  # Check latest options through: <$ ubuntu-drivers devices>
      echo "You must <$ sudo reboot now> for actions to take effect and later verify installation through <$ nvidia-smi>"
      shift # ditch current key argument once read
      ;;
      
      -c|--cuda)
      # Install CUDA Toolkit 
      if [[$cuda = 9.0]] #(needs gcc and g++ v6)
      then
        sudo apt-get install gcc-6 g++-6   
      fi
      wget $cuda_link
      sudo chmod +x cuda_$cuda.*linux-run #example cuda_9.0.176_384.81_linux-run
      echo "In the next section"
      echo -e "Select y for \"Install on an unsupported configuration\""
      echo -e "Select n for \"Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 384.81?\""
      echo -e "Keep all other default values (some are y  and some are n ). For paths, just press \"enter.\""
      sudo ./cuda_$cuda.*linux-run --override #The override uses gcc6 for cuda 9.0
      echo "[INFO] exporting CUDA path to .bashrc... "
      echo -e "\n# NVIDIA CUDA Toolkit" >> ~/.bashrc
      echo "export PATH=/usr/local/cuda-$cuda/bin:$PATH" >> ~/.bashrc
      echo "export LD_LIBRARY_PATH=/usr/local/cuda-$cuda/lib64" >> ~/.bashrc
      source ~/.bashrc
      echo "[INFO] verifying installation... "
      nvcc -V
      shift # ditch current key argument once read
      ;;

      -l|--cuDNN)
      # Install cuDNN library
      scp ~/Downloads/cudnn-$cuda*$cuDNN*.tgz ~
      cd ~
      echo "[INFO] extracting $(ls cudnn-$cuda*$cuDNN*.tgz) at $(pwd)"
      tar -zxf cudnn-$cuda*$cuDNN*.tgz 
      cd cuda
      sudo cp -P lib64/* /usr/local/cuda/lib64/
      sudo cp -P include/* /usr/local/cuda/include/
      cd ~
      rm cudnn-$cuda*$cuDNN*.tgz
      shift # ditch current key argument once read
      ;;
      
      *)    # unknown option
      echo "unknown option passed"
      shift # ditch current key argument once read
      ;;
  esac
done


# # Run all options
# if [[ $1 = -a || $1 = --all ]]
# then
#   shift # ditch current key argument once read
#   $1=-g
#   $2=-d
#   $3=-u
#   $4=-t
# fi

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
