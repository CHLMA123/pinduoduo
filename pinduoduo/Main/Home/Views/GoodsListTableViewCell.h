//
//  GoodsListTableViewCell.h
//  pinduoduo
//
//  Created by MCL on 16/6/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListDataModel.h"

@interface GoodsListTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)fillCellWithModel:(GoodsListDataModel *)model;

@end
