//
//  GroupBuyView.h
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileAppGroupsModel.h"
typedef void(^UpdateViewBlock)(MobileAppGroupsModel *model);

@interface GroupBuyView : UIView

@property (nonatomic, copy) UpdateViewBlock block;

@end
