//
//  AppController.m
//  KVCFun
//
//  Created by Martin Maciaszek on 29.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController
- (id)init
{
	[super init];
	[self setValue:[NSNumber numberWithInt:5]
			forKey:@"fido"];
	NSNumber *n = [self valueForKey:@"fido"];
	NSLog(@"fido = %@", n);
	return self;
}

- (int)fido
{
	NSLog(@"-fido is returning %d", fido);
	return fido;
}

- (void)setFido:(int)x
{
	NSLog(@"-setFido: is called with %d", x);
	fido = x;
}

- (IBAction)incrementFido:(id)sender
{
	[self willChangeValueForKey:@"fido"];
	fido++;
	NSLog(@"fido is now %d", fido);
	[self didChangeValueForKey:@"fido"];
}
@end
