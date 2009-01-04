//
//  MyDocument.m
//  MiniIllustrator
//
//  Created by Martin Maciaszek on 04.01.09.
//  Copyright Martin Maciaszek 2009 . All rights reserved.
//

#import "MyDocument.h"
#import "DrawingView.h"

@implementation MyDocument
@synthesize shapes;

- (void)addShape:(Shape *)shape
{
	[[undo prepareWithInvocationTarget:self] removeLastShape];
	
	if (![undo isUndoing])
		[undo setActionName:@"Create Shape"];
	
	[shapes addObject:shape];
	[drawingView setNeedsDisplay:YES];
}

- (void)removeLastShape
{
	Shape *shape = [shapes lastObject];
	[[undo prepareWithInvocationTarget:self] addShape:shape];
	
	if (![undo isUndoing])
		[undo setActionName:@"Remove Shape"];
	
	[shapes removeLastObject];
	[drawingView setNeedsDisplay:YES];
}

- (id)init
{
    self = [super init];
    if (self) {
		shapes = [[NSMutableArray alloc] init];
		undo = [self undoManager];
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	return [NSKeyedArchiver archivedDataWithRootObject:shapes];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	NSMutableArray *newShapes = nil;
	@try {
		newShapes = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	@catch (NSException *e) {
		if (outError) {
			NSDictionary *d = [NSDictionary dictionaryWithObject:@"The data is corrupted" forKey:NSLocalizedFailureReasonErrorKey];
			*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:d];
		}
		return NO;
	}
	[self setShapes:newShapes];
	return YES;
}

@end
