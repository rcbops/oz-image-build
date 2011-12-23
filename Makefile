FEDORA = f15 f16
CENTOS = centos60
RHEL = rhel56 rhel61
LUCID = ubuntu-lucid60 ubuntu-lucid80 ubuntu-lucid120 ubuntu-lucid160 ubuntu-lucid320
MAVERICK = ubuntu-maverick60 ubuntu-maverick80 ubuntu-maverick120 ubuntu-maverick160 ubuntu-maverick320
NATTY = ubuntu-natty60 ubuntu-natty80 ubuntu-natty120 ubuntu-natty160 ubuntu-natty320
TARGETS = $(FEDORA) $(CENTOS) $(RHEL) $(LUCID) $(MAVERICK) $(NATTY)
OZ_DEBUG=0

all:
	@echo "Usage"
	@echo "-----"
	@echo ""
	@echo "make <type>"
	@echo ""
	@$(foreach var,$(TARGETS),echo $(var);)
	@echo "build-fedora"
	@echo "build-centos"
	@echo "build-rhel"
	@echo "build-lucid"
	@echo "build-maverick"
	@echo ""
	@echo "Set the env variable OZ_DEBUG to an integer between 1-4 for additional information"
	@echo "on the status of the build"

# GENERIC BUILD TARGETS
build-all:	$(TARGETS)

build-fedora:	$(FEDORA)

build-centos:	$(CENTOS)

build-rhel:	$(RHEL)

build-lucid:	$(LUCID)

build-maverick:	$(MAVERICK)

##### Fedora 15
f15-upload:	f15-build
	../push.sh put publish/fedora15_x86_64.qcow2 "RCB OPS" fedora15_x86_64.qcow2

f15-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  f15 "fedora15_x86_64.qcow2" "fedora15_x86_64.dsk"

f15:	f15-upload

##### Fedora 16
f16-upload:	f16-build
	../push.sh put publish/fedora16_x86_64.qcow2 "RCB OPS" fedora16_x86_64.qcow2

f16-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  f16 "fedora16_x86_64.qcow2" "fedora16_x86_64.dsk"

f16:	f16-upload

##### Centos 6.0
centos60-upload:	centos60-build
	../push.sh put publish/centos60_x86_64.qcow2 "RCB OPS" centos60_x86_64.qcow2

centos60-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  centos60 "centos60_x86_64.qcow2" "centos60_x86_64.dsk" "centos60.oz.cfg"

centos60:	centos60-upload

##### RHEL 5.6
rhel56-upload:	rhel56-build
	../push.sh put publish/rhel56_x86_64.qcow2 "RCB OPS" rhel56_x86_64.qcow2

rhel56-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  rhel56 "rhel56_x86_64.qcow2" "rhel56_x86_64.dsk"

rhel56:	rhel56-upload

##### RHEL 6.1
rhel61-upload:	rhel61-build
	../push.sh put publish/rhel61_x86_64.qcow2 "RCB OPS" rhel61_x86_64.qcow2

rhel61-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  rhel61 "rhel61_x86_64.qcow2" "rhel61_x86_64.dsk" "rhel61.oz.cfg"

rhel61:	rhel61-upload

##### Ubuntu Lucid 60GB
ubuntu-lucid60-upload:	ubuntu-lucid60-build
	../push.sh put publish/ubuntu-lucid_x86_64_60G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_60G.qcow2

ubuntu-lucid60-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  ubuntu-lucid60 "ubuntu-lucid_x86_64_60G.qcow2" "ubuntu-lucid_x86_64_60G.dsk" "ubuntu-lucid.oz.cfg"

ubuntu-lucid60:	ubuntu-lucid60-upload

##### Ubuntu Lucid 80GB
ubuntu-lucid80-upload:	ubuntu-lucid80-build
	../push.sh put publish/ubuntu-lucid_x86_64_80G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_80G.qcow2

ubuntu-lucid80-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  ubuntu-lucid80 "ubuntu-lucid_x86_64_80G.qcow2" "ubuntu-lucid_x86_64_80G.dsk" "ubuntu-lucid.oz.cfg"

ubuntu-lucid80:	ubuntu-lucid80-upload

##### Ubuntu Lucid 120GB
ubuntu-lucid120-upload:	ubuntu-lucid120-build
	../push.sh put publish/ubuntu-lucid_x86_64_120G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_120G.qcow2

ubuntu-lucid120-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  ubuntu-lucid120 "ubuntu-lucid_x86_64_120G.qcow2" "ubuntu-lucid_x86_64_120G.dsk" "ubuntu-lucid.oz.cfg"

ubuntu-lucid120:	ubuntu-lucid120-upload

##### Ubuntu Lucid 160GB
ubuntu-lucid160-upload:	ubuntu-lucid160-build
	../push.sh put publish/ubuntu-lucid_x86_64_160G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_160G.qcow2

ubuntu-lucid160-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  ubuntu-lucid160 "ubuntu-lucid_x86_64_160G.qcow2" "ubuntu-lucid_x86_64_160G.dsk" "ubuntu-lucid.oz.cfg"

ubuntu-lucid160:	ubuntu-lucid160-upload

##### Ubuntu Lucid 320GB
ubuntu-lucid320-upload:	ubuntu-lucid320-build
	../push.sh put publish/ubuntu-lucid_x86_64_320G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_320G.qcow2

