//
//  CustomPresentAnimationCotroller.h
//  ZFJianShuTransition
//
//  Created by macOne on 16/1/5.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomPresentAnimationCotroller : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, getter=isDismissed,assign) BOOL dismiss;

@end
