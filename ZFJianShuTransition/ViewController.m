//
//  ViewController.m
//  ZFJianShuTransition
//
//  Created by macOne on 16/1/5.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CustomPresentAnimationCotroller.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    
    //add a button
    UIButton *btnNext = [UIButton new];
    btnNext.frame = CGRectMake((self.view.bounds.size.width - 100)/2, self.view.center.y, 100, 50);
    btnNext.titleLabel.font = [UIFont  boldSystemFontOfSize:14.0f];
    [btnNext setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnNext setTitle:@"下一个转场" forState:UIControlStateNormal];
    [btnNext addTarget:self action:@selector(presentNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNext];
}

-(void)presentNext:(UIButton *)sender{
    
    SecondViewController *secondVC =[SecondViewController new];
    //blow ios 7.0 can use UIModalPresentationCurrentContext
    secondVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    secondVC.transitioningDelegate = self;
    
    [self presentViewController:secondVC animated:YES completion:NULL];
}

#pragma mark -UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    CustomPresentAnimationCotroller *presentAnimation = [CustomPresentAnimationCotroller new];
    presentAnimation.dismiss = NO;
    return presentAnimation;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    CustomPresentAnimationCotroller *presentAnimation = [CustomPresentAnimationCotroller new];
    presentAnimation.dismiss = YES;
    return presentAnimation;
}


@end
