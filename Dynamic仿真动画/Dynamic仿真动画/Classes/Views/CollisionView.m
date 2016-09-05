//
//  CollisionView.m
//  Dynamic仿真动画
//
//  Created by czbk on 16/6/27.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "CollisionView.h"

@interface CollisionView()<UICollisionBehaviorDelegate>

@end


@implementation CollisionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建横梁
        UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 400, 180, 30)];
        redView.backgroundColor = [UIColor redColor];
        [self addSubview:redView];
        
        //创建重力行为
        UIGravityBehavior *garvity = [[UIGravityBehavior alloc]initWithItems:@[self.boxView]];
        //把重力行为添加到
        [self.animator addBehavior:garvity];
        
        //添加碰撞检测行为,如果把redView添加这里后,两个会发生碰撞,然后,两个飞了起来
        //UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[self.boxView,redView]];
        UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[self.boxView]];
        
        
        //边界
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        //所以说,要手动添加边界,起点到终点
        [collision addBoundaryWithIdentifier:@"横梁" fromPoint:CGPointMake(0, 400) toPoint:CGPointMake(180, 400)];
        
        //设置代理
        collision.collisionDelegate = self;
        
        //添加
        [self.animator addBehavior:collision];
        
        
    }
    return self;
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p{

    //
    NSLog(@"我碰到了");
}

@end
