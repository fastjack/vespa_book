//
//  Shape.h
//  MiniIllustrator
//
//  Created by Martin Maciaszek on 04.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// The shape is currently only an oval.
@interface Shape : NSObject <NSCoding> {
	NSRect bounds;			// the shape's bounds
}

@property(readwrite,assign) NSRect bounds;

// Tell the shape to draw itself
- (NSBezierPath *)drawShape;

// custom initializer with bounds
- (id)initWithBounds:(NSRect)bounds;

// methods for saving and loading
- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;
@end
