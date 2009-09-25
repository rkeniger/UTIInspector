//
//  RKUTIService.h
//  UTIInspector Bundle
//
//  Created by Rob Keniger on 25/09/09.
//  Copyright 2009 Big Bang Software Pty Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RKUTIService : NSObject 
{
	NSMutableArray* windowControllers;
}

//the method called by the services API
- (void)displayUTI:(NSPasteboard*)pboard userData:(NSString*)userData error:(NSString * *)error;
@end
