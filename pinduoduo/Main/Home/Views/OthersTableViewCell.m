//
//  OthersTableViewCell.m
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "OthersTableViewCell.h"

@interface OthersTableViewCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIButton *seeMoreBtn;
@property (nonatomic, strong) UICollectionView *collectionV;

@end

@implementation OthersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
