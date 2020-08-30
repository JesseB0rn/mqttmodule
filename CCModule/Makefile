include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang::11.0
export ARCHS = arm64

BUNDLE_NAME = MQTTModule
MQTTModule_BUNDLE_EXTENSION = bundle
MQTTModule_FILES = MQTTModule.m
MQTTModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit
MQTTModule_FRAMEWORKS = UIKit
MQTTModule_INSTALL_PATH = /Library/ControlCenter/Bundles/

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk
