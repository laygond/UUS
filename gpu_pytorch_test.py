import torch

print("[INFO]\n\
        \ttorch.cuda.is_available()\n\
        \ttorch.cuda.current_device()\n\
        \ttorch.cuda.device(0)\n\
        \ttorch.cuda.device_count()\n\
        \ttorch.cuda.get_device_name(0)")
print("[INFO] ",torch.cuda.is_available())
print("[INFO] ",torch.cuda.current_device())
print("[INFO] ",torch.cuda.device(0))
print("[INFO] ",torch.cuda.device_count())
print("[INFO] ",torch.cuda.get_device_name(0))
