#!/bin/bash

#USER VARIABLES TO MODIFY
git_email="laygond_bryan@hotmail.com"
git_name="laygond"
gpu_ON=true     # if false: install 'cpu' latest tensorflow  
tensorflow_gpu=1.12.0
cuda=10.1
cuda_link='https://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run'
cuDNN=8.0.5 
gpu_architecture=7.5

# ------- NOTES on How to Install NVIDIA GPU ---------- 
# Check the following link to know the possible software combinations:
# - https://www.tensorflow.org/install/source#tested_build_configurations
#
# Obtain cuda_link
# 1 - go to https://developer.nvidia.com/cuda-toolkit-archive
# 2 - click on your cuda version and then get for linux the runfile(local) link 
#
# Download cuDNN library
# 1 - Download cuDNN from https://developer.nvidia.com/cudnn after login in
#     and agreeing to the terms (you need an account)
# 2 - Click on “Archived cuDNN Releases”
# 3 - Choose your version. For example “cuDNN (v7.4.1) for CUDA (9.0)” and “cuDNN Library for Linux”
#
# Set up GPU for OpenCV
# 1 - Grab your GPU name by typing in terminal: nvidia-smi. For example "GeForce RTX 2080 Ti" 
# 2 - Search for that name in https://developer.nvidia.com/cuda-gpus
# 3 - your gpu_architecture number is displayed under "Compute Capability"
# 
# My reference were:
# - https://www.pyimagesearch.com/2019/01/30/ubuntu-18-04-install-tensorflow-and-keras-for-deep-learning/
# - https://dennisnotes.com/note/20180528-ubuntu-18.04-machine-learning-setup/
# - https://stackoverflow.com/questions/47068709/your-cpu-supports-instructions-that-this-tensorflow-binary-was-not-compiled-to-u
# - https://code.tutsplus.com/tutorials/understanding-virtual-environments-in-python--cms-28272
# - https://www.pyimagesearch.com/2020/02/03/how-to-use-opencvs-dnn-module-with-nvidia-gpus-cuda-and-cudnn/