//
//  UTIInspectorController.m
//  UTIInspector
//
//  Created by Rob Keniger on 25/09/09.
//  Copyright 2009 Big Bang Software Pty Ltd. All rights reserved.
//

#import "RKUTIInspectorController.h"

@implementation RKUTIInspectorController

- (id)initWithFileURL:(NSURL*)url;
{
	self=[super initWithWindowNibName:@"UTIInspector"];
	if(self)
	{
		fileURL = [url copy];
		[self setShouldCascadeWindows:YES];
	}
	return self;
}

- (void)windowDidLoad
{
	//if we don't do this, windows don't get brought to the front properly
	[[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
	NSWorkspace *workspace = [NSWorkspace sharedWorkspace];

	//get the actual path from the url
	NSString* path   = [fileURL path];
	NSError* anError = nil;
	
	//get the UTI information
	NSString* uti    = [workspace typeOfFile:path error:&anError];

	if(anError)
	{
		uti = @"Error obtaining UTI";
	}
	
	//get the nice description
	NSString* description = [workspace localizedDescriptionForType:uti];

	//provide sane fallbacks
	NSString* bundlePath = nil;
	if(uti)
	{
		NSURL* bundleURL = NSMakeCollectable(UTTypeCopyDeclaringBundleURL((CFStringRef)uti));
		if(bundleURL)
		{
			bundlePath = [bundleURL path];
		}
	}
	else
		uti = @"Unknown";

	if(!description)
		description = @"Unknown";
	
	//update the UI	
	NSString* fileName = [path lastPathComponent];
	
	[[self window] setTitle:[NSString stringWithFormat:@"%@ UTI Info",fileName]];
	[iconView setImage:[workspace iconForFile:path]];
	[fileNameField setStringValue:fileName];
	[fileNameField setToolTip:path];
	[utiField setStringValue:uti];
	[descriptionField setStringValue:description];
	if(bundlePath)
	{
		[bundleNameField setStringValue:[bundlePath lastPathComponent]];
		[bundleNameField setToolTip:bundlePath];
		[bundleIconField setImage:[workspace iconForFile:bundlePath]];
		[bundleIconField setToolTip:bundlePath];
	}
	else
	{
		NSPoint origin = NSMakePoint([utiField frame].origin.x, [bundleNameField frame].origin.y);
		[bundleIconField removeFromSuperview];
		[bundleNameField setFrameOrigin:origin];
		[bundleNameField setStringValue:@"Unknown"];
	}
}

@end
