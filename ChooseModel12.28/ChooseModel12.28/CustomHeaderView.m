//
//  CustomHeaderView.m
//  UICollectionViewDemo
//
//  Created by li on 2017/1/3.
//  Copyright © 2017年 RYT. All rights reserved.
//

#import "CustomHeaderView.h"

@interface CustomHeaderView (){
    UILabel *nameLabel;
}

@end


@implementation CustomHeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"画江湖";
        nameLabel.backgroundColor = [UIColor orangeColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    nameLabel.frame = CGRectMake(self.frame.size.width/2-50, 0, 100, 50);

}





@end
