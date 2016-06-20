//
//  NetworkHelper.m
//  pinduoduo
//
//  Created by MACHUNLEI on 16/6/19.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "NetworkHelper.h"
#import "AFNetworking.h"

@interface NetworkHelper ()

@property (nonatomic, strong)AFHTTPSessionManager *manger;

@end

@implementation NetworkHelper

+ (instancetype)sharedManager{
    
    static NetworkHelper *networkHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkHelper = [[self alloc] init];
    });
    
    return networkHelper;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.manger = [AFHTTPSessionManager manager];
//        self.manger.responseSerializer = [AFJSONResponseSerializer serializer];
//        self.manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    }
    return self;
}

- (void)networkReaching{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"当前网络状态 = %ld",(long)status);
    }];
}

- (void)getWithURL:(NSString *)urlString WithParmeters:(NSDictionary *)dictionary compeletionWithBlock:(NetworkHelperBlock)block
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.manger GET:url.absoluteString parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        BLOCK_EXEC(block,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error.description);
    }];
    
}

- (void)postWithURL:(NSString *)urlString WithParameters:(NSDictionary *)dictionary compeletionWithBlock:(NetworkHelperBlock)block{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.manger POST:url.absoluteString parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        BLOCK_EXEC(block,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error.description);
    }];
}

@end
