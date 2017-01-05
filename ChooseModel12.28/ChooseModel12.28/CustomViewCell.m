//
//  CustomViewCell.m
//  UICollectionViewDemo
//
//  Created by li on 2016/12/28.
//  Copyright © 2016年 RYT. All rights reserved.
//

#import "CustomViewCell.h"


@interface CustomViewCell ()


@end



@implementation CustomViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addMyUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _cellBtn.frame = self.bounds;
}

- (void)addMyUI{
    [self.contentView addSubview:self.cellBtn];
}

- (void)buttonClick:(UIButton*)event{
    NSLog(@"123");
    
}

- (UIButton*)cellBtn{
    if (_cellBtn == nil) {
        _cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cellBtn.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        _cellBtn.backgroundColor = [UIColor orangeColor];
        [_cellBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cellBtn;
}


@end
