//
//  MyDocument.m
//  Departments
//
//  Created by Martin Maciaszek on 29.01.09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import "MyDocument.h"
#import "DepartmentViewController.h"
#import "EmployeeViewController.h"

@implementation MyDocument

- (id)init 
{
	[super init];
	viewControllers = [[NSMutableArray alloc] init];
	
	ManagingViewController *vc;
	vc = [[DepartmentViewController alloc] init];
	[vc setManagedObjectContext:[self managedObjectContext]];
	[viewControllers addObject:vc];
	[vc release];
	
	vc = [[EmployeeViewController alloc] init];
	[vc setManagedObjectContext:[self managedObjectContext]];
	[viewControllers addObject:vc];
	[vc release];
	
	return self;
}

- (void)dealloc
{
	[viewControllers release];
	[super dealloc];
}

- (void)displayViewController:(ManagingViewController *)vc
{
	// Try to end editin
	NSWindow *w = [box window];
	BOOL ended = [w makeFirstResponder:w];
	if (!ended) {
		NSBeep();
		return;
	}
	// Put the view in the box
	NSView *v = [vc view];
	[box setContentView:v];
}

- (NSString *)windowNibName 
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
    NSMenu *menu = [popUp menu];
	int i, itemCount;
	itemCount = [viewControllers count];
	
	for (i = 0; i < itemCount; i++) {
		NSViewController *vc = [viewControllers objectAtIndex:i];
		NSMenuItem *mi = [[NSMenuItem alloc] initWithTitle:[vc title]
													action:@selector(changeViewController:)
											 keyEquivalent:@""];
		[mi setTag:i];
		[menu addItem:mi];
		[mi release];
	}
	
	// Initially show the first controller
	[self displayViewController:[viewControllers objectAtIndex:0]];
	[popUp selectItemAtIndex:0];
}

- (IBAction)changeViewController:(id)sender
{
	int i = [sender tag];
	ManagingViewController *vc = [viewControllers objectAtIndex:i];
	[self displayViewController:vc];
}

@end
