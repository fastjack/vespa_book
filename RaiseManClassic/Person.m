//
//  Person.m
//  RaiseManClassic
//
//  Created by Martin Maciaszek on 30.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Person.h"

// Pretty much the same model as with bindings

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

- (void)setNilValueForKey:(NSString *)key
{
	if ([key isEqual:@"expectedRaise"]) {
		[self setExpectedRaise:0.0];
	} else {
		[super setNilValueForKey:key];
	}
}

@synthesize personName;
@synthesize expectedRaise;
@end
