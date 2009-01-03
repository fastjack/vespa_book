//
//  StretchView.m
//  ImageFun
//
//  Created by Martin Maciaszek on 03.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import "StretchView.h"


@implementation StretchView

- (id)initWithFrame:(NSRect)frame {
    if (![super initWithFrame:frame]) {
        return nil;
    }
	
	// Seed the random number generator
	srandom(time(NULL));
	
	// Create a path object
	path = [[NSBezierPath alloc] init];
	[path setLineWidth:3.0];
	NSPoint p = [self randomPoint];
	[path moveToPoint:p];
	int i;
	for (i = 0; i < 15; i++) {
		p = [self randomPoint];
		[path lineToPoint:p];
	}
	[path closePath];
    return self;
}

- (void)dealloc
{
	[path release];
	[super dealloc];
}

// randomPoint returns a random point inside the view
- (NSPoint)randomPoint
{
	NSPoint result;
	NSRect r = [self bounds];
	result.x = r.origin.x + random() % (int)r.size.width;
	result.y = r.origin.y + random() % (int)r.size.height;
	return result;
}

- (void)drawRect:(NSRect)rect {
    NSRect bounds = [self bounds];
	[[NSColor greenColor] set];
	[NSBezierPath fillRect:bounds];
	
	// Draw the path in white
	[[NSColor whiteColor] set];
	[path fill];
}

@end
