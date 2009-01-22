//
//  AppController.m
//  AmaZone
//
//  Created by Martin Maciaszek on 22.01.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#define AWS_ID @"1CKE6MZ6S27EFQ458402"

@implementation AppController
- (IBAction)fetchBooks:(id)sender
{
	// Show the user that something is going on
	[progress startAnimation:nil];
	// Put together the request
	// See http://www.amazon.com/gp/aws/landing.html
	
	// Get the string and percent-escape for insertion into URL
	NSString *input = [searchField stringValue];
	NSString *searchString = [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"searchString = %@", searchString);
	
	// Create the URL (Long string broken into several lines is OK)
	NSString *urlString = [NSString stringWithFormat:
						   @"http://ecs.amazonaws.com/onca/xml?"
						   @"Service=AWSECommerceService&"
						   @"AWSAccessKeyId=%@&"
						   @"Operation=ItemSearch&"
						   @"SearchIndex=Books&"
						   @"Keywords=%@&"
						   @"Version=2007-07-16",
						   AWS_ID, searchString];
	
	NSURL *url =[NSURL URLWithString:urlString];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
												  cachePolicy:NSURLRequestReturnCacheDataElseLoad
											  timeoutInterval:30];
	// Fetch the XML response
	
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest
									returningResponse:&response
												error:&error];
	if (!urlData) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
	// Parse the XML response
	[doc release];
	doc = [[NSXMLDocument alloc] initWithData:urlData
									  options:0
										error:&error];
	NSLog(@"doc = %@", doc);
	if (!doc) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
	[itemNodes release];
	itemNodes = [[doc nodesForXPath:@"ItemSearchResponse/Items/Item"
							  error:&error] retain];
	if (!itemNodes) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
	// Update the interface
	[tableView reloadData];
	[progress stopAnimation:nil];
}

- (NSString *)stringForPath:(NSString *)xp ofNode:(NSXMLNode *)n
{
	NSError *error;
	NSArray *nodes = [n nodesForXPath:xp error:&error];
	if (!nodes) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return nil;
	}
	if ([nodes count] == 0) {
		return nil;
	} else {
		return [[nodes objectAtIndex:0] stringValue];
	}
}

#pragma mark TableView data source methods

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	return [itemNodes count];
}

- (id)tableView:(NSTableView *)tv
	objectValueForTableColumn:(NSTableColumn *)tableColumn
						  row:(int)row
{
	NSXMLNode *node = [itemNodes objectAtIndex:row];
	NSString *xPath = [tableColumn identifier];
	return [self stringForPath:xPath ofNode:node];
}
@end
