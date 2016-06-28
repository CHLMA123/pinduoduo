//
//  SuperBrandTableViewCell.h
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperBrandDataModel.h"

@interface SuperBrandTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)fillCellWithModel:(SuperBrandDataModel *)model;

@end
