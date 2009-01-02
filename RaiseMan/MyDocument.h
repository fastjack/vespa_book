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
	IBOutlet NSTableView *tableView;
	IBOutlet NSArrayController *employeeController;
}
- (void)setEmployees:(NSMutableArray *)a;
- (void)removeObjectFromEmployeesAtIndex:(int)index;
- (void)insertObject:(Person *)p inEmployeesAtIndex:(int)index;
- (void)startObservingPerson:(Person *)person;
- (void)stopObservingPerson:(Person *)person;
- (IBAction)createEmployee:(id)sender;
- (IBAction)removeEmployee:(id)sender;
@end
