# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/03-compute-resources.md

gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom

gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24

gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16

gcloud compute firewall-rules create kubernetes-the-hard-way-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0

gcloud compute addresses create kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region)

# for i in 0 1 2; do
#   gcloud compute instances create controller-${i} \
#     --async \
#     --boot-disk-size 200GB \
#     --can-ip-forward \
#     --image-family ubuntu-1804-lts \
#     --image-project ubuntu-os-cloud \
#     --machine-type n1-standard-1 \
#     --private-network-ip 10.240.0.1${i} \
#     --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
#     --subnet kubernetes \
#     --tags kubernetes-the-hard-way,controller
# done
