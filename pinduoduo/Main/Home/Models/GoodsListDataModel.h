//
//  GoodsListDataModel.h
//  pinduoduo
//
//  Created by MCL on 16/6/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsListDataModel : NSObject

#pragma BasicItems - ScrollView
@property (nonatomic, assign)NSInteger goods_id;
@property (nonatomic, strong)NSString *goods_name;
@property (nonatomic, strong)NSString *image_url;
@property (nonatomic, assign)NSInteger is_app;
@property (nonatomic, assign)NSInteger event_type;
// group
@property (nonatomic, assign)NSInteger price;
@property (nonatomic, assign)NSInteger customer_num;

#pragma ExpandItems - home_recommend_subjects
@property (nonatomic, assign)NSInteger is_onsale;
@property (nonatomic, assign)NSInteger sales;
@property (nonatomic, strong)NSString *thumb_url;
@property (nonatomic, strong)NSString *hd_thumb_url;
@property (nonatomic, strong)NSString *logo;

#pragma ExpandItems - home_super_brand
@property (nonatomic, assign)NSInteger market_price;
@property (nonatomic, strong)NSString *promotion_goods;

@end

// ScrollView
/*
 "goods_list": [
 {
 "goods_id": 182012,
 "goods_name": "2088元Midea/美的 KFR-26GW/WJBA3@大1匹智能云除甲醛冷暖变频空调【秒杀16点开始 限量10份】",
 "image_url": "http://omsproductionimg.yangkeduo.com/images/goods/1606169261918898/Cn2P75dYBwsIeFPUuG4UkBJj1u6mhMIG.jpg",
 "is_app": 0,
 "event_type": 2,
 "group": {
 "price": 208800,
 "customer_num": 2
 }
 },
 */



// home_recommend_subjects

/*
            //"goods_id": 20581,
            //"goods_name": "【南非进口】27.9元南非红心西柚6个包邮（单果290-320克）",
 "is_onsale": 1,
 "thumb_url": "http://omsproductionimg.yangkeduo.com/goods/280b2c9f2b01f41dfccfb0b944bdd44deea933f984.jpg",
 "hd_thumb_url": "http://omsproductionimg.yangkeduo.com/goods/280b2c9f2bbb63f0761803a6082b960a52ebcbdac2.jpg",
            //"price": 2790,
            //"image_url": "http://testpddimg.yangkeduo.com/goods/d41d8cd98f61a72563ce8be3528cf5804e0d40b5ef.jpg",
 "sales": 5181,
 "logo": "http://img-cn-shanghai.aliyuncs.com/pddtest/images/goods/16051690677682492OCa8F104zm0SSkdmiRby8cCtCLHyRcS.jpg",
            //"is_app": 0,
            //"event_type": 0,
            //"customer_num": 3
 */


/*
 home_super_brand
 
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
