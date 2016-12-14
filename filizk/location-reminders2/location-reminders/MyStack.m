//
//  MyStack.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/5/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "MyStack.h"

static int kStackSize = 100;

@interface MyStack()

@property(strong, nonatomic) NSMutableArray *data;
@property(strong, nonatomic) NSNumber *size;

@end

@implementation MyStack

-(id)init {
    self = [super init];

    if (self) {
        _data = [[NSMutableArray alloc]init];
        _size = [NSNumber numberWithInt:kStackSize];
    }
    return self;
}

-(void)push:(id)anObject{
    if (self.data.count < kStackSize) {
         [self.data addObject:anObject];
    } //else do nothing.
}

-(id)pop{
    id object = nil;
    if (self.data.count > 0){
        object = [self.data lastObject];
        [self.data removeLastObject];
    }
    return object;
}

-(id)peek{
    id object = nil;
    if (self.data.count > 0){
        object = [self.data lastObject];
    }
    return object;
}

@end
