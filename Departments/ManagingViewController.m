//
//  ManagingViewController.m
//  Departments
//
//  Created by Martin Maciaszek on 29.01.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ManagingViewController.h"


@implementation ManagingViewController
@synthesize managedObjectContext;

- (void)dealloc
{
	[managedObjectContext release];
	[super dealloc];
}
@end
