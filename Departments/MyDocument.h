//
//  MyDocument.h
//  Departments
//
//  Created by Martin Maciaszek on 29.01.09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagingViewController.h"

@interface MyDocument : NSPersistentDocument {
	IBOutlet NSBox *box;
	IBOutlet NSPopUpButton *popUp;
	NSMutableArray *viewControllers;
}
- (IBAction)changeViewController:(id)sender;
- (void)displayViewController:(ManagingViewController *)vc;
@end
