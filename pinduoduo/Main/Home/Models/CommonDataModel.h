//
//  CommonDataModel.h
//  pinduoduo
//
//  Created by MCL on 16/7/13.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsSubjectModel.h"

@interface CommonDataModel : NSObject

@property (nonatomic, strong)GoodsSubjectModel *goodSubjectModel;
@property (nonatomic, strong)NSArray *goodlistArr;
@property (nonatomic, strong)NSString *position;
@property (nonatomic, strong)NSString *cellIdentifier;

@end
