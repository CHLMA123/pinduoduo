//
//  GoodsListDataModel.m
//  pinduoduo
//
//  Created by MCL on 16/6/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "GoodsListDataModel.h"

@implementation GoodsListDataModel

//以下是另外一种初始化Model的方法 可嵌套Model

// /** 新闻标题 */
//@property (nonatomic, copy) NSString *title;
///** 新闻发布时间 */
//@property (nonatomic, copy) NSString *ptime;
///** 新闻内容 */
//@property (nonatomic, copy) NSString *body;
///** 新闻配图(希望这个数组中以后放HMNewsDetailImg模型) */
//@property (nonatomic, strong) NSArray *img;
//
//+ (instancetype)detailWithDict:(NSDictionary *)dict;


//+ (instancetype)detailWithDict:(NSDictionary *)dict{
    /*
     SXDetailModel *detail = [[self alloc]init];
     detail.title = dict[@"title"];
     detail.ptime = dict[@"ptime"];
     detail.body = dict[@"body"];
     
     NSArray *imgArray = dict[@"img"];
     NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
     
     for (NSDictionary *dict in imgArray) {
     SXDetailImgModel *imgModel = [SXDetailImgModel detailImgWithDict:dict];
     [temArray addObject:imgModel];
     }
     detail.img = temArray;
     
     
     return detail;
     */
//}

@end
