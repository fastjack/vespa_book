//
//  MyDocument.h
//  RaiseMan
//
//  Created by Martin Maciaszek on 29.12.08.
//  Copyright __MyCompanyName__ 2008 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class Person;

@interface MyDocument : NSDocument
{
	NSMutableArray *employees;
}
- (void)setEmployees:(NSMutableArray *)a;
- (void)removeObjectFromEmployeesAtIndex:(int)index;
- (void)insertObject:(Person *)p inEmployeesAtIndex:(int)index;
@end
