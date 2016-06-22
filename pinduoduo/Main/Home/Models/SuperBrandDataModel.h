//
//  SuperBrandDataModel.h
//  pinduoduo
//
//  Created by MCL on 16/6/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsSubjectModel.h"

@interface SuperBrandDataModel : NSObject

@property (nonatomic, strong)GoodsSubjectModel *goodSubjectModel;
@property (nonatomic, strong)NSArray *goodlistArr;

@end

/*
 home_super_brand
 {
 "subject_id": 426,
 "subject": "6/18大牌",
 "second_name": "",
 "desc": "",
 "start_time": 1466179200,
 "end_time": 1466265600,
 "home_banner": "",
 "home_banner_height": 0,
 "home_banner_width": 0,
 "type": "super_brand",
 "position": 4,
 "share_image": "",
 "goods_list": [
 {
 "goods_id": 108811,
 "goods_name": "84.9元   【618来了，这价格不抢就没了！】SKG养生壶绿色/紫色/咖啡色三色可选正品加厚玻璃",
 "is_onsale": 1,
 "thumb_url": "http://omsproductionimg.yangkeduo.com/images/goods/1605232923843592/6HL9e63Ti4DepMVb2ewX1pTWIaHsFKYG.jpg",
 "hd_thumb_url": "http://omsproductionimg.yangkeduo.com/images/goods/1605232923843592/Domsc65nEbh8zyWQgYeOnIVFo8e9EnHj.jpg",
 "price": 8490,
 "image_url": "http://omsproductionimg.yangkeduo.com/images/goods/1605232923843592/dnAjrIKPYeUXcjiG0NsvqaQH0G1pEPH8.jpg",
 "market_price": 69900,
 "sales": 523,
 "logo": "http://omsproductionimg.yangkeduo.com/images/super_brand/0/r5nAKltpZzHqEPG15sdFsM4hHfn8eQeb.jpg",
 "is_app": 0,
 "event_type": 5,
 "customer_num": 2,
 "promotion_goods": "675525,675920"
 },
 
 */