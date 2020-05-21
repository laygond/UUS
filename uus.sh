#USAGE: 
# $ sudo chmod +x uss.sh
# $ source uss.sh

#TO DO: 
# prevent the EV to be added to .bashrc if they already exist
# wait for user to confirm by pressing enter after reading cuda instructions
# automate for installing latest nvidia driver
# set options for multiple GPU and install mxnet
# set warning for installing py libraries outside venv

# Load User Configuration File
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
sudo chmod +x $DIR/config.sh
source $DIR/config.sh

# Run Options
function uus() {
  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
    
        -g|--github)
        # Sets all your Github Info
        git config --global user.email $git_email
        git config --global user.name $git_name
        echo "Your Git credentials are set $git_name"
        shift # ditch current key argument once read
        ;;
        
        -d|--dropbox)
        # Install Dropbox Uploader to upload from Terminal
        curl "https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o /tmp/dropbox_uploader.sh
        sudo chmod +x /tmp/dropbox_uploader.sh
        sudo install /tmp/dropbox_uploader.sh /usr/local/bin/dropbox_uploader
        shift # ditch current key argument once read
        ;;
        
        -j|--jupyter)
        # Install Jupyter within an environment
        echo "[INFO] Installing Jupyter Lab... " 
        pip install jupyterlab
        echo -e "\n# Jupyter Lab/Notebook" >> ~/.bashrc
        echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
        pip install ipykernel
        python -m ipykernel install --user --name $(echo $VIRTUAL_ENV | rev | cut -d '/' -f 1 | rev)
        jupyter kernelspec list
        shift # ditch current key argument once read
        ;;

        -u|--update)
        sudo apt-get update
        sudo apt-get upgrade -y
        shift # ditch current  key argument once read
        ;;
        
        -v|--pysetup)
        # Install pip, virtualenv, and virtualenvwrapper
        wget https://bootstrap.pypa.io/get-pip.py
        sudo python3 get-pip.py
        sudo pip install virtualenv virtualenvwrapper
        sudo rm -rf get-pip.py ~/.cache/pip
        echo "[INFO] exporting virtual env path to .bashrc... "
        echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
        echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
        echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
        echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
        source ~/.bashrc
        shift # ditch current key argument once read
        ;;
        
        -b|--pylib)
        # Install Deep Learning Python Libraries
        pip install numpy
        pip install opencv-contrib-python
        pip install scipy matplotlib pillow
        pip install h5py requests progressbar2
        pip install scikit-learn scikit-image
        if [[ $gpu_ON = true ]]
        then
          pip install tensorflow-gpu==$tensorflow_gpu
          echo -e "\n# Remove Modern CPU Extension Warnings (SSE4.1, SSE4.2, AVX, AVX2, FMA, etc.)" >> ~/.bashrc
          echo "export TF_CPP_MIN_LOG_LEVEL=2" >> ~/.bashrc
        else
          pip install tensorflow
        fi
        pip install keras
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
        sudo apt-get install tree
        sudo apt-get install curl wget lynx w3m
        shift # ditch current key argument once read
        ;;
        
        -gpu|--gpu)
        # Install latest NVIDIA GPU Driver
        sudo add-apt-repository ppa:graphics-drivers/ppa
        sudo apt-get update
        sudo apt install nvidia-driver-440  # Check latest options through: <$ ubuntu-drivers devices>
        echo "You must <$ sudo reboot now> for actions to take effect and later verify installation through <$ nvidia-smi>"
        shift # ditch current key argument once read
        ;;
        
        -cuda|--cuda)
        # Install CUDA Toolkit 
        if [[ $cuda = 9.0 ]] #(needs gcc and g++ v6)
        then
          sudo apt-get install gcc-6 g++-6   
        fi
        wget $cuda_link
        sudo chmod +x cuda_$cuda.*linux-run #example cuda_9.0.176_384.81_linux-run
        echo "In the next section"
        echo -e "Select y for \"Install on an unsupported configuration\""
        echo -e "Select n for \"Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 384.81?\""
        echo -e "Keep all other default values (some are y  and some are n ). For paths, just press \"enter.\""
        if [[ $cuda = 9.0 ]] 
        then
          sudo ./cuda_$cuda.*linux-run --override #The override uses gcc6 for cuda 9.0
        else
          sudo ./cuda_$cuda.*linux-run
        fi
        echo "[INFO] exporting CUDA path to .bashrc... "
        echo -e "\n# NVIDIA CUDA Toolkit" >> ~/.bashrc
        echo "export PATH=/usr/local/cuda-$cuda/bin:\$PATH" >> ~/.bashrc
        echo "export LD_LIBRARY_PATH=/usr/local/cuda-$cuda/lib64" >> ~/.bashrc
        source ~/.bashrc
        echo "[INFO] verifying installation... "
        nvcc -V
        rm cuda_$cuda.*linux-run
        shift # ditch current key argument once read
        ;;
        
        -cudnn|-cuDNN|--cudnn|--cuDNN)
        # Install cuDNN library
        if [[ -d "/usr/local/cuda/include" ]] 
        then
          echo "[INFO] Removing previous CuDNN version"
          sudo rm -f /usr/local/cuda/include/cudnn.h 
          sudo rm -rf /usr/local/cuda/lib64/libcudnn*
        fi
        current_dir=$(pwd)
        cd ~/Downloads/
        [[ -d "cuda" ]] && sudo rm -rf cuda
        if [[ -e $(ls cudnn-$cuda*$cuDNN*.tgz) ]]
        then 
          echo "[INFO] extracting $(ls cudnn-$cuda*$cuDNN*.tgz) at $(pwd)"
          tar -zxf cudnn-$cuda*$cuDNN*.tgz 
          cd cuda
          sudo cp -P lib64/* /usr/local/cuda/lib64/
          sudo cp -P include/* /usr/local/cuda/include/
          echo "[INFO] CuDNN Installation Complete"
          cd $current_dir
        else
          echo "[INFO] The CuDNN must be downloaded. Read config.sh for steps"
          echo "[INFO] Installation incomplete"
        fi
        shift # ditch current key argument once read
        ;;
        
        -f|--favorite)
        # Install favorite Browser, Editor, VNC, etc
        echo "[INFO] Installing Browser... "
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo apt install ./google-chrome-stable_current_amd64.deb
        rm google-chrome-stable_current_amd64.deb
        echo "[INFO] Installing Real-VNC Server... "
        wget $(lynx -listonly -nonumbers -dump https://www.realvnc.com/en/connect/download/vnc/linux/ | grep Linux-x64.deb | head -n 1)
        sudo apt install ./VNC-Server-*-Linux-x64.deb
        rm VNC-Server-*-Linux-x64.deb
        echo "[INFO] Installing Real-VNC Client... "
        wget $(lynx -listonly -nonumbers -dump https://www.realvnc.com/en/connect/download/viewer/linux/ | grep Linux-x64.deb | head -n 1)
        sudo apt install ./VNC-Viewer-*-Linux-x64.deb
        rm VNC-Viewer-*-Linux-x64.deb
        echo "[INFO] Installing Team Viewer... "
        wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
        sudo apt install ./teamviewer_amd64.deb
        rm teamviewer*.deb
        echo "[INFO] Installing OpenSSH... "
        sudo apt install openssh-server
        sudo ufw allow ssh
        echo "[INFO] Installing Kite Extension for VS Code... " #MyPy and SonarLint?
        bash -c "$(wget -q -O – https://linux.kite.com/dls/linux/current)"
        code --install-extension kiteco.kite 
        echo "[INFO] Installing Krita Paint App for Linux... " 
        sudo apt install krita
        echo "[INFO] Installing OBS Studio for Linux... "
        sudo apt install ffmpeg 
        sudo add-apt-repository ppa:obsproject/obs-studio
        sudo apt update
        sudo apt install obs-studio
        shift # ditch current key argument once read
        ;;

        -obs|--obs)
        echo "[INFO] Installing OBS Studio for Linux... "
        sudo apt install ffmpeg 
        sudo add-apt-repository ppa:obsproject/obs-studio
        sudo apt update
        sudo apt install obs-studio
        shift # ditch current key argument once read
        ;;

        -hack|--hack)
        # Install hacking tools
        sudo apt-get install hydra
        sudo apt-get install nmap
        shift # ditch current key argument once read
        ;;
        
        -custom|--custom)
        # Add MY CUSTOM UNIX COMMANDS shortcuts
        sudo chmod +x ~/UUS/.my_custom_unix_commands.sh
        echo "[INFO] loading MY CUSTOM UNIX COMMANDS to .bashrc... "
        echo -e "\n# MY CUSTOM UNIX COMMANDS" >> ~/.bashrc
        echo "source $DIR/.my_custom_unix_commands.sh" >> ~/.bashrc
        echo "[INFO] Done! Now restart terminal or open new"
        shift # ditch current key argument once read
        ;;
        
        *)    
        # unknown option
        echo "unknown option passed"
        shift # ditch current key argument once read
        ;;
    esac
  done
}


#--------------------------------------
# { # try

#     command1 &&
#     #save your output

# } || { # catch
#     # save log for exception 
# }

