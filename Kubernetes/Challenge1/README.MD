# Challenge: Schedualer administrador

## Issue
The goal of this challenge is to demonstrate how to control the exact location of Pods using Kubernetes scheduling tools.

# Solution

```bash
# Apply the following taints.
kubectl taint nodes worker key1=data-storage:NoSchedule
kubectl taint nodes k8s4devs-worker3 key1=critical-app:NoExecute 

# Then label the critical node in order to create a node selector.
kubectl label node k8s4devs-worker3 AppType=Critical  
```
