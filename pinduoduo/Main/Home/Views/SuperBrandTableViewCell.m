//
//  SuperBrandTableViewCell.m
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "SuperBrandTableViewCell.h"
#import "GoodsSubjectModel.h"
#import "GoodsListDataModel.h"
#import "SuperBrandView.h"

@interface SuperBrandTableViewCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLbl;
//定时器View
@property (nonatomic, strong) UIView *timerView;


@property (nonatomic, strong) SuperBrandView *view;
//@property (nonatomic, strong) UIImageView *goodsImageV;
//@property (nonatomic, strong) UILabel *discountLbl;
//@property (nonatomic, strong) UIImageView *logoImageV;
//@property (nonatomic, strong) UILabel *priceLbl;

@property (nonatomic, strong) SuperBrandView *view2;
//@property (nonatomic, strong) UIImageView *goodsImageV2;
//@property (nonatomic, strong) UILabel *discountLbl2;
//@property (nonatomic, strong) UIImageView *logoImageV2;
//@property (nonatomic, strong) UILabel *priceLbl2;

@property (nonatomic, strong) SuperBrandView *view3;
//@property (nonatomic, strong) UIImageView *goodsImageV3;
//@property (nonatomic, strong) UILabel *discountLbl3;
//@property (nonatomic, strong) UIImageView *logoImageV3;
//@property (nonatomic, strong) UILabel *priceLbl3;

@property (nonatomic, strong) UIButton *seeMoreBtn;

@property (nonatomic, strong) GoodsSubjectModel *subjectModel;
@property (nonatomic, strong) NSArray *goodsListArr;

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
    self.subjectModel = [[GoodsSubjectModel alloc] init];
    self.goodsListArr = [NSArray array];
}

/*
 10
 40
 5
 30
 10
 ------------ view
 130 *120
 
 5
 50
 10
 20
 ------------
 20
 20
 10
 */

- (void)fillCellWithModel:(SuperBrandDataModel *)model{
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    self.bgView = [[UIView alloc] init];
    _bgView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 350);
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    _subjectModel = model.goodSubjectModel;
    _goodsListArr = model.goodlistArr;
    
    self.titleLbl = [[UILabel alloc] init];
    _titleLbl.frame = CGRectMake(10, 10,SCREEN_WIDTH - 20, 40);
    _titleLbl.textColor = [UIColor blackColor];
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    _titleLbl.text = @"超值大牌";
    _titleLbl.font = [UIFont systemFontOfSize:19];
    
    self.timerView = [[UIView alloc] init];
    _timerView.frame = CGRectMake(10, 60, SCREEN_WIDTH - 20, 40);
    _timerView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.25];
    
    self.view = [[SuperBrandView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 360)/4, 105, 120, 215) withDataModel:_goodsListArr[0]];
    
    self.view2 = [[SuperBrandView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 360)/4 * 2 + 120, 105, 120, 215) withDataModel:_goodsListArr[1]];

    self.view3 = [[SuperBrandView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 360)/4*3 + 240, 105, 120, 215) withDataModel:_goodsListArr[2]];
    
    self.seeMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _seeMoreBtn.frame = CGRectMake(50, 320, SCREEN_WIDTH - 100, 40);
    [_seeMoreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [_seeMoreBtn addTarget:self action:@selector(seeMoreAction2) forControlEvents:UIControlEventTouchUpInside];
    [_seeMoreBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_titleLbl];
    [self.contentView addSubview:_timerView];
    [self.contentView addSubview:_view];
    [self.contentView addSubview:_view2];
    [self.contentView addSubview:_view3];
    [self.contentView addSubview:_seeMoreBtn];
}

- (void)seeMoreAction2{
    NSLog(@"seeMoreAction2");
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
