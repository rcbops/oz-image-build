TARGETS = f15 f16 centos60 rhel56 rhel60 ubuntu-lucid60 ubuntu-lucid80 ubuntu-lucid120 ubuntu-lucid160 ubuntu-lucid320

all:
	@echo "Usage"
	@echo "-----"
	@echo ""
	@echo "make <type>"
	@echo ""
	@$(foreach var,$(TARGETS),echo $(var);)
	@echo ""
	@echo "Set the env variable OZ_DEBUG to an integer between 1-4 for additional information"
	@echo "on the status of the build"

f15-upload:	f15
	../push.sh put publish/fedora15_x86_64.qcow2 "RCB OPS" fedora15_x86_64.qcow2

f15:
	./builder-helper.sh "fedora15_x86_64.qcow2" "fedora15_x86_64.dsk"

centos60-upload:	centos60
	../push.sh put publish/centos60_x86_64.qcow2 "RCB OPS" centos60_x86_64.qcow2

centos60:
	./build-helper.sh centos60 "centos60_x86_64.qcow2" "centos60_x86_64.dsk" "centos60.oz.cfg"

rhel56-upload:	rhel56
	../push.sh put publish/rhel56_x86_64.qcow2 "RCB OPS" rhel56_x86_64.qcow2

rhel56:
	./build-helper.sh rhel56 "rhel56_x86_64.qcow2" "rhel56_x86_64.dsk"

rhel61-upload:
	../push.sh put publish/ "RCB OPS" 

rhel61:
	./build-helper.sh rhel61 "rhel61_x86_64.qcow2" "rhel61_x86_64.dsk" "rhel61.oz.cfg"

ubuntu-lucid60-upload:
	../push.sh put publish/ubuntu-lucid_x86_64_60G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_60G.qcow2

ubuntu-lucid60:
	./build-helper.sh ubuntu-lucid60 "ubuntu-lucid_x86_64_60G.qcow2" "ubuntu-lucid_x86_64_60G.dsk" "ubuntu-lucid.oz.cfg"

ubuntu-lucid80-upload:
	../push.sh put publish/ubuntu-lucid_x86_64_80G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_80G.qcow2

ubuntu-lucid80:
	./build-helper.sh ubuntu-lucid80 "ubuntu-lucid_x86_64_80G.qcow2" "ubuntu-lucid_x86_64_80G.dsk" "ubuntu-lucid.oz.cfg"

ubuntu-lucid120-upload:
	../push.sh put publish/ubuntu-lucid_x86_64_120G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_120G.qcow2

ubuntu-lucid120:
	./build-helper.sh ubuntu-lucid120 "ubuntu-lucid_x86_64_120G.qcow2" "ubuntu-lucid_x86_64_120G.dsk" "ubuntu-lucid.oz.cfg"

ubuntu-lucid160-upload:
	../push.sh put publish/ubuntu-lucid_x86_64_160G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_160G.qcow2

ubuntu-lucid160:
	./build-helper.sh ubuntu-lucid160 "ubuntu-lucid_x86_64_160G.qcow2" "ubuntu-lucid_x86_64_160G.dsk" "ubuntu-lucid.oz.cfg"

ubuntu-lucid320-upload:
	../push.sh put publish/ubuntu-lucid_x86_64_320G.qcow2 "RCB OPS" ubuntu-lucid_x86_64_320G.qcow2

ubuntu-lucid320:
	./build-helper.sh ubuntu-lucid320 "ubuntu-lucid_x86_64_320G.qcow2" "ubuntu-lucid_x86_64_320G.dsk" "ubuntu-lucid.oz.cfg"

