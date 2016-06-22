//
//  MCollectionViewCell.m
//  DXAlertView
//
//  Created by MCL on 16/4/16.
//  Copyright © 2016年 xiekw. All rights reserved.
//

#import "MItemCollectionViewCell.h"

@implementation MItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imageView.frame = CGRectMake(10, 10, 60, 60);
        self.imageView.center = CGPointMake(self.contentView.center.x,self.contentView.center.y - 10);
        [self addSubview:self.imageView];
        self.imageLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height- 30,frame.size.width, 20)];
        self.imageLbl.textAlignment = NSTextAlignmentCenter;
        self.imageLbl.textColor = [UIColor blackColor];
        self.imageLbl.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.imageLbl];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
//    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    _imageView.layer.borderWidth = 0.5;
    return _imageView;
}
@end
