//
//  DrawingView.m
//  MiniIllustrator
//
//  Created by Martin Maciaszek on 04.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import "DrawingView.h"
#import "MyDocument.h"
#import "Shape.h"

@implementation DrawingView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        currentShape = nil;
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    NSRect bounds = [self bounds];
	
	// Fill background with white
	[[NSColor whiteColor] set];
	[NSBezierPath fillRect:bounds];
	
	// draw in black
	[[NSColor blackColor] set];
	[NSBezierPath setDefaultLineWidth:3.0];
	
	NSEnumerator *e = [[currentDocument shapes] objectEnumerator];
	Shape *currentDrawingShape;
	while (currentDrawingShape = [e nextObject])
		[[currentDrawingShape drawShape] stroke];
	
	// Draw the currentShape
	if (currentShape)
		[[currentShape drawShape] stroke];
}

- (void)mouseDown:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	downPoint = [self convertPoint:p fromView:nil];
	currentPoint = downPoint;
	[self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	currentPoint = [self convertPoint:p fromView:nil];
	if (!currentShape)
		currentShape = [[Shape alloc] initWithBounds:[self currentRect]];
	else
		[currentShape setBounds:[self currentRect]];
	[self autoscroll:event];
	[self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	currentPoint = [self convertPoint:p fromView:nil];
	if (!currentShape)
		currentShape = [[Shape alloc] initWithBounds:[self currentRect]];
	else
		[currentShape setBounds:[self currentRect]];
	[currentDocument addShape:currentShape];
	[currentShape release];
	currentShape = nil;
	[self setNeedsDisplay:YES];
}

- (NSRect)currentRect
{
	float minX = MIN(downPoint.x, currentPoint.x);
	float maxX = MAX(downPoint.x, currentPoint.x);
	float minY = MIN(downPoint.y, currentPoint.y);
	float maxY = MAX(downPoint.y, currentPoint.y);
	
	return NSMakeRect(minX, minY, maxX-minX, maxY-minY);
}

- (void)dealloc
{
	[currentShape release];
	[super dealloc];
}
@end
