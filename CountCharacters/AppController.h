//
//  AppController.h
//  CountCharacters
//
//  Created by Martin Maciaszek on 27.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField *textField;
	IBOutlet NSTextField *label;
}
- (IBAction)countWords:(id)sender;
@end
