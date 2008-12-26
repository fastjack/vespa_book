#import <Foundation/Foundation.h>
#import "LotteryEntry.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// Create the date object
	NSCalendarDate *now = [[NSCalendarDate alloc] init];
	
	// Seed the random number generator
	srandom(time(NULL));

	NSMutableArray *array;
	array = [[NSMutableArray alloc] init];
	int i;
	for (i = 0; i < 10; i++) {
		// Create a date/time object that is i weeks from now
		NSCalendarDate *iWeeksFromNow;
		iWeeksFromNow = [now dateByAddingYears:0 
										months:0
										  days:(i * 7)
										 hours:0
									   minutes:0
									   seconds:0];
		
		// Create a new instance of LotteryEntry
		LotteryEntry *newEntry = [[LotteryEntry alloc] initWithEntryDate:iWeeksFromNow];
		
		// Add the LotteryEntry object to the array
		[array addObject:newEntry];
	}
	// Done with 'now'
	now = nil;
	
	for (LotteryEntry *entryToPrint in array) {
		// Display its contents
		NSLog(@"%@", entryToPrint);
	}
	// Done with 'array'
	array = nil;
	
    [pool drain];
	NSLog(@"GC = %@", [NSGarbageCollector defaultCollector]);
    return 0;
}
