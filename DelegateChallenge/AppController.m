//
//  AppController.m
//  DelegateChallenge
//
//  Created by Martin Maciaszek on 28.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController
- (NSSize)windowWillResize:(NSWindow *)sender
					toSize:(NSSize)frameSize;
{
	frameSize.width = frameSize.height *2 ;
	return frameSize;
}
@end
