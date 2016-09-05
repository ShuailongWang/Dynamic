//
//  BasicController.h
//  Dynamic仿真动画
//
//  Created by czbk on 16/6/27.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    basicViewSnap,
    basicViewPush,
    basicViewAttachment,
    basicViewSpring,
    basicViewCollision,
}dynamicBehavior;

@interface BasicController : UIViewController

@property (assign,nonatomic) dynamicBehavior basicIndex;

@end
