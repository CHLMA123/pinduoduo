//
//  NetworkHelper.h
//  pinduoduo
//
//  Created by MACHUNLEI on 16/6/19.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkHelperBlock)(id obj);

@interface NetworkHelper : NSObject

//@property (nonatomic, strong) NSString netStatus;

+ (instancetype)sharedManager;

- (void)networkReaching;

- (void)getWithURL:(NSString *)urlString WithParmeters:(NSDictionary *)dictionary compeletionWithBlock:(NetworkHelperBlock)block;

- (void)postWithURL:(NSString *)urlString WithParameters:(NSDictionary *)dictionary compeletionWithBlock:(NetworkHelperBlock)block;

@end
