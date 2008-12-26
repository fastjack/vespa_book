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
	NSString *result;
	result = [[NSString alloc] initWithFormat:@"%@ = %d and %d",
			  [entryDate descriptionWithCalendarFormat:@"%b %d %Y"],
			  firstNumber, secondNumber];
	return result;
}

- (id)initWithEntryDate:(NSCalendarDate *)theDate
{
	if (![super init])
		return nil;
	
	entryDate = theDate;
	firstNumber = random() % 100 + 1;
	secondNumber = random() % 100 + 1;
	return self;
}

- (id)init
{
	return [self initWithEntryDate:[NSCalendarDate calendarDate]];
}
@end
