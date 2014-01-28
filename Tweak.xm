#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebCore/DOMHTMLImageElement.h>
#import "substrate.h"

static NSDictionary *settings;
static NSURL *imageURL;
static BOOL enabled;

%hook UIWebDocumentView

- (SEL)_actionForLongPressOnElement:(id)element
{
	if (enabled && [[element _realNode] isKindOfClass:%c(DOMHTMLImageElement)])
	{
		DOMHTMLImageElement *elementNode = (DOMHTMLImageElement *)[element _realNode];
		imageURL = elementNode.absoluteImageURL;
	}
	return %orig;
}

- (void)_showImageSheet
{
	if (enabled) {
		NSArray *shareArray = [NSArray arrayWithObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]]];
		UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:shareArray applicationActivities:nil];
		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:activityController animated:YES completion:nil];
		[activityController release];
	} else {
		%orig;
	}
}

%end

static void loadSettings(void)
{
	[settings release];
	settings = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.michaelpoole.webshare.plist"];
	enabled = [settings objectForKey:@"Enabled"] != nil ? [[settings objectForKey:@"Enabled"] boolValue] : YES;
}

static void settingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info)
{
	loadSettings();
}

%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		loadSettings();
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &settingsChanged, CFSTR("com.michaelpoole.webshare.settingsChanged"), NULL, 0);
	[pool drain];
}