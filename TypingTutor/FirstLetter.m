//
//  FirstLetter.m
//  TypingTutor
//
//  Created by Martin Maciaszek on 09.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import "FirstLetter.h"


@implementation NSString (FirstLetter)

- (NSString *)BNR_firstLetter
{
	if ([self length] < 2) {
		return self;
	}
	NSRange r;
	r.location = 0;
	r.length = 1;
	return [self substringWithRange:r];
}

@end
