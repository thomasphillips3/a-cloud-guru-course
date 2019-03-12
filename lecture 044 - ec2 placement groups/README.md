# WATCH AGAIN
# Lecture 44: EC2 Placement Groups

## Notes
**Placement Group Types**
* Clustered  
  * group of instances within a single AZ
  * recommended for low latency and/ or high throughput applications

* Spread  
  * group of instances with each on distinct underlying hardware
  * can spread across multiple AZ
  * recommended for small number of geographically-separate critical instances

**Things to remember**
* placement group names must be unique within AWS account
* only allows certain instance types (Compute Optimized, GPU, Memory Optimized, Storage Optimized)
* should have homogenous instance types within groups