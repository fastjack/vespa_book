//
//  MyDocument.h
//  RaiseManClassic
//
//  Created by Martin Maciaszek on 30.12.08.
//  Copyright __MyCompanyName__ 2008 . All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
	NSMutableArray *employees;
	IBOutlet NSTableView *tableView;
}
//- (void)setEmployees:(NSMutableArray *)a;
- (IBAction)createEmployee:(id)sender;
- (IBAction)removeSelectedEmployees:(id)sender;
@end
