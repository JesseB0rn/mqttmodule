include $(THEOS)/makefiles/common.mk
ARCHS = arm64 arm64e
BUNDLE_NAME = mqttmoduleprefs

mqttmoduleprefs_FILES = jmpRootListController.m
mqttmoduleprefs_INSTALL_PATH = /Library/PreferenceBundles
mqttmoduleprefs_FRAMEWORKS = UIKit
mqttmoduleprefs_PRIVATE_FRAMEWORKS = Preferences
mqttmoduleprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/mqttmoduleprefs.plist$(ECHO_END)
