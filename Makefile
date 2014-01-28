ARCHS = armv7 arm64

TWEAK_NAME = WebShare
WebShare_FRAMEWORKS = Foundation UIKit
WebShare_PRIVATE_FRAMEWORKS = WebCore
WebShare_LIBRARIES = substrate
WebShare_FILES = Tweak.xm

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += webshareprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
