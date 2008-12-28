//
//  AppController.m
//  SpeakLine
//
//  Created by Martin Maciaszek on 27.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController
- (id)init
{
	[super init];
	
	// Logs can help the beginner unterstand what
	// is happening and hunt down bugs.
	NSLog(@"init");
	
	// Create a new instance of NSSpeechSynthesizer
	// with the default voice.
	speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
	[speechSynth setDelegate:self];
	voiceList = [[NSSpeechSynthesizer availableVoices] retain];
	return self;
}

- (IBAction)sayIt:(id)sender
{
	NSString *string = [textField stringValue];
	
	// Is the string zero-length
	if ([string length] == 0) {
		NSLog(@"string from %@ is of zero-length", textField);
		return;
	}
	[speechSynth startSpeakingString:string];
	NSLog(@"Have started to say: %@", string);
	[startButton setEnabled:NO];
	[stopButton setEnabled:YES];
	[tableView setEnabled:NO];
}

- (IBAction)stopIt:(id)sender
{
	NSLog(@"stopping");
	[speechSynth stopSpeaking];
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender
		didFinishSpeaking:(BOOL)complete
{
	NSLog(@"complete = %d", complete);
	[startButton setEnabled:YES];
	[stopButton setEnabled:NO];
	[tableView setEnabled:YES];
}

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	return [voiceList count];
}

- (id)tableView:(NSTableView *)tv
	objectValueForTableColumn:(NSTableColumn *)tableColumn
						  row:(int)row
{
	NSString *v = [voiceList objectAtIndex:row];
	NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v];
	return [dict objectForKey:NSVoiceName];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
	int row = [tableView selectedRow];
	if (row == -1) {
		return;
	}
	NSString *selectedVoice = [voiceList objectAtIndex:row];
	[speechSynth setVoice:selectedVoice];
	NSLog(@"new voice = %@", selectedVoice);
}

- (void)awakeFromNib
{
	// When the table view appears on screen, the default voice
	// should be selected
	NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice];
	int defaultRow = [voiceList indexOfObject:defaultVoice];
	[tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:defaultRow] byExtendingSelection:NO];
	[tableView scrollRowToVisible:defaultRow];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
	NSString *methodName = NSStringFromSelector(aSelector);
	NSLog(@"respondsToSelector:%@", methodName);
	return [super respondsToSelector:aSelector];
}
@end
