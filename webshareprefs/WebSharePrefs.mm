#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface WSPrefsController: PSListController <MFMailComposeViewControllerDelegate>
{
	MFMailComposeViewController *emailController;
}

- (void)launchDonation:(id)param;
- (void)launchTwitter:(id)param;
- (void)emailSupport:(id)param;

@end

@implementation WSPrefsController

- (id)specifiers
{
	if(_specifiers == nil)
	{
		_specifiers = [[self loadSpecifiersFromPlistName:@"WebSharePrefs" target:self] retain];
	}
	return _specifiers;
}

- (void)launchDonation:(id)param {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=E22YHLPQ4NYVE"]];
}

- (void)launchTwitter:(id)param {
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]])
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=michaelsp1991"]];
	else
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.twitter.com/MichaelSP1991"]];
}

- (void)emailSupport:(id)param {
	NSString *emailTitle = @"WebShare";
    NSString *messageBody = @"";
    NSArray *toRecipents = [NSArray arrayWithObject:@"exilediphonedevelopment@gmail.com"];
    
    emailController = [[MFMailComposeViewController alloc] init];
    emailController.mailComposeDelegate = self;
    [emailController setSubject:emailTitle];
    [emailController setMessageBody:messageBody isHTML:NO];
    [emailController setToRecipients:toRecipents];
	
    [self.rootController presentModalViewController:emailController animated:YES];
	[emailController release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self.rootController dismissModalViewControllerAnimated:YES];
}

@end