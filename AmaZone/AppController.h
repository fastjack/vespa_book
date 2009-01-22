//
//  AppController.h
//  AmaZone
//
//  Created by Martin Maciaszek on 22.01.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSProgressIndicator *progress;
	IBOutlet NSTextField *searchField;
	IBOutlet NSTableView *tableView;
	NSXMLDocument *doc;
	NSArray *itemNodes;
}
- (IBAction)fetchBooks:(id)sender;
@end
