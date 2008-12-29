//
//  AppController.h
//  KVCFun
//
//  Created by Martin Maciaszek on 29.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	int fido;
}
- (int)fido;
- (void)setFido:(int)x;
@end
