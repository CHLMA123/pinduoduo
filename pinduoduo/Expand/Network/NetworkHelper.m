//
//  NetworkHelper.m
//  pinduoduo
//
//  Created by MACHUNLEI on 16/6/19.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "NetworkHelper.h"
#import "AFNetworking.h"
#import "JSONKit.h"

@interface NetworkHelper ()

@property (nonatomic, strong)AFHTTPSessionManager *manger;
@property (nonatomic, strong)NSString *netStatus;

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
        self.netStatus = [NSString string];
//        self.manger.responseSerializer = [AFJSONResponseSerializer serializer];
//        self.manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    }
    return self;
}

/*
 AFNetworkReachabilityStatusUnknown          = -1,
 AFNetworkReachabilityStatusNotReachable     = 0,
 AFNetworkReachabilityStatusReachableViaWWAN = 1,
 AFNetworkReachabilityStatusReachableViaWiFi = 2,
 */
- (void)networkReaching{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *mNetworkStatus = [NSString string];
        switch (status) {
            case -1:
                mNetworkStatus = @"Unknown";
                break;
            case 0:
                mNetworkStatus = @"NotReachable";
                break;
            case 1:
                mNetworkStatus = @"WWAN";
                break;
            case 2:
                mNetworkStatus = @"WiFi";
                break;
            default:
                break;
        }
        if (self.netStatus) {
            if (![self.netStatus isEqualToString:mNetworkStatus]) {//网络状态发生变化，拋一个通知出来
                self.netStatus = mNetworkStatus;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NetReachabilityStatusChanged" object:nil userInfo:@{@"networkStatus":mNetworkStatus}];
            }
        }else{
        
            self.netStatus = mNetworkStatus;
        }
        
        NSLog(@"当前网络状态 = %@",self.netStatus);
    }];
    
}

- (void)getWithURL:(NSString *)urlString WithParmeters:(NSDictionary *)dictionary compeletionWithBlock:(NetworkHelperBlock)block
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.manger GET:url.absoluteString parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        id retArr = (NSArray *)responseObject;
        BLOCK_EXEC(block,responseObject);
        
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
