//
//  PeopleView.h
//  RaiseMan
//
//  Created by Martin Maciaszek on 22.01.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PeopleView : NSView {
	NSArray *people;
	NSMutableDictionary *attributes;
	float lineHeight;
	NSRect pageRect;
	int linesPerPage;
	int currentPage;
}
- (id)initWithPeople:(NSArray *)array;
@end
