//
//  RKUTIService.m
//  UTIInspector Bundle
//
//  Created by Rob Keniger on 25/09/09.
//  Copyright 2009 Big Bang Software Pty Ltd. All rights reserved.
//

#import "RKUTIService.h"
#import "RKUTIInspectorController.h"

@implementation RKUTIService

- (id)init
{
	self=[super init];
	if(self)
	{
		windowControllers = [NSMutableArray array];
	}
	return self;
}


//register the service
- (void)applicationDidFinishLaunching:(NSNotification*)notification
{
	[NSApp setServicesProvider:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	return YES;
}

//called when the Finder launches our service
- (void)displayUTI:(NSPasteboard*)pboard userData:(NSString*)userData error:(NSString * *)error
{
	// Test for strings on the pasteboard.
	NSArray* classes      = [NSArray arrayWithObject:[NSString class]];
	NSDictionary* options = [NSDictionary dictionary];

	if (![pboard canReadObjectForClasses:classes options:options])
	{
		*error = @"Error: couldn't retrieve UTI information.";
		[NSApp performSelector:@selector(terminate:) withObject:self afterDelay:0];
		return;
	}


	//get the string from the pasteboard
	NSString* pboardString    = [pboard stringForType:NSPasteboardTypeString];

	//split the string into individual file URL strings
	NSArray* fileURLs         = [pboardString componentsSeparatedByString:@"\n"];

	//loop through the file urls and display the windows
	for(NSString* urlString in fileURLs)
	{
		//get the actual path from the url
		NSURL* url       = [NSURL URLWithString:urlString];
		RKUTIInspectorController* controller = [[RKUTIInspectorController alloc] initWithFileURL:url];
		[windowControllers addObject:controller];
		[controller showWindow:self];
	}
}

@end
