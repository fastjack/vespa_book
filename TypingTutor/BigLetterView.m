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
	[self prepareAttributes];
	bgColor = [[NSColor yellowColor] retain];
	string = @" ";
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
	[bgColor set];
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
		
		// Our view can handly only one letter
		if ([value length] == 1) {
			[self setString:value];
			return YES;
		}
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
@end
