//
//  AppController.h
//  ToDo
//
//  Created by Martin Maciaszek on 28.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField *textField;
	IBOutlet NSTableView *tableView;
	NSMutableArray *todoList;
}
- (IBAction)addTask:(id)sender;
@end
