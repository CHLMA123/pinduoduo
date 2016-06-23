//
//  OthersTableViewCell.m
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "OthersTableViewCell.h"
#import "othersCollectionViewCell.h"
#import "GoodsSubjectModel.h"
#import "GoodsListDataModel.h"

static NSString *cellID = @"otherItem";

@interface OthersTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIButton *seeMoreBtn;
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) GoodsSubjectModel *subjectModel;
@property (nonatomic, strong) NSArray *goodsListArr;
@end

@implementation OthersTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commitInitData];
    }
    return self;
}

- (void)fillCellWithModel:(RecommendSubjectsModel *)model{
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    _subjectModel = model.goodSubjectModel;
    _goodsListArr = model.goodlistArr;
    
    self.bgView = [[UIView alloc] init];
    _bgView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 350);
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];

    self.titleLbl = [[UILabel alloc] init];
    _titleLbl.frame = CGRectMake(10, 10, SCREEN_WIDTH - 125 - 10, 60);
    _titleLbl.textColor = [UIColor blackColor];
    _titleLbl.textAlignment = NSTextAlignmentLeft;
    _titleLbl.text = _subjectModel.subject;
    _titleLbl.font = [UIFont systemFontOfSize:19];
    
    self.seeMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _seeMoreBtn.frame = CGRectMake(SCREEN_WIDTH - 115, 20, 105, 40);
    _seeMoreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_seeMoreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_seeMoreBtn setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [_seeMoreBtn setImageEdgeInsets: UIEdgeInsetsMake(0, 80, 0, 0)];
    [_seeMoreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [_seeMoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
    [_seeMoreBtn addTarget:self action:@selector(seeMoreAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(150, 300);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumInteritemSpacing = 10;
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH, 280) collectionViewLayout:_flowLayout];
    _collectionV.showsVerticalScrollIndicator = NO;
    _collectionV.showsHorizontalScrollIndicator = NO;
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    _collectionV.backgroundColor = [UIColor whiteColor];
    [_collectionV registerClass:[othersCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
    [self.contentView addSubview:_titleLbl];
    [self.contentView addSubview:_seeMoreBtn];
    [self.contentView addSubview:_collectionV];
}

- (void)seeMoreAction{
    
    NSLog(@"seeMoreAction");
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"点击的item---%zd",indexPath.item);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
//    return self.goodsListArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    othersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    GoodsListDataModel *goodsModel = [[GoodsListDataModel alloc] init];
    goodsModel = self.goodsListArr[indexPath.item];
    [cell.goodsImageV sd_setImageWithURL:[NSURL URLWithString:goodsModel.thumb_url] placeholderImage:[UIImage imageNamed:@"default_square"]];
    cell.imageLbl.text = goodsModel.goods_name;
    NSString *priceStr = goodsModel.price;
    CGFloat price = [priceStr floatValue]/100.0;
    cell.priceLbl.text = [NSString stringWithFormat:@"¥ %2f", price];
    
    return cell;
}


- (void)commitInitData{
    self.subjectModel = [[GoodsSubjectModel alloc] init];
    self.goodsListArr = [NSArray array];
    
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
