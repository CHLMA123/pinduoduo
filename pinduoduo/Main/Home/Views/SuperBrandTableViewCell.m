//
//  SuperBrandTableViewCell.m
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "SuperBrandTableViewCell.h"

@interface SuperBrandTableViewCell ()

@property (nonatomic, strong) UILabel *titleLbl;
//定时器View
//@property (nonatomic, strong)
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIImageView *goodsImageV;
@property (nonatomic, strong) UILabel *discountLbl;
@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) UILabel *priceLbl;

@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIImageView *goodsImageV2;
@property (nonatomic, strong) UILabel *discountLbl2;
@property (nonatomic, strong) UIImageView *logoImageV2;
@property (nonatomic, strong) UILabel *priceLbl2;

@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIImageView *goodsImageV3;
@property (nonatomic, strong) UILabel *discountLbl3;
@property (nonatomic, strong) UIImageView *logoImageV3;
@property (nonatomic, strong) UILabel *priceLbl3;

@property (nonatomic, strong) UIButton *seeMoreBtn;


@end

@implementation SuperBrandTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commitInitData];
    }
    return self;
}

- (void)commitInitData{

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
