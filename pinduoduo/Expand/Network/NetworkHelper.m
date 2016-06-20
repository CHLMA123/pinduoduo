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

- (void)networkReaching{
    /*
     AFNetworkReachabilityStatusUnknown          = -1,
     AFNetworkReachabilityStatusNotReachable     = 0,
     AFNetworkReachabilityStatusReachableViaWWAN = 1,
     AFNetworkReachabilityStatusReachableViaWiFi = 2,
     */
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                self.netStatus = @"Unknown";
                break;
            case 0:
                self.netStatus = @"NotReachable";
                break;
            case 1:
                self.netStatus = @"WWAN";
                break;
            case 2:
                self.netStatus = @"WiFi";
                break;
            default:
                break;
        }
        NSLog(@"当前网络状态 = %@",self.netStatus);
    }];
}

- (void)getWithURL:(NSString *)urlString WithParmeters:(NSDictionary *)dictionary compeletionWithBlock:(NetworkHelperBlock)block
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.manger GET:url.absoluteString parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *retArr = (NSArray *)responseObject;
        BLOCK_EXEC(block,retArr);
        
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
