//
//  PushView.m
//  Dynamic仿真动画
//
//  Created by czbk on 16/6/27.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "PushView.h"

@interface PushView()

@property (weak,nonatomic) UIImageView *maskImageView;  //图片

@property (assign,nonatomic) CGPoint endPoint;  //终点

@property (strong,nonatomic) UIPushBehavior *push;    //推动行为

@end

@implementation PushView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(10, 300, 50, 50)];
        blueView.backgroundColor = [UIColor blueColor];
        [self addSubview:blueView];
        
        
        //创建小黑圈图片
        UIImageView *maskImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AttachmentPoint_Mask"]];
        
        //默认隐藏
        maskImageView.hidden = YES;
        
        //添加
        [self addSubview:maskImageView];
        
        //赋值
        self.maskImageView = maskImageView;
        
        //创建拖拽的手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
        
        //添加手势
        [self addGestureRecognizer:pan];
        
        //创建推动行为
        /*
         UIPushBehaviorModeContinuous,  //持续推
         UIPushBehaviorModeInstantaneous    //推一次
         */                                                            //推动的对象
        UIPushBehavior *push = [[UIPushBehavior alloc]initWithItems:@[self.boxView] mode:UIPushBehaviorModeInstantaneous];
        
        //把推动行为添加到
        [self.animator addBehavior:push];
        
        //赋值
        self.push = push;
        
        //添加碰撞检测行为,要检测的对象
        UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[self.boxView,blueView]];
        
        //碰撞边界
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        //把碰撞检测添加
        [self.animator addBehavior:collision];
    }
    return self;
}

-(void)panGestureRecognizer:(UIPanGestureRecognizer*)pan{
    //鼠标当前点击的位置
    CGPoint currentPoint = [pan locationInView:self];
    
    if(pan.state == UIGestureRecognizerStateBegan){
        //显示黑色圆点
        self.maskImageView.hidden = NO;
        
        //位置是鼠标当前的点击的位置
        self.maskImageView.center = currentPoint;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        //保存鼠标移动到某个位置的点
        self.endPoint = currentPoint;
        
        //重绘
        [self setNeedsDisplay];
    }else if(pan.state == UIGestureRecognizerStateEnded){
        //鼠标离开,隐藏黑色圆点
        self.maskImageView.hidden = YES;
        
        //设置推动的方向跟力度
        CGFloat offsetX = self.maskImageView.center.x - self.endPoint.x;
        CGFloat offsetY = self.maskImageView.center.y - self.endPoint.y;
        
        //计算斜边的长度,也就是两个点之间的距离
        CGFloat distance = hypot(offsetX, offsetY);
        
        //计算角度
        CGFloat angle = atan2(offsetY, offsetX);
        
        //方向
        self.push.angle = angle;
        
        //力度
        self.push.magnitude = distance;
        
        //生效
        self.push.active = YES;
        
        //清除线,把起点终点设为0,并重绘
        self.maskImageView.center = CGPointZero;
        self.endPoint = CGPointZero;
        [self setNeedsDisplay];
    }
}

//绘制
-(void)drawRect:(CGRect)rect{
    //路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    //起点是黑色圆圈的中心点
    [bezierPath moveToPoint:self.maskImageView.center];
    
    //终点
    [bezierPath addLineToPoint:self.endPoint];
    
    //设置线条属性
    bezierPath.lineWidth = 10;
    bezierPath.lineCapStyle = kCGLineCapRound;
    //渲染
    [bezierPath stroke];

}

@end
