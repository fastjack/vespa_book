//
//  AppController.m
//  RaiseMan
//
//  Created by Martin Maciaszek on 02.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

- (IBAction)showPreferencePanel:(id)sender
{
	// Is preferenceController nil?
	if (!preferenceController) {
		preferenceController = [[PreferenceController alloc] init];
	}
	NSLog(@"showing %@", preferenceController);
	[preferenceController showWindow:self];
}

- (IBAction)showAboutPanel:(id)sender
{
	BOOL success = [NSBundle loadNibNamed:@"About" owner:self];
	if (!success) {
		NSLog(@"Loading about panel failed");
	}
}

+ (void)initialize
{
	// Create a dictionary
	NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
	
	// Archive the color object
	NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
	
	// Put the defaults in the dictionary
	[defaultValues setObject:colorAsData forKey:BNRTableBgColorKey];
	[defaultValues setObject:[NSNumber numberWithBool:YES] forKey:BNREmptyDocKey];
	
	// Register the dictionary of defaults
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	NSLog(@"registered defaults: %@", defaultValues);
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	NSLog(@"applicationShouldOpenUntitledFile:");
	return [[NSUserDefaults standardUserDefaults] boolForKey:BNREmptyDocKey];
}
@end
