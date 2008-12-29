//
//  Person.m
//  RaiseMan
//
//  Created by Martin Maciaszek on 29.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Person.h"


@implementation Person
- (id)init
{
	[super init];
	expectedRaise = 5.0;
	personName = @"New Person";
	return self;
}

- (void)dealloc
{
	[personName release];
	[super dealloc];
}

@synthesize personName;
@synthesize expectedRaise;
@end
