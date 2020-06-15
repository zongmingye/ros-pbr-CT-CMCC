#!/bin/sh

mkdir -p /tmp/pbr

#电信
curl https://bgp.space/chinanet.html > /tmp/pbr/ct.txt && sed -i '1,/BEGIN/d' /tmp/pbr/ct.txt && sed -i '/END/,$d' /tmp/pbr/ct.txt && sed -i 's/<br>//g' /tmp/pbr/ct.txt
#联通
curl https://bgp.space/unicom.html > /tmp/pbr/cnc.txt && sed -i '1,/BEGIN/d' /tmp/pbr/cnc.txt && sed -i '/END/,$d' /tmp/pbr/cnc.txt && sed -i 's/<br>//g' /tmp/pbr/cnc.txt
#移动
curl https://bgp.space/cmcc.html > /tmp/pbr/cmcc.txt && sed -i '1,/BEGIN/d' /tmp/pbr/cmcc.txt && sed -i '/END/,$d' /tmp/pbr/cmcc.txt && sed -i 's/<br>//g' /tmp/pbr/cmcc.txt
#铁通
curl https://bgp.space/tietong.html > /tmp/pbr/crtc.txt && sed -i '1,/BEGIN/d' /tmp/pbr/crtc.txt && sed -i '/END/,$d' /tmp/pbr/crtc.txt && sed -i 's/<br>//g' /tmp/pbr/crtc.txt
#教育网
curl https://bgp.space/cernet.html > /tmp/pbr/cernet.txt && sed -i '1,/BEGIN/d' /tmp/pbr/cernet.txt && sed -i '/END/,$d' /tmp/pbr/cernet.txt && sed -i 's/<br>//g' /tmp/pbr/cernet.txt
#科技网
curl https://bgp.space/cstnet.html > /tmp/pbr/cstnet.txt && sed -i '1,/BEGIN/d' /tmp/pbr/cstnet.txt && sed -i '/END/,$d' /tmp/pbr/cstnet.txt && sed -i 's/<br>//g' /tmp/pbr/cstnet.txt

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

nets=`cat /tmp/pbr/cstnet.txt`
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

nets=`cat /tmp/pbr/cstnet.txt`
for net in $nets ; do
  echo "add list=dpbr-CT address=$net"
done
} > /var/www/html/nextcloud/data/jacyl4/files/github/ros-pbr-CT-CMCC/ros-dpbr-CT-CMCC.rsc 

rm -rf /tmp/pbr