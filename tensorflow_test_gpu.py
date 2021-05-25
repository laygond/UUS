import tensorflow as tf
from tensorflow.python.client import device_lib
print("[INFO] Tensorflow Version")
print("[INFO] ",tf.__version__)

# Set to true if you would like TensorFlow to automatically
# choose an existing and supported device to run the operations
# in case the specified one doesn't exist
tf.config.set_soft_device_placement(False)

# Set to true to find out which devices your operations and 
# tensors are assigned to
tf.debugging.set_log_device_placement(True)

# ----- Hardware Devices
print("[INFO] List of hardware names")
def get_available_hardware():
    local_device_protos = device_lib.list_local_devices()
    return [x.name for x in local_device_protos]
print("[INFO] ",get_available_hardware())

# ----- GPU Support
# Returns whether TensorFlow was built with GPU (i.e. CUDA or ROCm) support.
print("[INFO] Built with GPU Support?")
print("[INFO] ",tf.test.is_built_with_gpu_support())

# ----- CUDA Support
# Returns whether TensorFlow was built with CUDA (GPU) support.
print("[INFO] Built with CUDA Support?")
print("[INFO] ",tf.test.is_built_with_cuda())

# ----- Physical Devices
# Physical devices are hardware devices present on the host machine. By default all discovered CPU and GPU devices are considered visible.
# Accessed prior to runtime initialization
print("[INFO] List Physical Devices")
print("[INFO] ",tf.config.experimental.list_physical_devices())

# ------ Logical Devices
# Logical devices may correspond to physical devices or remote devices in the cluster. 
# It starts at runtime
print("[INFO] List Logical Devices")
print("[INFO] ",tf.config.experimental.list_logical_devices())

# ------ Test CPU
# Place tensors on the CPU
# If the device you have specified does not exist, you will get a RuntimeError: .../device:GPU:2 unknown device.
print("[INFO] Test CPU")
with tf.device("/device:XLA_CPU:0"):
    a = tf.constant([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]])
    b = tf.constant([[1.0, 2.0], [3.0, 4.0], [5.0, 6.0]])
    c = tf.matmul(a, b)
    print(c)

# ------ Test GPU
# Place tensors on the GPU
# If the device you have specified does not exist, you will get a RuntimeError: .../device:GPU:2 unknown device.
print("[INFO] Test GPU")
with tf.device("/device:GPU:0"):
    a = tf.constant([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]])
    b = tf.constant([[1.0, 2.0], [3.0, 4.0], [5.0, 6.0]])
    c = tf.matmul(a, b)
    print(c)
