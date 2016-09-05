//
//  BasicView.m
//  Dynamic仿真动画
//
//  Created by czbk on 16/6/27.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "BasicView.h"

@implementation BasicView

//重写initwithFrame方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTile"]];
        
        //创建方框
        UIImageView *boxView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Box1"]];
        
        //位置
        boxView.center = CGPointMake(self.center.x, 120);
        
        //添加
        [self addSubview:boxView];
        
        //创建仿真者
        UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
        
        //赋值
        self.boxView = boxView;
        self.animator = animator;
    }
    return self;
}

@end
