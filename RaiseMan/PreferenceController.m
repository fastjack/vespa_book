//
//  PreferenceController.m
//  RaiseMan
//
//  Created by Martin Maciaszek on 02.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import "PreferenceController.h"

NSString * const BNRTableBgColorKey = @"TableBackgroundColor";
NSString * const BNREmptyDocKey = @"EmptyDocumentFlag";
NSString * const BNRColorChangedNotification = @"BNRColorChanged";

@implementation PreferenceController

- (id)init
{
	if (![super initWithWindowNibName:@"Preferences"])
		return nil;
	return self;
}

- (NSColor *)tableBgColor
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSData *colorAsData = [defaults objectForKey:BNRTableBgColorKey];
	return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

- (BOOL)emptyDoc
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:BNREmptyDocKey];
}

- (void)windowDidLoad
{
	[colorWell setColor:[self tableBgColor]];
	[checkbox setState:[self emptyDoc]];
}

- (IBAction)changeBackgroundColor:(id)sender
{
	NSColor *color = [colorWell color];
	NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:colorAsData forKey:BNRTableBgColorKey];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	NSLog(@"Sending notification");
	NSDictionary *d = [NSDictionary dictionaryWithObject:color forKey:@"color"];
	[nc postNotificationName:BNRColorChangedNotification object:self userInfo:d];
}

- (IBAction)changeNewEmptyDoc:(id)sender
{
	int state = [checkbox state];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:state	forKey:BNREmptyDocKey];
}

- (IBAction)resetPreferences:(id)sender
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	// Remove the user's defaults
	[defaults removeObjectForKey:BNRTableBgColorKey];
	[defaults removeObjectForKey:BNREmptyDocKey];
	
	// Update the settings displayed in the preference panel
	[colorWell setColor:[self tableBgColor]];
	[checkbox setState:[self emptyDoc]];
}

@end
