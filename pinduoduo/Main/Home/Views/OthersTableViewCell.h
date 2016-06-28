//
//  OthersTableViewCell.h
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendSubjectsModel.h"

@interface OthersTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)fillCellWithModel:(RecommendSubjectsModel *)model;

@end
