//
//  StretchView.h
//  ImageFun
//
//  Created by Martin Maciaszek on 03.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface StretchView : NSView {
	NSBezierPath *path;
	NSImage *image;
	float opacity;
}
- (NSPoint)randomPoint;
- (void)setImage:(NSImage *)newImage;
@end
