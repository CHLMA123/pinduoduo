//
//  MobileAppGroupsModel.h
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileAppGroupsModel : NSObject

@property (nonatomic, strong)NSString *group_id;
@property (nonatomic, strong)NSString *goods_id;
@property (nonatomic, strong)NSString *goods_name;
@property (nonatomic, strong)NSString *banner;
@property (nonatomic, strong)NSString *thumb_url;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, strong)NSString *start_time;
@property (nonatomic, strong)NSString *end_time;

@end

// mobile_app_groups
/*
 {
 "group_id": 383099,
 "goods_id": 188207,
 "goods_name": "【直降80元】0.1元越南猫山王榴莲1个(4-6斤) 有奶油味的顶级榴莲！ 限量250份【APP专享团】",
 "banner": "http://omsproductionimg.yangkeduo.com/images/app_enjoy/0/OcCghCnhggDknhuepx7RiOPcpRJBv9Oh.jpg",
 "thumb_url": "http://omsproductionimg.yangkeduo.com/images/app_enjoy/0/33Hi7oyhTf0ea2fmifTzodCALv3mwGed.jpg",
 "desc": "0.1元1个猫山王榴莲APP专享团进行中",
 "start_time": 1466330400,
 "end_time": 1466935200
 }
 */
