//
//  UTIInspectorController.h
//  UTIInspector
//
//  Created by Rob Keniger on 25/09/09.
//  Copyright 2009 Big Bang Software Pty Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RKUTIInspectorController : NSWindowController 
{
	NSURL* fileURL;
	IBOutlet NSImageView* iconView;
	IBOutlet NSTextField* fileNameField;
	IBOutlet NSTextField* utiField;
	IBOutlet NSTextField* descriptionField;
	IBOutlet NSTextField* bundleNameField;
	IBOutlet NSImageView* bundleIconField;
}

- (id)initWithFileURL:(NSURL*)url;

@end
