#!/bin/bash
echo "OC is: "
cat /etc/os-release | grep -E "PRETTY_NAME="
echo "OC version is: "
cat /etc/os-release | grep -E "^VERSION="
echo "Archetecture of Linux is: "
uname -r
echo "Processor model is: "
lscpu | grep "Model name"
echo "Maximum frequency is: "
lscpu | grep "CPU max MHz: "
echo "Amount of cores: "
lscpu | grep "Core(s)" | cut -c37-
echo "Processor have caches: "
echo "L1d"
lscpu | grep "L1d" | cut -c37-
echo "L1i"
lscpu | grep "L1i" | cut -c37-
echo "L2"
lscpu | grep "L2" | cut -c37-
echo "L3"
lscpu | grep "L3" | cut -c37-
echo "Free RAM(in megabytes): "
free -m | grep "Mem" | cut -c41-49
echo "Total memory(in megabytes): "
free -m | grep "Mem" | cut -c17-25
echo "Memory used(in megabytes): "
free -m | grep "Mem" | cut -c29-39
echo "Network interfaces: "
for count in $(ls /sys/class/net/); do
ifconfig -s $count | grep $count | cut -c1-8
ip addr show $count| awk '
/link\/either/{print "Mac is: "$2}
/inet /{print "IP is: "$2 }
'
ethtool $count | grep Speed
done
echo "System Partitions: "
df -T --human-readable
