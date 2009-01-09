//
//  Shape.m
//  MiniIllustrator
//
//  Created by Martin Maciaszek on 04.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import "Shape.h"


@implementation Shape
@synthesize bounds;

- (id)initWithBounds:(NSRect)newBounds
{
	self = [super init];
	if (self) {
		[self setBounds:newBounds];
	}
	return self;
}

- (NSBezierPath *)drawShape
{
	return [NSBezierPath bezierPathWithOvalInRect:[self bounds]];
}

- (id)initWithCoder:(NSCoder *)coder
{
	[super init];
	[self setBounds:[coder decodeRectForKey:@"bounds"]];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeRect:[self bounds] forKey:@"bounds"];
}
@end
