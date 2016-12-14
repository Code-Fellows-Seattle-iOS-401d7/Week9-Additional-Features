//
//  MyQueue.h
//  location-reminders
//
//  Created by Filiz Kurban on 12/5/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyQueue : NSObject

-(void)enqueue:(id)anObject;
-(id)dequeue;
-(id)peek;
@end
