//
//  HomeRecommendSubjectsModel.h
//  pinduoduo
//
//  Created by MCL on 16/6/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsSubjectModel.h"

@interface RecommendSubjectsModel : NSObject

@property (nonatomic, strong)GoodsSubjectModel *goodSubjectModel;
@property (nonatomic, strong)NSArray *goodlistArr;
@property (nonatomic, strong)NSString *position;
@property (nonatomic, strong)NSString *cellIdentifier;

@end

/*
 
 GoodsSubject
 
 {
 "subject_id": 373,
 "subject": "天天特价",
 "second_name": "",
 "desc": "天天特价",
 "home_banner": "http://omsproductionimg.yangkeduo.com/images/goods/373/5w5fVArMmEa6hyKYvQhZZgEqbWBAFYZm.jpg",
 "home_banner_height": 350,
 "home_banner_width": 640,
 "type": "home_recommend",
 "position": 8,
 "share_image": "",
 "goods_list": [
 {
 "goods_id": 183635,
 "goods_name": "23.9元 黑布林5斤（19-26个）美国黑李品种（plum）现摘现发胜智利进口品种 孕妇水果【预售6月26日完成发货】",
 "is_onsale": 1,
 "thumb_url": "http://omsproductionimg.yangkeduo.com/images/goods/1606161336307601/ogHtyIkbJEjd4L08v0L7ktEDdms28vmU.jpg",
 "hd_thumb_url": "http://omsproductionimg.yangkeduo.com/images/goods/1606161336307601/uJexEWUmsC6fHmuX0pVGkTWmvRkx5Z4W.jpg",
 "price": 2390,
 "image_url": "http://omsproductionimg.yangkeduo.com/images/goods/386720/p0uZIbdRkzeFt9K3sbIOkSq1on1NTPnr.jpg",
 "sales": 1649,
 "logo": "http://img-cn-shanghai.aliyuncs.com/pddtest/images/goods/16051690677682492OCa8F104zm0SSkdmiRby8cCtCLHyRcS.jpg",
 "is_app": 0,
 "event_type": 0,
 "customer_num": 2
 },
 
 */