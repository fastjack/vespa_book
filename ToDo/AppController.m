//
//  AppController.m
//  ToDo
//
//  Created by Martin Maciaszek on 28.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController
- (id)init
{
	[super init];
	// Initialize the empty ToDo list
	todoList = [[[NSMutableArray alloc] init] retain];
	return self;
}

// Lets see what delegate methods we get asked for
- (BOOL)respondsToSelector:(SEL)aSelector
{
	NSString *methodName = NSStringFromSelector(aSelector);
	NSLog(@"respondsToSelector:%@", methodName);
	return [super respondsToSelector:aSelector];
}

- (IBAction)addTask:(id)sender
{
	NSString *task = [textField stringValue];
	if ([task length] == 0) {
		NSLog(@"cowardly refusig to add an empty task");
		return;
	}
	[todoList addObject:task];
	[tableView reloadData];
}

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	return [todoList count];
}

- (id)tableView:(NSTableView *)tv
		objectValueForTableColumn:(NSTableColumn *)tableColumn
							  row:(int)row
{
	return [todoList objectAtIndex:row];
}

- (void)tableView:(NSTableView *)tv setObjectValue:(id)newValue
				forTableColumn:(NSTableColumn *)tableColumn
						   row:(int)row
{
	[todoList replaceObjectAtIndex:row withObject:newValue];
	[tableView reloadData];
}
@end
