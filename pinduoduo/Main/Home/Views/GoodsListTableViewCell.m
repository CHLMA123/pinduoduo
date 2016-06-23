//
//  GoodsListTableViewCell.m
//  pinduoduo
//
//  Created by MCL on 16/6/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "GoodsListTableViewCell.h"

@interface GoodsListTableViewCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *goodsImageV;
@property (nonatomic, strong) UILabel *goodsNameLbl;
@property (nonatomic, strong) UIView *buyNowView;

@property (nonatomic, strong) UIImageView *customerImageV;
@property (nonatomic, strong) UILabel *customerNumLbl;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UIButton *goBuyBtn;
@property (nonatomic, strong) UIButton *favorBtn;

@end

@implementation GoodsListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self commitInitData];
    }
    return self;
}

- (void)fillCellWithModel:(GoodsListDataModel *)model{
    // 1 商品图片
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    self.bgView = [[UIView alloc] init];
    _bgView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 350);
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    _goodsImageV = [[UIImageView alloc] init];
    [_goodsImageV sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"default_load"]];
    // 2 商品名称
    _goodsNameLbl = [[UILabel alloc] init];
    _goodsNameLbl.backgroundColor = [UIColor whiteColor];
    _goodsNameLbl.numberOfLines = 0;
    _goodsNameLbl.textColor = [UIColor blackColor];
    _goodsNameLbl.text = model.goods_name;
    // 3 商品描述
    _buyNowView = [[UIView alloc] init];
    _buyNowView.backgroundColor = RGBCOLOR(79, 79, 79);
    _buyNowView.layer.cornerRadius = 3;
    
    _customerImageV = [[UIImageView alloc] init];
    _customerImageV.image = [UIImage imageNamed:@"group"];
    _customerNumLbl = [[UILabel alloc] init];
    _customerNumLbl.textColor = [UIColor whiteColor];
    _customerNumLbl.text = [NSString stringWithFormat:@"%@人团", model.customer_num];
    _priceLbl = [[UILabel alloc] init];
    _priceLbl.textColor = [UIColor whiteColor];
    _priceLbl.text = [NSString stringWithFormat:@"%@", model.price];
    _goBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goBuyBtn setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [_goBuyBtn setImageEdgeInsets: UIEdgeInsetsMake(0, 60, 0, 0)];
    [_goBuyBtn setBackgroundColor:[UIColor redColor]];
    [_goBuyBtn setTitle:@"去团购" forState:UIControlStateNormal];
    _goBuyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_goBuyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
    CGRect rect = CGRectMake(0, 0, 85, 44);//button 的尺寸
    CGSize radio = CGSizeMake(3, 3);//圆角尺寸
    UIRectCorner corner = UIRectCornerTopRight|UIRectCornerBottomRight;//圆角位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = _goBuyBtn.bounds;
    masklayer.path = path.CGPath;//设置路径
    _goBuyBtn.layer.mask = masklayer;
    
    [_buyNowView addSubview:_customerImageV];
    [_buyNowView addSubview:_customerNumLbl];
    [_buyNowView addSubview:_priceLbl];
    [_buyNowView addSubview:_goBuyBtn];
    
    _favorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_favorBtn setBackgroundImage:[UIImage imageNamed:@"add_favor"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_goodsImageV];
    [self.contentView addSubview:_goodsNameLbl];
    [self.contentView addSubview:_buyNowView];
    [self.contentView addSubview:_favorBtn];
    
}


- (void)commitInitData{
    
}

- (void)layoutSubviews{
    
    [self.goodsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.mas_offset(10);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(220);
    }];
    [self.goodsNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImageV.mas_bottom).with.mas_offset(10);
        make.left.mas_equalTo(self.mas_left).with.mas_offset(10);
        make.right.mas_equalTo(self.mas_right).with.mas_offset(-10);
        make.height.mas_equalTo(55);
    }];
    
    [self.buyNowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsNameLbl.mas_bottom).with.mas_offset(10);
        make.left.mas_equalTo(self.mas_left).with.mas_offset(10);
        make.width.mas_equalTo(315);
        make.height.mas_equalTo(44);
    }];
    
    [self.customerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyNowView.mas_top).with.mas_offset(3.5);
        make.left.mas_equalTo(self.buyNowView.mas_left).with.mas_offset(3.5);
        make.width.mas_equalTo(42);
        make.bottom.mas_equalTo(self.buyNowView.mas_bottom).with.mas_offset(-3.5);
    }];
    
    [self.customerNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customerImageV.mas_top).with.mas_offset(3.5);
        make.left.mas_equalTo(self.customerImageV.mas_right).with.mas_offset(4.5);
        make.bottom.mas_equalTo(self.customerImageV.mas_bottom);
        make.width.mas_equalTo(55);
    }];
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customerImageV.mas_top).with.mas_offset(3.5);
        make.left.mas_equalTo(self.customerNumLbl.mas_right).with.mas_offset(10);
        make.bottom.mas_equalTo(self.customerImageV.mas_bottom);
        make.width.mas_equalTo(65);
    }];
    
    [self.goBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyNowView.mas_top);
        make.left.mas_equalTo(self.priceLbl.mas_right).with.mas_offset(50);
        make.bottom.mas_equalTo(self.buyNowView.mas_bottom);
        make.width.mas_equalTo(85);
    }];
    
    [self.favorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customerImageV.mas_top).with.mas_offset(3.5);
        make.right.mas_equalTo(self.mas_right).with.mas_offset(-13.5);
        make.bottom.mas_equalTo(self.customerImageV.mas_bottom);
        make.width.mas_equalTo(44);
    }];
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
