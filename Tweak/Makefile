INSTALL_TARGET_PROCESSES = SpringBoard

ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Tweak

Tweak_FILES = Tweak.xm
Tweak_CFLAGS = -fobjc-arc

Tweak_FRAMEWORKS = UIKit
Tweak_PRIVATE_FRAMEWORKS = ControlCenterUIKit

include $(THEOS_MAKE_PATH)/tweak.mk
