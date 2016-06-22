//
//  GroupBuyView.m
//  pinduoduo
//
//  Created by MCL on 16/6/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "GroupBuyView.h"
#import "MobileAppGroupsModel.h"

@interface GroupBuyView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *goodsimageV;
@property (nonatomic, strong) UIImageView *descimageV;
@property (nonatomic, strong) UILabel *descLbl;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) NSString *inputStr;
@property (nonatomic, strong) MobileAppGroupsModel *model;

@end

@implementation GroupBuyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInitView];
    }
    return self;
}

- (void)commitInitView{
    self.backgroundColor = [UIColor whiteColor];
    
    _goodsimageV = [[UIImageView alloc] init];
//    _goodsimageV.image = [UIImage imageNamed:@"default_mall_logo"];
    
    _descimageV = [[UIImageView alloc] init];
    _descimageV.image = [UIImage imageNamed:@"question_mark"];
    
    _descLbl = [[UILabel alloc] init];
    _descLbl.textColor = [UIColor blackColor];
//    _descLbl.text = self.model.desc;
//    _descLbl.backgroundColor = [UIColor blueColor];
    _descLbl.textAlignment = NSTextAlignmentLeft;
    _descLbl.font = [UIFont systemFontOfSize:15];
    _descLbl.numberOfLines = 0;
    
    _inputTextField = [[UITextField alloc] init];
    _inputTextField.layer.cornerRadius = 3;
    _inputTextField.layer.borderWidth = 0.5;
    _inputTextField.layer.borderColor = [UIColor redColor].CGColor;
    _inputTextField.delegate = self;
    _inputTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _inputTextField.leftViewMode = UITextFieldViewModeAlways;
    _inputTextField.textAlignment = NSTextAlignmentLeft;
    _inputTextField.font = [UIFont systemFontOfSize:15];
    _inputTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _inputTextField.returnKeyType = UIReturnKeyDone;
    _inputTextField.placeholder = @"请输入“参团专享码”";
    _inputTextField.backgroundColor = [UIColor whiteColor];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.backgroundColor = [UIColor redColor];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    _confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    CGRect rect = CGRectMake(0, 0, 75, 30);
    CGSize ratio = CGSizeMake(3, 3);
    UIRectCorner corner = UIRectCornerTopRight | UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:ratio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc] init];
    masklayer.frame = _confirmBtn.bounds;
    masklayer.path = path.CGPath;
    _confirmBtn.layer.mask = masklayer;
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    [self addGestureRecognizer:tap];
    
    [self addSubview:_goodsimageV];
    [self addSubview:_descimageV];
    [self addSubview:_descLbl];
    [self addSubview:_inputTextField];
    [self addSubview:_confirmBtn];
    
    [self setupData];
}

- (void)setupData{
    [_goodsimageV sd_setImageWithURL:[NSURL URLWithString:self.model.thumb_url] placeholderImage:[UIImage imageNamed:@"default_load"]];
    _descLbl.text = self.model.desc;
}

- (void)layoutSubviews{
    [self.goodsimageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.mas_offset(10);
        make.left.mas_equalTo(self.mas_left).with.mas_offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).with.mas_offset(-10);
        make.width.mas_equalTo(65);
    }];
    [self.descimageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.mas_offset(15);
        make.left.mas_equalTo(self.goodsimageV.mas_right).with.mas_offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.mas_offset(10);
        make.left.mas_equalTo(self.descimageV.mas_right).with.mas_offset(5);
        make.right.mas_equalTo(self.mas_right).with.mas_offset(-10);
        make.height.mas_equalTo(25);
    }];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLbl.mas_bottom).with.mas_offset(5);
        make.left.mas_equalTo(self.descimageV.mas_left);
        make.right.mas_equalTo(self.confirmBtn.mas_left).with.mas_offset(2);
        make.height.mas_equalTo(30);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputTextField);
        make.width.mas_equalTo(75);
        make.right.mas_equalTo(self.mas_right).with.mas_offset(-10);
        make.height.mas_equalTo(30);
    }];
}

- (void)hiddenKeyboard{

    [self endEditing:YES];
}

- (void)confirmAction{
    NSLog(@"confirmAction");
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    [textField becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    textField.textColor = RGBCOLOR(100, 100, 100);
    self.inputStr = textField.text;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (UpdateViewBlock)block
{
    if (_block == nil) {
        
//        __weak typeof(GroupBuyView) *weakself = self;
        __block GroupBuyView *weakSelf = self;
        _block = ^(MobileAppGroupsModel *model){
            
            weakSelf.model = model;
            [weakSelf setupData];
            NSLog(@" model.desc = %@ ",model.desc);
            
        };
    }
    
    return _block;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
