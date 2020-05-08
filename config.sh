#!/bin/bash

#USER VARIABLES TO MODIFY
git_email="laygond_bryan@hotmail.com"
git_name="laygond"
gpu_ON=true     # if false: install 'cpu' latest tensorflow  
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
# - https://stackoverflow.com/questions/47068709/your-cpu-supports-instructions-that-this-tensorflow-binary-was-not-compiled-to-u
#