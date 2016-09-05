//
//  SnapView.m
//  Dynamic仿真动画
//
//  Created by czbk on 16/6/27.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "SnapView.h"

@interface SnapView()

@property (nonatomic,strong) UISnapBehavior *snapBehavior;  //吸附行为/

@end

@implementation SnapView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建轻触的手势识别器
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        
        //把手势添加到
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)tap:(UITapGestureRecognizer*)tap{
    //点击的位置
    CGPoint location = [tap locationInView:self];
    
    //修改吸附行为的吸附点
    self.snapBehavior.snapPoint = location;
    
    //把吸附行为添加给仿真者
    [self.animator addBehavior:self.snapBehavior];
}

//如果不适用懒加载的话,第一次会吸附过来,但是,第二次的话,无反应
//方式一 懒加载
//方式二 响应事件的时候,先删除吸附行为

#pragma mark -懒加载吸附行为
-(UISnapBehavior *)snapBehavior{
    if(nil == _snapBehavior){
        _snapBehavior = [[UISnapBehavior alloc]initWithItem:self.boxView snapToPoint:CGPointZero];
        
        //振幅,晃动的大小,值越大,晃动越小
        _snapBehavior.damping = 0.5;
    }
    return _snapBehavior;
}

@end
