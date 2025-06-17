//
//  TGRouterTests.m
//  TGRouterTests
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TGRouterTests : XCTestCase

@end

@implementation TGRouterTests

+ (BOOL) openURL:(NSString *)URL headers:(NSDictionary *)headers params:(NSDictionary *)params body:(id)body{
    
}
- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

+ (BOOL) canOpenURL:(NSString *)URL{
    BOOL result = false;
    return result;
}

+ (void) openURL:(NSString *)URL{
    
}
@end
