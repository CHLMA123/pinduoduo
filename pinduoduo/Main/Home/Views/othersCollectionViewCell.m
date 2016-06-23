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
        //150 *280
        self.goodsImageV = [[UIImageView alloc]init];
        self.goodsImageV.frame = CGRectMake(0, 10, 150, 150);
        self.goodsImageV.layer.borderWidth = 1;
        
        self.imageLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 180, 140, 60)];
        self.imageLbl.textAlignment = NSTextAlignmentLeft;
        self.imageLbl.textColor = [UIColor blackColor];
        self.imageLbl.font = [UIFont systemFontOfSize:15];
        self.imageLbl.numberOfLines = 3;
        
        self.priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, 150, 30)];
        self.priceLbl.textAlignment = NSTextAlignmentLeft;
        self.priceLbl.textColor = [UIColor redColor];
        self.priceLbl.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:self.goodsImageV];
        [self addSubview:self.imageLbl];
        [self addSubview:self.priceLbl];
    }
    return self;
}

- (void)commitInitData{
    
}

@end
