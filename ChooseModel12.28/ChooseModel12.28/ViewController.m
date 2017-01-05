//
//  ViewController.m
//  ChooseModel12.28
//
//  Created by li on 2016/12/28.
//  Copyright © 2016年 RYT. All rights reserved.
//

#import "ViewController.h"
#import "CustomViewCell.h"
#import "CustomHeaderView.h"



static NSString *cellID = @"cellID";
static NSString *HeaderID = @"header";
static NSString *FooterID = @"footer";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

// 使用sb视图中的FlowLayout
@property (nonatomic,strong) UICollectionViewFlowLayout         *flowLayout;
@property (nonatomic,strong) UICollectionView                   *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"首页";

    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self judgementIsIOS_9AnderLater];
    //注册cell   header    footer
    [self registCellHeaderViewAndFooterView];

}

- (void)judgementIsIOS_9AnderLater{
    // 判断系统版本9.0以后才有这个功能
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        // 当前组如果还在可视范围时让头部视图停留
        self.flowLayout.sectionHeadersPinToVisibleBounds = YES;
        // 当前组如果还在可视范围时让尾部视图停留
        self.flowLayout.sectionFootersPinToVisibleBounds = YES;
    }
}

- (void)registCellHeaderViewAndFooterView{
    //----********CELL*********************--------// 注册cell
    [self.collectionView registerClass:[CustomViewCell class] forCellWithReuseIdentifier:cellID];
    //----********注册头部和尾部*********************--------// 注册头部
    [self.collectionView registerClass:[CustomHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    // 如果有class来注册这个头部或尾部视图时一定要用代码的方式去设置下这个头部或尾部的尺寸 // 加载的时候会根据字符串来判断是头还是尾
    self.flowLayout.headerReferenceSize = CGSizeMake(50, 50);//区头的大小
    //----********注册头部和尾部*********************--------// 注册尾部
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID];
    self.flowLayout.footerReferenceSize = CGSizeMake(50, 50);//区尾的大小
    
}



- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    cell.contentView.alpha = 0;
    cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0, 0), 0);
    
    [UIView animateKeyframesWithDuration:.5 delay:0.0 options:0 animations:^{
        /**
         *  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
         */
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^{
            cell.contentView.alpha = .5;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.2, 1.2), 0);
            
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = 1;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), 0);
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}


// 返回格子有多少组,这里自定义有5组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 20;
}

// 返回每组有多少个格子,自定义每组有15个格子
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 120;
}

//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];//取消选中

}

// 返回每一个格子长什么内容:5组,每组15个
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell,需要提前注册
    CustomViewCell *cell = (CustomViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    
    
    // 3.返回cell
    return cell;
}

// 返回每一组的头部或尾部视图
// 会自动的在每一组的头部和尾部加上这个视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // 如果当前想要的是头部视图
    // UICollectionElementKindSectio nHeader是一个const修饰的字符串常量,所以可以直接使用==比较
    if (kind == UICollectionElementKindSectionHeader) {
        CustomHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
        

        headerView.backgroundColor = [UIColor greenColor];
        return headerView;
    } else { // 返回每一组的尾部视图
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID forIndexPath:indexPath];
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(110, 0, 100, 50);
        nameLabel.text = @"不良人";
        nameLabel.backgroundColor = [UIColor brownColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;

        [footerView addSubview:nameLabel];

        footerView.backgroundColor = [UIColor magentaColor];
        return footerView;
    }

}


- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.flowLayout];
        _collectionView.scrollEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.prefetchingEnabled = false;//预加载指令
        
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        // 当滚动方向发生颠倒时头或尾的尺寸设置也会发生颠倒
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    }
    return _flowLayout;
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
