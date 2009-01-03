//
//  AppController.h
//  ImageFun
//
//  Created by Martin Maciaszek on 03.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class StretchView;

@interface AppController : NSObject {
	IBOutlet StretchView *stretchView;
}
- (IBAction)showOpenPanel:(id)sender;
@end
