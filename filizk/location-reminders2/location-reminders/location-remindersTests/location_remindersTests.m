//
//  location_remindersTests.m
//  location-remindersTests
//
//  Created by Filiz Kurban on 12/5/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyStack.h"
#import "MyQueue.h"

@interface location_remindersTests : XCTestCase

@end

@implementation location_remindersTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testQueue {
    MyQueue *myQ = [[MyQueue alloc]init];
    [myQ enqueue:@1];
    [myQ enqueue:@2];
    [myQ enqueue:@3];
    NSNumber *dequedNum = [myQ dequeue];
    [myQ peek];
    [myQ enqueue:@4];

    dequedNum = [myQ dequeue];
    NSNumber *expectedResult = [[NSNumber alloc]initWithInt:(2)];

    XCTAssertTrue([dequedNum intValue] == [expectedResult intValue]);

}

- (void)testStack {
    MyStack *myS = [[MyStack alloc]init];
    [myS push:@1];
    [myS push:@2];
    [myS push:@3];

    NSString *poppedNum = [myS pop];
    [myS peek];
    [myS push:@"4"];

    poppedNum = [myS pop];
    NSNumber *expectedResult = [[NSNumber alloc]initWithInt:(4)];

    XCTAssertTrue([poppedNum intValue] == [expectedResult intValue]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
