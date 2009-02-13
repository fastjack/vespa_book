//
//  Polynomial.h
//  Polynomials
//
//  Created by Martin Maciaszek on 13.02.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Polynomial : NSObject {
	__strong CGFloat * terms;
	int termCount;
	__strong CGColorRef color;
}
- (float)valueAt:(float)x;
- (void)drawInRect:(CGRect)b
		 inContext:(CGContextRef)ctx;
- (CGColorRef)color;
@end
