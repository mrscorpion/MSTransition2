//
//  ViewController.m
//  MSTransition
//
//  Created by mr.scorpion on 16/7/15.
//  Copyright © 2016年 mrscorpion. All rights reserved.
//

#import "ViewController.h"
#import "MSSettingViewController.h"
#import "MSTransition-Swift.h"   // 引入方式 【项目名称】+ 【-Swift.h】

@interface ViewController ()
<
UINavigationControllerDelegate,
UIViewControllerTransitioningDelegate
>
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) StarWarsUIDynamicAnimator *animator;
//@property (nonatomic, strong) StarWarsUIViewAnimator *animator;
//@property (nonatomic, strong) StarWarsGLAnimator *animator;
@end

@implementation ViewController
- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backImageView.image = [UIImage imageNamed:@"Photo_light"];
    }
    return _backImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"转场动画";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNext)];
    rightItem.tintColor = [UIColor whiteColor];
//    [rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:fontName size:fontSize]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    [self.view addSubview:self.backImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentToNext)];
    [self.view addGestureRecognizer:tap];
    
    self.animator = [[StarWarsUIDynamicAnimator alloc] init]; //[[StarWarsUIViewAnimator alloc] init]; //[[StarWarsGLAnimator alloc] init];
    self.navigationController.delegate = self;
}
- (void)presentToNext
{
    MSSettingViewController *settingVC = [[MSSettingViewController alloc] init];
    settingVC.transitioningDelegate = self;
    [self presentViewController:settingVC animated:YES completion:nil];
}
// present 和 dismiss 方法
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.animator;
}
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//    return self.animator;
//}



- (void)pushToNext
{
    MSSettingViewController *settingVC = [[MSSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
// push的方法
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    return self.animator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
