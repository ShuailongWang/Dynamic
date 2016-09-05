//
//  BasicController.m
//  Dynamic仿真动画
//
//  Created by czbk on 16/6/27.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "BasicController.h"
#import "BasicView.h"
#import "SnapView.h"
#import "PushView.h"
#import "AttachmentView.h"
#import "SpringView.h"
#import "CollisionView.h"

@interface BasicController ()

@end

@implementation BasicController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

-(void)setBasicIndex:(dynamicBehavior)basicIndex{
    _basicIndex = basicIndex;
    
    //创建view
    BasicView *basicView;
    switch (basicIndex) {
        case basicViewSnap:
            basicView = [[SnapView alloc]initWithFrame:self.view.bounds];
            break;
        case basicViewPush:
            basicView = [[PushView alloc]initWithFrame:self.view.bounds];
            break;
        case basicViewAttachment:
            basicView = [[AttachmentView alloc]initWithFrame:self.view.bounds];
            break;
        case basicViewSpring:
            basicView = [[SpringView alloc]initWithFrame:self.view.bounds];
            break;
        case basicViewCollision:
            basicView = [[CollisionView alloc]initWithFrame:self.view.bounds];
            break;
        default:
            break;
    }
    //添加view
    [self.view addSubview:basicView];
}

@end
