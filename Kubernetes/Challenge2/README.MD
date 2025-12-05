# Challenge: Implementing Storage Classes and Dynamic Volume Provisioning

## Issue
A company requires a dynamically provisioned persistent volume for a web application that stores its logs on a storage backend. They want the storage to be dynamically created using a StorageClass backed by the hostPath provisioner (for simplicity in the exam). The logs should be stored in the /data/logs directory on the worker nodes.
