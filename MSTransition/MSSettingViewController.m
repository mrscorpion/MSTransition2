//
//  MSSettingViewController.m
//  MSTransition
//
//  Created by mr.scorpion on 16/7/15.
//  Copyright © 2016年 mrscorpion. All rights reserved.
//

#import "MSSettingViewController.h"
#import "MSTransition-Swift.h"
#import "ViewController.h"
#import "CopyiPhoneFadeView.h"

@interface MSSettingViewController ()
<
UIViewControllerTransitioningDelegate,
LTMorphingLabelDelegate
>
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) StarWarsUIViewAnimator *animator; // ※
//@property (nonatomic, strong) StarWarsGLAnimator *animator;
//@property (nonatomic, strong) StarWarsUIDynamicAnimator *animator;
@property (nonatomic, strong) LTMorphingLabel *label;
@property (strong, nonatomic) CopyiPhoneFadeView *iphoneFade;
@end

@implementation MSSettingViewController
- (LTMorphingLabel *)label
{
    if (!_label) {
        _label =[[LTMorphingLabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _label.delegate = self;
        _label.morphingEffect = LTMorphingEffectBurn;
        _label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0]; //[UIColor colorWithRed:245./255. green:58./255. blue:93./255. alpha:0.7]; //[UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:20];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"正在加温";
        [_label BurnLoad];
    }
    return _label;
}
- (CopyiPhoneFadeView *)iphoneFade
{
    if (!_iphoneFade) {
        _iphoneFade = [[CopyiPhoneFadeView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _iphoneFade.text = @"正在加温";
        _iphoneFade.foreColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.3];//[UIColor yellowColor];//[UIColor whiteColor];
        _iphoneFade.backColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0]; //[UIColor colorWithRed:245./255. green:58./255. blue:93./255. alpha:0.7];//KmainColorApp; //[UIColor redColor];
        _iphoneFade.font = [UIFont systemFontOfSize:20];
        _iphoneFade.alignment = NSTextAlignmentCenter;
//        _iphoneFade.center = CGPointMake(self.view.bounds.size.width/2.0, kMainNavgationBarHeight + 40);
    }
    return _iphoneFade;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popSelf)];
    self.animator = [[StarWarsUIViewAnimator alloc] init]; //[[StarWarsGLAnimator alloc] init];// [[StarWarsGLAnimator alloc] init];
    [self.view addGestureRecognizer:tap];
}
- (void)popSelf
{
    [self.view addSubview:self.label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [self.label removeFromSuperview];
        self.label = nil;
        [self.view addSubview:self.iphoneFade];
        [self.iphoneFade iPhoneFadeWithDuration:3];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        self.transitioningDelegate = self;
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}
- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backImageView.image = [UIImage imageNamed:@"Photo_dark"];
    }
    return _backImageView;
}
//
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//{
//    return self.animator;
//}
//
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.animator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
