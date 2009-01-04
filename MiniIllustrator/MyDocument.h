//
//  MyDocument.h
//  MiniIllustrator
//
//  Created by Martin Maciaszek on 04.01.09.
//  Copyright Martin Maciaszek 2009 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class DrawingView;
@class Shape;

@interface MyDocument : NSDocument
{
	IBOutlet DrawingView *drawingView;
	NSMutableArray *shapes;
	NSUndoManager *undo;
}
//- (NSMutableArray *)shapes;
//- (void)setShapes:(NSMutableArray *)shapes;
@property(readwrite, copy) NSMutableArray *shapes;

- (void)addShape:(Shape *)shape;
- (void)removeLastShape;
@end