ubuntu-lucid320-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh  ubuntu-lucid320 "ubuntu-lucid_x86_64_320G.qcow2" "ubuntu-lucid_x86_64_320G.dsk" "ubuntu-lucid.oz.cfg"

ubuntu-lucid320:	ubuntu-lucid320-upload

##### MAVERICK 60G
ubuntu-maverick60-upload:	ubuntu-maverick60-build
	../push.sh put publish/ubuntu-maverick_x86_64_60G.qcow2 "RCB OPS" ubuntu-maverick_x86_64_60G.qcow2

ubuntu-maverick60-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-maverick60 "ubuntu-maverick_x86_64_60G.qcow2" "ubuntu-maverick_x86_64_60G.dsk" "ubuntu-maverick.oz.cfg"

ubuntu-maverick60:	ubuntu-maverick60-upload

##### MAVERICK 80G
ubuntu-maverick80-upload:	ubuntu-maverick80-build
	../push.sh put publish/ubuntu-maverick_x86_64_80G.qcow2 "RCB OPS" ubuntu-maverick_x86_64_80G.qcow2

ubuntu-maverick80-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-maverick80 "ubuntu-maverick_x86_64_80G.qcow2" "ubuntu-maverick_x86_64_80G.dsk" "ubuntu-maverick.oz.cfg"

ubuntu-maverick80:	ubuntu-maverick80-upload

##### MAVERICK 1200G
ubuntu-maverick120-upload:	ubuntu-maverick120-build
	../push.sh put publish/ubuntu-maverick_x86_64_120G.qcow2 "RCB OPS" ubuntu-maverick_x86_64_120G.qcow2

ubuntu-maverick120-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-maverick120 "ubuntu-maverick_x86_64_120G.qcow2" "ubuntu-maverick_x86_64_120G.dsk" "ubuntu-maverick.oz.cfg"

ubuntu-maverick120:	ubuntu-maverick120-upload

##### MAVERICK 160G
ubuntu-maverick160-upload:	ubuntu-maverick160-build
	../push.sh put publish/ubuntu-maverick_x86_64_160G.qcow2 "RCB OPS" ubuntu-maverick_x86_64_160G.qcow2

ubuntu-maverick160-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-maverick160 "ubuntu-maverick_x86_64_160G.qcow2" "ubuntu-maverick_x86_64_160G.dsk" "ubuntu-maverick.oz.cfg"

ubuntu-maverick160:	ubuntu-maverick160-upload

##### MAVERICK 320G
ubuntu-maverick320-upload:	ubuntu-maverick320-build
	../push.sh put publish/ubuntu-maverick_x86_64_320G.qcow2 "RCB OPS" ubuntu-maverick_x86_64_320G.qcow2

ubuntu-maverick320-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-maverick320 "ubuntu-maverick_x86_64_320G.qcow2" "ubuntu-maverick_x86_64_320G.dsk" "ubuntu-maverick.oz.cfg"

ubuntu-maverick320:	ubuntu-maverick320-upload

##### NATTY 60G
ubuntu-natty60-upload:	ubuntu-natty60-build
	../push.sh put publish/ubuntu-natty_x86_64_60G.qcow2 "RCB OPS" ubuntu-natty_x86_64_60G.qcow2

ubuntu-natty60-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-natty60 "ubuntu-natty_x86_64_60G.qcow2" "ubuntu-natty_x86_64_60G.dsk" "ubuntu-natty.oz.cfg"

ubuntu-natty60:	ubuntu-natty60-upload

##### NATTY 80G
ubuntu-natty80-upload:	ubuntu-natty80-build
	../push.sh put publish/ubuntu-natty_x86_64_80G.qcow2 "RCB OPS" ubuntu-natty_x86_64_80G.qcow2

ubuntu-natty80-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-natty80 "ubuntu-natty_x86_64_80G.qcow2" "ubuntu-natty_x86_64_80G.dsk" "ubuntu-natty.oz.cfg"

ubuntu-natty80:	ubuntu-natty80-upload

##### NATTY 1200G
ubuntu-natty120-upload:	ubuntu-natty120-build
	../push.sh put publish/ubuntu-natty_x86_64_120G.qcow2 "RCB OPS" ubuntu-natty_x86_64_120G.qcow2

ubuntu-natty120-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-natty120 "ubuntu-natty_x86_64_120G.qcow2" "ubuntu-natty_x86_64_120G.dsk" "ubuntu-natty.oz.cfg"

ubuntu-natty120:	ubuntu-natty120-upload

##### NATTY 160G
ubuntu-natty160-upload:	ubuntu-natty160-build
	../push.sh put publish/ubuntu-natty_x86_64_160G.qcow2 "RCB OPS" ubuntu-natty_x86_64_160G.qcow2

ubuntu-natty160-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-natty160 "ubuntu-natty_x86_64_160G.qcow2" "ubuntu-natty_x86_64_160G.dsk" "ubuntu-natty.oz.cfg"

ubuntu-natty160:	ubuntu-natty160-upload

##### NATTY 320G
ubuntu-natty320-upload:	ubuntu-natty320-build
	../push.sh put publish/ubuntu-natty_x86_64_320G.qcow2 "RCB OPS" ubuntu-natty_x86_64_320G.qcow2

ubuntu-natty320-build:
	OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh ubuntu-natty320 "ubuntu-natty_x86_64_320G.qcow2" "ubuntu-natty_x86_64_320G.dsk" "ubuntu-natty.oz.cfg"

ubuntu-natty320:	ubuntu-natty320-upload
