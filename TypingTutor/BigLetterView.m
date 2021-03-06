//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Martin Maciaszek on 09.01.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BigLetterView.h"
#import "FirstLetter.h"


@implementation BigLetterView

- (id)initWithFrame:(NSRect)rect {
	if (![super initWithFrame:rect])
		return nil;
	
	NSLog(@"initializing view");
	[self prepareAttributes];
	bgColor = [[NSColor yellowColor] retain];
	string = @"";
	[self registerForDraggedTypes:[NSArray arrayWithObject:NSStringPboardType]];
    return self;
}

- (void)dealloc
{
	[bgColor release];
	[string release];
	[attributes release];
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
	[self setNeedsDisplay:YES];
}

- (NSString *)string
{
	return string;
}

- (void)drawRect:(NSRect)rect {
    NSRect bounds = [self bounds];
	// Draw gradient background if highlighted
	if (highlighted) {
		NSGradient *gr;
		gr = [[NSGradient alloc] initWithStartingColor:[NSColor whiteColor]
										   endingColor:bgColor];
		[gr drawInRect:bounds relativeCenterPosition:NSZeroPoint];
		[gr release];
	} else {
		[bgColor set];
		[NSBezierPath fillRect:bounds];
	}
	
	[NSBezierPath fillRect:bounds];
	[self drawStringCenteredIn:bounds];
	
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

- (void)prepareAttributes
{
	attributes = [[NSMutableDictionary alloc] init];
	NSShadow *shadow;
	NSSize shadowOffset;
	shadow = [[NSShadow alloc] init];
	shadowOffset.width = 5.0;
	shadowOffset.height = -5.0;
	[shadow setShadowOffset:shadowOffset];
	[shadow setShadowBlurRadius:4.0];
	[shadow setShadowColor:[NSColor grayColor]];
	
	NSFontManager *fontManager = [NSFontManager sharedFontManager];
	NSFont *font = [NSFont fontWithName:@"Helvetica" size: 75];
	NSFontTraitMask fontTrait = 0;
	
	if ([bold state])
		fontTrait |= NSBoldFontMask;
	if ([italic state])
		fontTrait |= NSItalicFontMask;
	if (fontTrait != 0) {
		font = [fontManager convertFont:font toHaveTrait:fontTrait];
	}
	
	[attributes setObject:font forKey:NSFontAttributeName];
	[attributes setObject:[NSColor redColor] forKey:NSForegroundColorAttributeName];
	[attributes setObject:shadow forKey:NSShadowAttributeName];
}

- (void)drawStringCenteredIn:(NSRect)r
{
	NSSize strSize = [string sizeWithAttributes:attributes];
	NSPoint strOrigin;
	strOrigin.x = r.origin.x + (r.size.width - strSize.width)/2;
	strOrigin.y = r.origin.y + (r.size.height - strSize.height)/2;
	[self prepareAttributes];
	[string drawAtPoint:strOrigin withAttributes:attributes];
}

- (IBAction)savePDF:(id)sender
{
	NSSavePanel *panel = [NSSavePanel savePanel];
	[panel setRequiredFileType:@"pdf"];
	[panel beginSheetForDirectory:nil
							 file:nil
				   modalForWindow:[self window]
					modalDelegate:self
				   didEndSelector:@selector(didEnd:returnCode:contextInfo:)
					  contextInfo:NULL];
}

- (void)didEnd:(NSSavePanel *)sheet
	returnCode:(int)code
   contextInfo:(void *)contextInfo
{
	if (code != NSOKButton)
		return;
	
	NSRect r = [self bounds];
	NSData *data = [self dataWithPDFInsideRect:r];
	NSString *path = [sheet filename];
	NSError *error;
	BOOL successful = [data writeToFile:path
								options:0
								  error:&error];
	if (!successful) {
		NSAlert *a = [NSAlert alertWithError:error];
		[a runModal];
	}
}

- (void)writeToPasteboard:(NSPasteboard *)pb
{
	// Declare types
	[pb declareTypes:[NSArray arrayWithObjects:NSStringPboardType, NSPDFPboardType, nil] owner:self];
	
	// Copy data to the pasteboard
	[pb setString:string forType:NSStringPboardType];
	[pb setData:[self dataWithPDFInsideRect:[self bounds]] forType:NSPDFPboardType];
}

- (BOOL)readFromPasteboard:(NSPasteboard *)pb
{
	// Is there a string on the pasteboard?
	NSArray *types = [pb types];
	if ([types containsObject:NSStringPboardType]) {
		// Read the string from the pasteboard
		NSString *value = [pb stringForType:NSStringPboardType];
		
		[self setString:[value BNR_firstLetter]];
		return YES;
	}
	return NO;
}

- (IBAction)cut:(id)sender
{
	[self copy:sender];
	[self setString:@""];
}

- (IBAction)copy:(id)sender
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	[self writeToPasteboard:pb];
}

