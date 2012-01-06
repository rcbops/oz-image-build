CENTOS = centos60_x86_64
FEDORA = fedora15_x86_64 fedora16_x86_64
RHEL = rhel56_x86_64 rhel61_x86_64
LUCID = ubuntu-lucid_x86_64_120G ubuntu-lucid_x86_64_160G \
		ubuntu-lucid_x86_64_320G ubuntu-lucid_x86_64_60G \
		ubuntu-lucid_x86_64_80G
MAVERICK = ubuntu-maverick_x86_64_120G ubuntu-maverick_x86_64_160G \
		ubuntu-maverick_x86_64_320G ubuntu-maverick_x86_64_60G \
		ubuntu-maverick_x86_64_80G
NATTY = ubuntu-natty_x86_64_120G ubuntu-natty_x86_64_160G \
		ubuntu-natty_x86_64_320G ubuntu-natty_x86_64_60G \
		ubuntu-natty_x86_64_80G
ONEIRIC = ubuntu-oneiric_x86_64_120G ubuntu-oneiric_x86_64_160G \
		ubuntu-oneiric_x86_64_320G ubuntu-oneiric_x86_64_60G \
		ubuntu-oneiric_x86_64_80G
TARGETS = $(FEDORA) $(CENTOS) $(RHEL) $(LUCID) $(MAVERICK) $(NATTY)
OZ_DEBUG=3

.SUFFIXES = .tdl

all:		$(TARGETS)
fedora:		$(FEDORA)
centos:		$(CENTOS)
rhel:		$(RHEL)
lucid:		$(LUCID)
maverick:	$(MAVERICK)
natty:		$(NATTY)

centos-upload-all:	$(CENTOS)
	@$(foreach var,$(CENTOS),make publish/$(var)-upload;)

centos-clean-all:	$(CENTOS)
	@$(foreach var,$(CENTOS),make $(var)-clean;)

fedora-upload-all:	$(FEDORA)
	@$(foreach var,$(FEDORA),make publish/$(var)-upload;)

fedora-clean-all:	$(FEDORA)
	@$(foreach var,$(FEDORA),make $(var)-clean;)

rhel-upload-all:	$(RHEL)
	@$(foreach var,$(RHEL),make publish/$(var)-upload;)

rhel-clean-all:	$(RHEL)
	@$(foreach var,$(RHEL),make $(var)-clean;)

lucid-upload-all:	$(LUCID)
	@$(foreach var,$(LUCID),make publish/$(var)-upload;)

lucid-clean-all:	$(LUCID)
	@$(foreach var,$(LUCID),make $(var)-clean;)

maverick-upload-all:	$(MAVERICK)
	@$(foreach var,$(MAVERICK),make publish/$(var)-upload;)

maverick-clean-all:	$(MAVERICK)
	@$(foreach var,$(MAVERICK),make $(var)-clean;)

natty-upload-all:	$(NATTY)
	@$(foreach var,$(NATTY),make publish/$(var)-upload;)

maverick-clean-all:	$(NATTY)
	@$(foreach var,$(NATTY),make $(var)-clean;)

$(TARGETS):
	@make publish/$@.qcow2

templates/%.tdl:

publish/%.qcow2: templates/%.tdl
	@echo "-- Building $*"
	@OZ_DEBUG=$(OZ_DEBUG) ./build-helper.sh $* "$*.qcow2" "$*.dsk"

%-upload:
	@make publish/$*-upload

publish/%-upload: publish/%.qcow2
	@echo "-- UPLOAD $*"
	@./push.sh put publish/$*.qcow2 "RCB OPS" $*.qcow2
	@touch $@

upload:	$(TARGETS)
	@$(foreach var,$(TARGETS),make publish/$(var)-upload;)

%-clean:
	@rm -f publish/$*.qcow2
	@rm -f publish/$*.upload

clean:
	rm -f publish/*
