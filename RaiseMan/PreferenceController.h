//
//  PreferenceController.h
//  RaiseMan
//
//  Created by Martin Maciaszek on 02.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const BNRTableBgColorKey;
extern NSString * const BNREmptyDocKey;

@interface PreferenceController : NSWindowController {
	IBOutlet NSColorWell *colorWell;
	IBOutlet NSButton *checkbox;
}
- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;
- (NSColor *)tableBgColor;
- (BOOL)emptyDoc;
- (IBAction)resetPreferences:(id)sender;
@end
