//
//  DepartmentViewController.m
//  Departments
//
//  Created by Martin Maciaszek on 29.01.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DepartmentViewController.h"


@implementation DepartmentViewController

- (id)init
{
	if (![super initWithNibName:@"DepartmentView"
						 bundle:nil]) {
		return nil;
	}
	[self setTitle:@"Departments"];
	return self;
}
@end
