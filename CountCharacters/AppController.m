//
//  AppController.m
//  CountCharacters
//
//  Created by Martin Maciaszek on 27.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController
- (id)init
{
	[super init];
	
	// Do nothing, just spit out a log message
	NSLog(@"init");
	
	return self;
}

- (IBAction)countWords:(id)sender
{
	NSString *string = [[textField stringValue] retain];
	[label setStringValue:[NSString stringWithFormat:@"'%@' has %d characters",string,[string length]]];
	[string release];
}
@end
