export ARCHS = armv7
export TARGET = iphone:latest:4.3

include theos/makefiles/common.mk

TWEAK_NAME = MMSComposer
MMSComposer_FILES = Tweak.xm
MMSComposer_PRIVATE_FRAMEWORKS = ChatKit IMFoundation

include $(THEOS_MAKE_PATH)/tweak.mk
