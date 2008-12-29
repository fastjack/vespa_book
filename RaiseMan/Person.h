//
//  Person.h
//  RaiseMan
//
//  Created by Martin Maciaszek on 29.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject {
	NSString *personName;
	float expectedRaise;
}
@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;
@end
