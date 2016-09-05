//
//  AttachmentView.m
//  Dynamic仿真动画
//
//  Created by czbk on 16/6/27.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "AttachmentView.h"

@interface AttachmentView()

@property (weak,nonatomic) UIImageView *achorImage;
@property (weak,nonatomic) UIImageView *offsetImage;
@property (weak,nonatomic) UIAttachmentBehavior *attachment;    //附着行为

@end

@implementation AttachmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //偏移的距离,从中心点偏移多少,被附着的点,boxView中的点
        UIOffset offset = UIOffsetMake(10, 10);
        
        //附着点,,外面的点
        CGPoint anchorPoint = CGPointMake(self.center.x, 280);
        
        //MARK: 创建刚性附着行为
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc]initWithItem:self.boxView offsetFromCenter:offset attachedToAnchor:anchorPoint];
        
        //添加刚性给仿真者
        [self.animator addBehavior:attachment];
        
        //振幅,
        //attachment.damping = 0.5;
        //频率,附着点与被附着点之间线,变弹簧,弹簧的力度,值越大,力度越大
        //attachment.frequency = 0.7;
        
        //赋值
        self.attachment = attachment;
        
        //MARK: 外面的图片
        UIImage *image = [UIImage imageNamed:@"AttachmentPoint_Mask"];
        //MARK:创建圆点图片
        UIImageView *achorImage = [[UIImageView alloc]initWithImage:image];
        
        //设置中心
        achorImage.center = anchorPoint;
        
        //添加
        [self addSubview:achorImage];
        
        //赋值
        self.achorImage = achorImage;
        
        //MARK: 创建boxView上面的圆圈图片
        UIImageView *offsetImageView = [[UIImageView alloc]initWithImage:image];
        
        //设置位置
        CGSize boxSize = self.boxView.bounds.size;
        offsetImageView.center = CGPointMake(boxSize.width/2 + offset.vertical,boxSize.height/2 + offset.horizontal);
        
        //添加
        [self.boxView addSubview:offsetImageView];
        
        //赋值
        self.offsetImage = offsetImageView;
        
        //MARK: -创建手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
        
        //添加手势
        [self addGestureRecognizer:pan];
    }
    return self;
}

-(void)panGestureRecognizer:(UIPanGestureRecognizer*)pan{
    //当前的点
    CGPoint loc = [pan locationInView:self];
    
    //修改附着点
    self.attachment.anchorPoint = loc;
    
    //修改图片的位置
    self.achorImage.center = loc;
    
    
    //重新绘制
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    //路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    //起点
    [bezierPath moveToPoint:self.achorImage.center];
    
    //终点
    CGPoint poin = [self convertPoint:self.offsetImage.center fromView:self.boxView];
    [bezierPath addLineToPoint:poin];
    
    //线
    bezierPath.lineWidth = 5;
    
    //渲染
    [bezierPath stroke];

}

@end
