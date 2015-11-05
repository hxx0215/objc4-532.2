//
//  ocTest.m
//  ocTest
//
//  Created by shadowPriest on 15/9/23.
//
//

#import <XCTest/XCTest.h>
#import "NSObject.h"
#import "objc/message.h"
@interface testClassMethod: NSObject

@end
@implementation testClassMethod

+(id)foo{
    return @"foo";
}

@end

@interface Father : NSObject

@end
@implementation Father


- (void)printSelf{
    NSLog(@"Father:%@",self);
    [self printSelf];
}

- (id)performSelector:(SEL)aSelector{
//     ((void (*)(id, SEL, id))objc_msgSend)(self, @selector(otherMethodWithArgument:), arg);
    return ((id (*)(id,SEL))objc_msgSend)(self,aSelector);
}

@end

@interface Son : Father

@end
@implementation Son

- (instancetype)init{
    self = [super init];
    if (self){
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
        struct objc_super ssuper;
        ssuper.receiver = self;
        ssuper.super_class = class_getSuperclass(objc_getClass("Son"));
        NSStringFromClass(((Class (*)(struct objc_super *, SEL))(void *)objc_msgSendSuper)(&ssuper, sel_registerName("class")));
        [super printSelf];
    }
    return self;
}

- (void)printSelf{
    NSLog(@"Son");
}

@end

@interface ocTest : XCTestCase

@end

@implementation ocTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSObject *o = [NSObject new];
    [o class];
    XCTAssertNotNil(o);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testMyself{
    Son *s = [Son new];
}
@end
