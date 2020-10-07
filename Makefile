ccflags-y += -I$(src) -I$(KDIR) -I$(KDIR)/include/linux -I$(KDIR)/fs -Wno-error=implicit-int -Wno-int-conversion
obj-m := binfmt_misc.o
#binfmt_misc-y := open.o binfmt_misc.o
binfmt_misc-y := open.o
KDIR := /lib/modules/$(shell uname -r)/build
#KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build
UNAME-R := $(shell uname -r)
KERNELver := $(shell uname -r | sed 's/-.*//')
KERNEL_SRC ?= $(PWD)/linux-$(KERNELver)
all:
	#apt source linux-$(shell uname -r | sed 's/-.*//')
	#apt source linux-image-$(shell uname -r )
	apt install linux-headers-$(UNAME-R)
	apt install linux-source-$(KERNELver)
	apt source linux-source-$(KERNELver)
	cp $(KDIR)/Module.symvers $(KERNEL_SRC)/
	$(MAKE) -C $(KERNEL_SRC) oldconfig && $(MAKE) -C $(KERNEL_SRC) prepare
	#$(MAKE) -C $(KERNEL_SRC) fs/binfmt_misc.ko V=99 M=$$PWD
#	$(MAKE) -C $(KERNEL_SRC) V=99 M=fs/binfmt_misc
	$(MAKE) -C $(KERNEL_SRC) V=99 fs/binfmt_misc.ko



install:
	cp binfmt_misc.ko $(DESTDIR)/

clean:
	rm -rf deps.h *.o *.ko *.mod.c *.symvers *.order .*.cmd .tmp_versions $(KERNEL_SRC) 
dist-clean:
	rm -rf deps.h *.o *.ko *.mod.c *.symvers *.order .*.cmd .tmp_versions $(KERNEL_SRC) linux?$(KERNELver)*.orig.tar.gz linux?$(KERNELver)*.diff.gz linux?$(KERNELver)*.dsc
#	rm -rf deps.h *.o *.ko *.mod.c *.symvers *.order .*.cmd .tmp_versions

#default:
#	$(MAKE) -C $(KDIR) M=$(PWD) modules

#clean:
#	$(MAKE) -C $(KDIR) M=$(PWD) clean
