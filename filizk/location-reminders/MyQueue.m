//
//  MyQueue.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/5/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "MyQueue.h"

static int kQueueSize = 100;

@interface MyQueue()

@property(strong, nonatomic) NSMutableArray *data;
@property(strong, nonatomic) NSNumber *size;

@end

@implementation MyQueue

-(id)init {
    self = [super init];

    if (self) {
        _data = [[NSMutableArray alloc]init];
        _size = [NSNumber numberWithInt:kQueueSize];
    }
    return self;
}

-(void)enqueue:(id)anObject {
    if (self.data.count < kQueueSize) {
        [self.data insertObject:anObject atIndex:0];
    } else {
        //pop last one and add
        [self dequeue];
        [self.data insertObject:anObject atIndex:0];
    }

}
-(id)dequeue {
    id object = nil;
    if (self.data.count > 0){
        object = [self.data lastObject];
        [self.data removeLastObject];
    }
    return object;
}

-(id)peek {
    id object = nil;
    if (self.data.count > 0){
        object = [self.data lastObject];
    }
    return object;
}

@end
