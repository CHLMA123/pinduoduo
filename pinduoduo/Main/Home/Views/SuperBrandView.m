//
//  SuperBrandView.m
//  pinduoduo
//
//  Created by MCL on 16/6/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "SuperBrandView.h"

@interface SuperBrandView ()

@property (nonatomic, strong) UIImageView *goodsImageV;
@property (nonatomic, strong) UILabel *discountLbl;
@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) UILabel *priceLbl;

@end

@implementation SuperBrandView

- (instancetype)initWithFrame:(CGRect)frame withDataModel:(GoodsListDataModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInitView];
        [self commitInitDataWithModel:model];
    }
    return self;
}

- (void)commitInitView{
    
    self.goodsImageV = [[UIImageView alloc] init];
    _goodsImageV.frame = CGRectMake(0, 0, 120, 120);
    _goodsImageV.layer.borderWidth = 1;
    
    self.discountLbl = [[UILabel alloc] init];
    _discountLbl.frame = CGRectMake(60, 10, 50, 20);
    _discountLbl.textAlignment = NSTextAlignmentCenter;
    _discountLbl.font = [UIFont systemFontOfSize:15];
    _discountLbl.text = @"3.21折";
    
    self.logoImageV = [[UIImageView alloc] init];
    _logoImageV.frame = CGRectMake(20, 130, 80, 50);
    
    self.priceLbl = [[UILabel alloc] init];
    _priceLbl.frame = CGRectMake(20, 190, 80, 25);
    _priceLbl.textAlignment = NSTextAlignmentCenter;
    _priceLbl.font = [UIFont systemFontOfSize:17];
    
    [self addSubview:_goodsImageV];
    [self addSubview:_discountLbl];
    [self addSubview:_logoImageV];
    [self addSubview:_priceLbl];
}

- (void)commitInitDataWithModel:(GoodsListDataModel *)model{
    
    [_goodsImageV sd_setImageWithURL:[NSURL URLWithString:model.thumb_url] placeholderImage:[UIImage imageNamed:@"default_square"]];
    [_logoImageV sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_square"]];
    _priceLbl.text = [NSString stringWithFormat:@"¥ %@",model.price];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
