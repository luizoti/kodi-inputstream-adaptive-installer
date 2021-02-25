#!/bin/bash

user=$(id -un 1000)
pkgname=inputstream.adaptive
pkgver=2.4.6
_codename=Leia
pkgrel=5
pkgdesc="InputStream client for adaptive streams for Kodi 18+"
arch=('x86_64')
url="https://github.com/peak3d/inputstream.adaptive"
license=('GPL2')
# groups=('kodi-addons' 'kodi-addons-inputstream')
# depends=('kodi' 'kodi-platform')
# makedepends=('cmake' 'kodi-dev')
source=("${pkgname}-${pkgver}.deb" "https://www.deb-multimedia.org/pool/main/k/kodi-inputstream-adaptive-dmo/kodi-inputstream-adaptive_2.4.6-dmo0+deb10u1_amd64.deb")
# sha512sums=('a92dd8ac439d4bc3f33e619cf6ca5ed838040cc377cbd0ba15d9dcde56eb141f2b3c2a16a2f7400f615450024ec4ffafb29db6a77239059e0cff3c92c06fb587')

tmpdir=/home/${user}/.kodi/temp/temp/
filedest=${tmpdir}${source[0]}

download(){
	if [[ ! -f ${filedest} ]]; then
		wget -O ${filedest} ${source[1]}
	fi

	if [[ -f ${filedest} ]]; then
		datafile="${tmpdir}/data.tar.xz"
		echo ${filedest}
		copyfiles
	fi

}

copyfiles(){
	OLDIFS=$IFS
	IFS=';'
	addondir=/home/${user}/.kodi/addons/inputstream.adaptive
	dirlist="/usr/lib/x86_64-linux-gnu/kodi/addons/inputstream.adaptive/;/usr/share/kodi/addons/inputstream.adaptive/"

	if [[ ! -d ${addondir} ]]; then
		mkdir ${addondir}
	fi

	for directory in ${dirlist}; do
		sourcedir=${tmpdir}${directory}
		echo
		if [[ -d ${addondir} ]]; then
			echo ${addondir}
			rsync -vau --remove-source-files ${sourcedir} ${addondir}
		fi
	done
	IFS=$OLDIFS
}

download