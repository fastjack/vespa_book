// 
//  Employee.m
//  Departments
//
//  Created by Martin Maciaszek on 01.02.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import "Employee.h"


@implementation Employee 

@dynamic firstName;
@dynamic lastName;
@dynamic department;

- (NSString *)fullName
{
	NSString *first = [self firstName];
	NSString *last = [self lastName];
	if (!first)
		return last;
	if (!last)
		return first;
	
	return [NSString stringWithFormat:@"%@ %@", first, last];
}

+ (NSSet *)keyPathsForValuesAffectingFullName
{
	return [NSSet setWithObjects:@"firstName", @"lastName", nil];
}

@end
