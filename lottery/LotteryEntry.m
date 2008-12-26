//
//  LotteryEntry.m
//  lottery
//
//  Created by Martin Maciaszek on 26.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LotteryEntry.h"


@implementation LotteryEntry
- (void)setEntryDate:(NSCalendarDate *)date
{
	[date retain];
	[entryDate release];
	entryDate = date;
}

- (NSCalendarDate *)entryDate
{
	return entryDate;
}

- (int)firstNumber
{
	return firstNumber;
}

- (int)secondNumber
{
	return secondNumber;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ = %d and %d",
			[[self entryDate] descriptionWithCalendarFormat:@"%Y-%m-%d"],
			  [self firstNumber], [self secondNumber]];
}

- (id)initWithEntryDate:(NSCalendarDate *)theDate
{
	if (![super init])
		return nil;
	
	entryDate = [theDate retain];
	firstNumber = random() % 100 + 1;
	secondNumber = random() % 100 + 1;
	return self;
}

- (id)init
{
	return [self initWithEntryDate:[NSCalendarDate calendarDate]];
}
@end
