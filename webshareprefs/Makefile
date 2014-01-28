ARCHS = armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = WebSharePrefs
WebSharePrefs_FILES = WebSharePrefs.mm
WebSharePrefs_INSTALL_PATH = /Library/PreferenceBundles
WebSharePrefs_FRAMEWORKS = UIKit MessageUI
WebSharePrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/WebSharePrefs.plist$(ECHO_END)
