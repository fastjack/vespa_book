//
//  AppController.m
//  KVCFun
//
//  Created by Martin Maciaszek on 29.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController
@synthesize fido;

- (id)init
{
	[super init];
	[self setValue:[NSNumber numberWithInt:5]
			forKey:@"fido"];
	NSNumber *n = [self valueForKey:@"fido"];
	NSLog(@"fido = %@", n);
	return self;
}

- (IBAction)incrementFido:(id)sender
{
	[self setFido:[self fido] + 1];
}
@end
