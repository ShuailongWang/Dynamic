//
//  SpringView.m
//  Dynamic仿真动画
//
//  Created by czbk on 16/6/27.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "SpringView.h"

@interface SpringView()

@property (weak,nonatomic) UIImageView *anchorimageView;
@property (weak,nonatomic) UIImageView *offsetImage;
@property (strong,nonatomic) UIAttachmentBehavior *attachment;

@end

@implementation SpringView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //附着点
        CGPoint anchorP = CGPointMake(self.center.x, 280);
        
        //被附着的点
        UIOffset offset = UIOffsetMake(10, 10);
        
        //创建弹性附着行为
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc]initWithItem:self.boxView offsetFromCenter:offset attachedToAnchor:anchorP];
        
        //振幅
        attachment.damping = 0.5;
        
        //频率
        attachment.frequency = 0.7;
        
        //赋值
        self.attachment = attachment;
        
        //添加给仿真者
        [self.animator addBehavior:attachment];
        
        //加载图片
        UIImage *image = [UIImage imageNamed:@"AttachmentPoint_Mask"];
        
        //创建附着点(外面)上的圆圈图片
        UIImageView *anchorimageView = [[UIImageView alloc]initWithImage:image];
        
        //位置
        anchorimageView.center = anchorP;
        
        //添加
        [self addSubview:anchorimageView];
        
        //赋值
        self.anchorimageView = anchorimageView;
        
        //创建boxView上面的圆圈图片
        UIImageView *offsetImage = [[UIImageView alloc]initWithImage:image];
        
        //位置
        offsetImage.center = CGPointMake(self.boxView.bounds.size.width/2 + offset.horizontal, self.boxView.bounds.size.height/2 + offset.vertical);
        
        //添加到boxView上
        [self.boxView addSubview:offsetImage];
        
        //赋值
        self.offsetImage = offsetImage;
        
        //创建手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
        //添加手势
        [self addGestureRecognizer:pan];
        
        //方式一
//        //定时器
//        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(playTime)];
//        //
//        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        
        //方式二   KVO
        
        /*
         监听
         self.boxview   监听的对象
         oberver        负责监听的对象
         keyPath        监听的属性
         options        监听的值    (新,旧值)
         context        上下文 ,,删除的时候,可以根据具体的值,删除
         
         NSKeyValueObservingOptionNew = 0x01,   //新值
         NSKeyValueObservingOptionOld = 0x02,   //旧值
         */
        [self.boxView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

//实现KVO的监听方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    //重新绘制
    [self setNeedsDisplay];
}
//结束后,删除监听
-(void)dealloc{
    [self.boxView removeObserver:self forKeyPath:@"center"];
}

//pan的方法
-(void)panGestureRecognizer:(UIPanGestureRecognizer*)pan{
    //当前的点
    CGPoint loc = [pan locationInView:self];
    
    //修改附着点
    self.attachment.anchorPoint = loc;
    
    //修改附着点上的图片位置
    self.anchorimageView.center = loc;
    
    //重新绘制
    [self setNeedsDisplay];
}

-(void)playTime{
    //重新绘制
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    //
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    //起点
    [bezierPath moveToPoint:self.anchorimageView.center];
    
    //终点
    //转换
    CGPoint point = [self convertPoint:self.offsetImage.center fromView:self.boxView];
    [bezierPath addLineToPoint:point];
    
    //
    bezierPath.lineWidth = 5;
    
    //
    [bezierPath stroke];
}

















@end
