//
//  MJFoundation.m
//  MJExtensionExample
//
//  Created by MJ Lee on 14/7/16.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "MJFoundation.h"
//#import "MJExtensionConst.h"
#import <CoreData/CoreData.h>

static NSSet *foundationClasses_;

@implementation MJFoundation

+ (NSSet *)foundationClasses
{
    if (foundationClasses_ == nil) {
        // 集合中没有NSObject，因为几乎所有的类都是继承自NSObject，具体是不是NSObject需要特殊判断
        foundationClasses_ = [NSSet setWithObjects:
                              [NSURL class],
                              [NSDate class],
                              [NSValue class],
                              [NSData class],
                              [NSError class],
                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSAttributedString class], nil];
    }
    return foundationClasses_;
}

+ (BOOL)isClassFromFoundation:(Class)c
{
    //NSObject需要特殊判断
    if (c == [NSObject class] || c == [NSManagedObject class]) return YES;
    
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        //TODO: 如果是上面foundationClasses中类的子类，是不是就判断出错了？
        if ([c isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

@end
