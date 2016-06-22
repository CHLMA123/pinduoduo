//
//  othersCollectionViewCell.m
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "othersCollectionViewCell.h"

@implementation othersCollectionViewCell
// 360
/*
10
40
10
 
200
10
50
10
20
10
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.goodsImageV = [[UIImageView alloc]init];
        self.goodsImageV.frame = CGRectMake(0, 0, 200, 200);
        self.goodsImageV.layer.borderWidth = 1;
        self.goodsImageV.layer.borderColor = RGBCOLOR(100, 100, 100).CGColor;
        
        self.imageLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, 200, 50)];
        self.imageLbl.textAlignment = NSTextAlignmentCenter;
        self.imageLbl.textColor = [UIColor blackColor];
        self.imageLbl.font = [UIFont systemFontOfSize:13];
        self.imageLbl.numberOfLines = 0;
        
        self.priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 270, 200, 20)];
        self.priceLbl.textAlignment = NSTextAlignmentLeft;
        self.priceLbl.textColor = [UIColor redColor];
        self.priceLbl.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:self.goodsImageV];
        [self addSubview:self.imageLbl];
        [self addSubview:self.priceLbl];
        
        [self commitInitData];
    }
    return self;
}

- (void)commitInitData{
    
}

@end
