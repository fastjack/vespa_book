//
//  CarArrayController.m
//  CarLot
//
//  Created by Martin Maciaszek on 02.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import "CarArrayController.h"


@implementation CarArrayController

- (id)newObject
{
	id newObj = [super newObject];
	NSDate *now = [NSDate date];
	[newObj setValue:now forKeyPath:@"datePurchased"];
	return newObj;
}

@end
