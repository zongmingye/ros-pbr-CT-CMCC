#!/bin/sh

mkdir -p /tmp/pbr

#电信
curl https://ispip.clang.cn/chinatelecom_cidr.txt > /tmp/pbr/ct.txt
#联通
curl https://ispip.clang.cn/unicom_cnc_cidr.txt > /tmp/pbr/cnc.txt
#移动
curl https://ispip.clang.cn/cmcc_cidr.txt > /tmp/pbr/cmcc.txt
#铁通
curl https://ispip.clang.cn/crtc_cidr.txt > /tmp/pbr/crtc.txt
#教育网
curl https://ispip.clang.cn/cernet_cidr.txt > /tmp/pbr/cernet.txt
#长城宽带/鹏博士
curl https://ispip.clang.cn/gwbn_cidr.txt > /tmp/pbr/gwbn.txt
#其他
curl https://ispip.clang.cn/othernet_cidr.txt > /tmp/pbr/other.txt

{
echo "/ip route rule"

nets=`cat /tmp/pbr/ct.txt`
for net in $nets ; do
  echo "add dst-address=$net action=lookup table=CT"
done

nets=`cat /tmp/pbr/cnc.txt`
for net in $nets ; do
  echo "add dst-address=$net action=lookup table=CT"
done

nets=`cat /tmp/pbr/cmcc.txt`
for net in $nets ; do
  echo "add dst-address=$net action=lookup table=CMCC"
done

nets=`cat /tmp/pbr/crtc.txt`
for net in $nets ; do
  echo "add dst-address=$net action=lookup table=CT"
done

nets=`cat /tmp/pbr/cernet.txt`
for net in $nets ; do
  echo "add dst-address=$net action=lookup table=CT"
done

nets=`cat /tmp/pbr/gwbn.txt`
for net in $nets ; do
  echo "add dst-address=$net action=lookup table=CT"
done

nets=`cat /tmp/pbr/other.txt`
for net in $nets ; do
  echo "add dst-address=$net action=lookup table=CT"
done
} > /var/www/html/nextcloud/data/jacyl4/files/github/ros-pbr-CT-CMCC/ros-pbr-CT-CMCC.rsc 


{
echo "/ip firewall address-list"

nets=`cat /tmp/pbr/ct.txt`
for net in $nets ; do
  echo "add list=dpbr-CT address=$net"
done

nets=`cat /tmp/pbr/cnc.txt`
for net in $nets ; do
  echo "add list=dpbr-CMCC address=$net"
done

nets=`cat /tmp/pbr/cmcc.txt`
for net in $nets ; do
  echo "add list=dpbr-CMCC address=$net"
done

nets=`cat /tmp/pbr/crtc.txt`
for net in $nets ; do
  echo "add list=dpbr-CMCC address=$net"
done

nets=`cat /tmp/pbr/cernet.txt`
for net in $nets ; do
  echo "add list=dpbr-CT address=$net"
done

nets=`cat /tmp/pbr/gwbn.txt`
for net in $nets ; do
  echo "add list=dpbr-CT address=$net"
done

nets=`cat /tmp/pbr/other.txt`
for net in $nets ; do
  echo "add list=dpbr-CT address=$net"
done
} > /var/www/html/nextcloud/data/jacyl4/files/github/ros-pbr-CT-CMCC/ros-dpbr-CT-CMCC.rsc 

rm -rf /tmp/pbr