# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion eutils

DESCRIPTION="An open-source interface to Z-Wave networks."
HOMEPAGE="http://open-zwave.googlecode.com"
ESVN_REPO_URI="http://open-zwave.googlecode.com/svn/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
SLOT="0"

DEPEND="dev-libs/libxml2"
RDEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-missing_revision_fix.patch"
}

src_compile() {
	emake -C cpp/build || die
}

src_install() {
	dodir /etc/openzwave
	dodir /usr/include/openzwave
	dodir /usr/include/openzwave/command_classes
	dodir /usr/include/openzwave/value_classes
	dodir /usr/include/openzwave/platform
	dodir /usr/include/openzwave/platform/unix
	dodir /usr/share/openzwave
	dodir /usr/lib

	insinto /usr/share/openzwave
	doins -r config
	exeinto /usr/lib
	dolib.so cpp/build/libopenzwave.so
	dolib.a cpp/build/libopenzwave.a

	insinto /usr/include/openzwave
	doins cpp/src/*.h
	insinto /usr/include/openzwave/command_classes
	doins cpp/src/command_classes/*.h
	insinto /usr/include/openzwave/value_classes
	doins cpp/src/value_classes/*.h
	insinto /usr/include/openzwave/platform
	doins cpp/src/platform/*.h
	insinto /usr/include/openzwave/platform/unix
	doins cpp/src/platform/unix/*.h
}