- (IBAction)paste:(id)sender
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	if (![self readFromPasteboard:pb]) {
		NSBeep();
	}
}

- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal
{
	return NSDragOperationCopy | NSDragOperationDelete;
}

- (void)mouseDown:(NSEvent *)event
{
	[event retain];
	[mouseDownEvent release];
	mouseDownEvent = event;
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint down = [mouseDownEvent locationInWindow];
	NSPoint drag = [event locationInWindow];
	float distance = hypot(down.x - drag.x, down.y - drag.y);
	if (distance < 3) {
		return;
	}
	
	// Is the string of zero length?
	if ([string length] == 0) {
		return;
	}
	
	// Get the size of the string
	NSSize s = [string sizeWithAttributes:attributes];
	
	// Create the image that will be dragged
	NSImage *anImage = [[NSImage alloc] initWithSize:s];
	
	// Create a rect in wich you will draw the letter
	// in the image
	NSRect imageBounds;
	imageBounds.origin = NSZeroPoint;
	imageBounds.size = s;
	
	// Draw the letter on the image
	[anImage lockFocus];
	[self drawStringCenteredIn:imageBounds];
	[anImage unlockFocus];
	
	// Get the location of the mouseDown event
	NSPoint p = [self convertPoint:down fromView:nil];
	
	// Drag from the center of the image
	p.x = p.x - s.width/2;
	p.y = p.y - s.height/2;
	
	// Get the pasteboard
	NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSDragPboard];
	
	// Put the string on the pasteboard
	[self writeToPasteboard:pb];
	
	// Start the drag
	[self dragImage:anImage
				 at:p
			 offset:NSMakeSize(0,0)
			  event:mouseDownEvent
		 pasteboard:pb
			 source:self
		  slideBack:YES];
	[anImage release];
}

- (void)draggedImage:(NSImage *)image
			 endedAt:(NSPoint)screenPoint
		   operation:(NSDragOperation)operation
{
	if (operation == NSDragOperationDelete) {
		[self setString:@""];
	}
}

#pragma mark Dragging Destination

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	NSLog(@"draggingEntered:");
	if ([sender draggingSource] == self) {
		return NSDragOperationNone;
	}
	
	highlighted = YES;
	[self setNeedsDisplay:YES];
	return NSDragOperationCopy;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
	NSLog(@"draggingExited:");
	highlighted = NO;
	[self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
	return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	NSPasteboard *pb = [sender draggingPasteboard];
	if (![self readFromPasteboard:pb]) {
		NSLog(@"Error: Could not read from dragging pasteboard");
		return NO;
	}
	return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
	NSLog(@"concludeDragOperation:");
	highlighted = NO;
	[self setNeedsDisplay:YES];
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
	NSDragOperation op = [sender draggingSourceOperationMask];
	NSLog(@"operation mask = %d", op);
	if ([sender draggingSource] == self) {
		return NSDragOperationNone;
	}
	return NSDragOperationCopy;
}
@end
