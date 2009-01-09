//
//  BigLetterView.h
//  TypingTutor
//
//  Created by Martin Maciaszek on 09.01.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BigLetterView : NSView {
	NSColor *bgColor;
	NSString *string;
}
@property (retain, readwrite) NSColor *bgColor;
@property (copy, readwrite) NSString *string;
@end
