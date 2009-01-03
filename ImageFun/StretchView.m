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
	NSPoint c1, c2;
	for (i = 0; i < 15; i++) {
		p = [self randomPoint];
		c1 = [self randomPoint]; // Control point 1 for bezier curve
		c2 = [self randomPoint];
		[path curveToPoint:p controlPoint1:c1 controlPoint2:c2];
	}
	[path closePath];
	opacity = 1.0;
    return self;
}

- (void)dealloc
{
	[path release];
	[image release];
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
	if (image) {
		NSRect imageRect;
		imageRect.origin = NSZeroPoint;
		imageRect.size = [image size];
		NSRect drawingRect = imageRect;
		[image drawInRect:drawingRect
				 fromRect:imageRect 
				operation:NSCompositeSourceOver
				 fraction:opacity];
	}
}

#pragma mark Events

- (void)mouseDown:(NSEvent *)event
{
	NSLog(@"mouseDown: %d", [event clickCount]);
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	NSLog(@"mouseDragged: %@", NSStringFromPoint(p));
}

- (void)mouseUp:(NSEvent *)event
{
	NSLog(@"mouseUp:");
}

#pragma mark Accessors

- (void)setImage:(NSImage *)newImage
{
	[newImage retain];
	[image release];
	image = newImage;
	[self setNeedsDisplay:YES];
}

- (float)opacity
{
	return opacity;
}

- (void)setOpacity:(float)x
{
	opacity = x;
	[self setNeedsDisplay:YES];
}
@end
