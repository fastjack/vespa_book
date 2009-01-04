//
//  DrawingView.h
//  MiniIllustrator
//
//  Created by Martin Maciaszek on 04.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Shape;
@class MyDocument;

@interface DrawingView : NSView {
	NSPoint downPoint, currentPoint;
	Shape *currentShape;
	IBOutlet MyDocument *currentDocument;
}
- (NSRect)currentRect;
@end
