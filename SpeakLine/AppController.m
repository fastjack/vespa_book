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
@end
