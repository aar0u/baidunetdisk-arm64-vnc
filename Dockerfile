FROM jlesage/baseimage-gui:debian-10-v4.6.7

ARG BAIDUNETDISK_VER=4.17.7

ENV APP_NAME="Baidunetdisk"
# ENV NOVNC_LANGUAGE="zh_Hans"
ENV TZ=Asia/Shanghai
ENV HOME=/config
ENV LC_ALL=C

# COPY --chmod=755 root /
COPY --chmod=755 startapp.sh /startapp.sh

RUN apt-get update \
&& apt-get install -y wget libnss3 libxss1 desktop-file-utils libasound2 ttf-wqy-zenhei libgtk-3-0 libgbm1 libnotify4 \
                      xdg-utils libsecret-common libsecret-1-0 libindicator3-7 libdbusmenu-glib4 libdbusmenu-gtk3-4 libappindicator3-1 procps \
&& wget https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/${BAIDUNETDISK_VER}/baidunetdisk_${BAIDUNETDISK_VER}_arm64.deb \
&& dpkg -i  baidunetdisk_${BAIDUNETDISK_VER}_arm64.deb \
&& rm  baidunetdisk_${BAIDUNETDISK_VER}_arm64.deb \
&& install_app_icon.sh https://raw.githubusercontent.com/emuqi/baidunetdisk-arm64-vnc/master/icon/baidunetdisk.png \
#fix window decorations
# && sed -i 's/normal/desktop/g' /opt/base/etc/jwm/main-window-group.sh \
#novnc_language
# && mv /opt/noVNC/index.html /opt/noVNC/index.html.en \
#fix dpkg
# && sed -i '/messagebus/d' /var/lib/dpkg/statoverride
&& sed -i "s#<decor>no</decor>#<decor>yes</decor>#g" /opt/base/etc/openbox/rc.xml.template
