//
//  HWAccount.m
//  LLSinaApp
//
//  Created by Leo on 16/10/15.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "HWAccount.h"

@implementation HWAccount

+ (instancetype)accountWithDic:(NSDictionary *)dict {
    
    HWAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    return account;
}

/**
 *  当一个对象要归档进沙盒中时调用这个方法，在这个方法中说明这个对象的哪些属性要存进沙盒
 *
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
}

/**
 *  当从沙盒中解档一个对象时调用这个方法，在这个方法中说明这个对象的哪些属性需要解档
 *
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
    }
    return self;
}


@end
