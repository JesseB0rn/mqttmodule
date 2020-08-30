THEOS = /var/theos											#Theos directory
ARCHS = arm64 arm64e										#A11+ support
TARGET = iphone:clang::11.0									#min ios11, latest sdk

#seems to cause problems, only use for release builds
#PACKAGE_VERSION = 1.0.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MQTTModule
MQTTModule_CFLAGS = -fobjc-arc

SUBPROJECTS += CCModule Tweak mqttmoduleprefs mqttmoduled	#load all subprojects
include $(THEOS_MAKE_PATH)/aggregate.mk
