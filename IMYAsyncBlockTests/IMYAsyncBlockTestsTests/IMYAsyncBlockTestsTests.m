//
//  IMYAsyncBlockTestsTests.m
//  IMYAsyncBlockTestsTests
//
//  Created by ljh on 16/5/30.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+IMYAsyncBlock.h"

@interface IMYAsyncBlockTestsTests : XCTestCase

@end

@implementation IMYAsyncBlockTestsTests
- (void)testCancelAsyncBlock
{
    XCTestExpectation* expectation = [self expectationWithDescription:@"Cacnel Block"];
    
    NSString *queueKey = NSStringFromSelector(_cmd);
    [NSObject imy_asyncBlock:^{
        XCTAssert(NO, @"Cacnel Fail");
    } onQueue:dispatch_get_global_queue(0, 0) afterSecond:2 forKey:queueKey];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        [NSObject imy_cancelBlockForKey:queueKey];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError* _Nullable error) {
        if (error) {
            XCTAssert(NO, @"Execute Fail");
        }
    }];
}

- (void)testHasAsyncBlock {
    
    NSString *queueKey = NSStringFromSelector(_cmd);
    [NSObject imy_asyncBlock:^{
        NSLog(@"Execute OK");
    } onQueue:dispatch_get_global_queue(0, 0) afterSecond:2 forKey:queueKey];
    
    BOOL hasContain = [NSObject imy_hasAsyncBlockForKey:queueKey];
    
    XCTAssertTrue(hasContain);
}

- (void)testExecuteAsyncBlock {
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"Execute Block"];
    
    NSString *queueKey = NSStringFromSelector(_cmd);
    [NSObject imy_asyncBlock:^{
        NSLog(@"Execute OK");
        [expectation fulfill];
    } onQueue:dispatch_get_global_queue(0, 0) afterSecond:2 forKey:queueKey];
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError* _Nullable error) {
        if (error) {
            XCTAssert(NO, @"Execute Fail");
        }
    }];
}
@end
