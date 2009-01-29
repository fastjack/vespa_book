//
//  EmployeeViewController.m
//  Departments
//
//  Created by Martin Maciaszek on 29.01.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EmployeeViewController.h"


@implementation EmployeeViewController
- (id)init
{
	if (![super initWithNibName:@"EmployeeView"
						 bundle:nil]) {
		return nil;
	}
	[self setTitle:@"Employees"];
	return self;
}
@end
