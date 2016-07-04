//
//  IMYAOPDemo.m
//  YYKitDemo
//
//  Created by ljh on 16/6/19.
//  Copyright © 2016年 ibireme. All rights reserved.
//

#import "IMYAOPDemo.h"
#import "SuperBrandTableViewCell.h"
#import "OthersTableViewCell.h"

@interface IMYAOPDemo () <IMYAOPTableViewDelegate, IMYAOPTableViewDataSource>

@property (nonatomic, strong) NSMutableArray *positonArr;

@end

@implementation IMYAOPDemo
- (void)setAopUtils:(IMYAOPTableViewUtils *)aopUtils
{
    _aopUtils = aopUtils;
    [self injectTableView];
}

- (NSMutableArray *)positonArr
{
    if (!_positonArr) {
        _positonArr = [NSMutableArray array];
    }
    return _positonArr;
}


- (void)injectTableView
{
    //广告回调，跟TableView的Delegate，DataSource 一样。
    self.aopUtils.delegate = self;
    self.aopUtils.dataSource = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self insertRows];
    });
}
//简单的rows插入
- (void)insertRows
{
    NSMutableArray<IMYAOPTableViewInsertBody*>* insertBodys = [NSMutableArray array];
    //随机生成了5个要插入的位置
    [self.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        SuperBrandDataModel *model1 = (SuperBrandDataModel *)obj;
        NSLog(@"position = %@ ,index = %d",model1.position,idx);
        [self.positonArr addObject:model1.position];
    }];
    NSArray *arr = _positonArr;

    for (int i = 0 ; i< arr.count; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[arr[i] intValue] inSection:0];
        
        [insertBodys addObject:[IMYAOPTableViewInsertBody insertBodyWithIndexPath:indexPath]];
    }

    ///清空 旧数据
    [self.aopUtils insertWithSections:nil];
    [self.aopUtils insertWithIndexPaths:nil];
    
    ///插入 新数据, 同一个 row 会按数组的顺序 row 进行 递增
    [self.aopUtils insertWithIndexPaths:insertBodys];

    ///调用tableView的reloadData，进行页面刷新
    [self.aopUtils.tableView reloadData];
}

/**
 *      插入sections demo
 *      单纯插入section 是没法显示的，要跟 row 配合。
 */
- (void)insertSections
{
    NSMutableArray<IMYAOPTableViewInsertBody*>* insertBodys = [NSMutableArray array];
    for (int i = 1 ; i< 6; i++) {
        NSInteger section = arc4random() % i;
        IMYAOPTableViewInsertBody* body = [IMYAOPTableViewInsertBody insertBodyWithSection:section];
        [insertBodys addObject:body];
    }
    [self.aopUtils insertWithSections:insertBodys];
    
    [insertBodys enumerateObjectsUsingBlock:^(IMYAOPTableViewInsertBody * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.indexPath = [NSIndexPath indexPathForRow:0 inSection:obj.resultSection];
    }];
    [self.aopUtils insertWithIndexPaths:insertBodys];
    
    [self.aopUtils.tableView reloadData];
}

#pragma mark-AOP Delegate
- (void)aopTableUtils:(IMYAOPTableViewUtils *)tableUtils numberOfSection:(NSInteger)sectionNumber
{
    ///可以获取真实的 sectionNumber 可以在这边进行一些AOP的数据初始化
}
-(void)aopTableUtils:(IMYAOPTableViewUtils *)tableUtils willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///真实的 will display 回调. 有些时候统计需要
}

#pragma mark- UITableView 回调
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = nil;
    SuperBrandDataModel *superModel = [[SuperBrandDataModel alloc] init];
    
    for (NSInteger k = 0; k < _positonArr.count; k ++) {
        if (indexPath.row == [_positonArr[k] integerValue]) {
            superModel = _dataArr[k];
        }
    }
    
    cellID = superModel.cellIdentifier;
    if ([cellID isEqualToString:@"superbrand"]) {
        SuperBrandTableViewCell *cell = [SuperBrandTableViewCell cellWithTableView:tableView];
        [cell fillCellWithModel:superModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGBCOLOR(240, 240, 240);
        return cell;
    }else{
        OthersTableViewCell *cell = [OthersTableViewCell cellWithTableView:tableView];
        [cell fillCellWithModel:superModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGBCOLOR(240, 240, 240);
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 360;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"插入的cell要显示啦 : = %ld", (long)indexPath.row);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"被点击了> <" message:[NSString stringWithFormat:@"我的位置: %@",indexPath] delegate:nil cancelButtonTitle:@"哦~滚" otherButtonTitles:nil];
    [alertView show];
}
@end
