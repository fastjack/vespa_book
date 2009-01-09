//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Martin Maciaszek on 09.01.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BigLetterView.h"


@implementation BigLetterView

- (id)initWithFrame:(NSRect)rect {
	if (![super initWithFrame:rect])
		return nil;
	
	NSLog(@"initializing view");
	bgColor = [[NSColor yellowColor] retain];
	string = @" ";
    return self;
}

- (void)dealloc
{
	[bgColor release];
	[string release];
	[super dealloc];
}

# pragma mark Accessors

- (void)setBgColor:(NSColor *)c
{
	[c retain];
	[bgColor release];
	bgColor = c;
	[self setNeedsDisplay:YES];
}

- (NSColor *)bgColor
{
	return bgColor;
}

- (void)setString:(NSString *)c
{
	c = [c copy];
	[string release];
	string = c;
	NSLog(@"The string is now %@", string);
}

- (NSString *)string
{
	return string;
}

- (void)drawRect:(NSRect)rect {
    NSRect bounds = [self bounds];
	[bgColor set];
	[NSBezierPath fillRect:bounds];
	
	// Am I the window's first responder?
	if (([[self window] firstResponder] == self) && [NSGraphicsContext currentContextDrawingToScreen]) {
		[NSGraphicsContext saveGraphicsState];
		NSSetFocusRingStyle(NSFocusRingOnly);
		[NSBezierPath fillRect:bounds];
		[NSGraphicsContext restoreGraphicsState];
	}
}

- (BOOL)isOpaque
{
	return YES;
}

- (BOOL)acceptsFirstResponder
{
	NSLog(@"Accepting");
	return YES;
}

- (BOOL)resignFirstResponder
{
	NSLog(@"Resigning");
	[self setKeyboardFocusRingNeedsDisplayInRect:[self bounds]];
	return YES;
}

- (BOOL)becomeFirstResponder
{
	NSLog(@"Becoming");
	[self setNeedsDisplay:YES];
	return YES;
}

- (void)keyDown:(NSEvent *)event
{
	[self interpretKeyEvents:[NSArray arrayWithObject:event]];
}

- (void)insertText:(NSString *)input
{
	// Set string to be what the user typed
	[self setString:input];
}

- (void)insertTab:(id)sender
{
	[[self window] selectKeyViewFollowingView:self];
}

- (void)insertBacktab:(id)sender
{
	[[self window] selectKeyViewPrecedingView:self];
}

- (void)deleteBackward:(id)sender
{
	[self setString:@" "];
}

@end
