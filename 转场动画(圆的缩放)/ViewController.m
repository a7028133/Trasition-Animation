//
//  ViewController.m
//  转场动画(圆的缩放)
//
//  Created by ZH on 17/4/7.
//  Copyright © 2017年 ZH. All rights reserved.
//

#import "ViewController.h"
#import "PingTransition.h"
#import "NextVC.h"

@interface ViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UILabel *myLab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.myLab];
    [self.view addSubview:self.pushBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}


-(void)pushBtnAction{
    NextVC *nextVC = [[NextVC alloc]init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        PingTransition *ping = [PingTransition new];
        return ping;
    }else{
        return nil;
    }
}

-(UILabel *)myLab{
    if (!_myLab) {
        _myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        _myLab.backgroundColor = [UIColor cyanColor];
        _myLab.text = @"我是参照物";
    }
    return _myLab;
}

-(UIButton *)pushBtn{
    if (!_pushBtn) {
        _pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pushBtn.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-32-15, 100, 30);
        _pushBtn.backgroundColor = [UIColor purpleColor];
        [_pushBtn setTitle:@"push" forState:UIControlStateNormal];
        [_pushBtn addTarget:self action:@selector(pushBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushBtn;
}

@end
