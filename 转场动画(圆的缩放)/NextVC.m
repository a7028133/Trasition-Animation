//
//  NextVC.m
//  转场动画(圆的缩放)
//
//  Created by ZH on 17/4/7.
//  Copyright © 2017年 ZH. All rights reserved.
//

#import "NextVC.h"
#import "PingInvertTransition.h"
#import "ThirdVC.h"

@interface NextVC ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UILabel *myLab;
@property(nonatomic,strong)UIButton *pushBtn;
@property(nonatomic,strong)UIButton *popBtn;
@end

@implementation NextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.myLab];
    [self.view addSubview:self.pushBtn];
    [self.view addSubview:self.popBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
//    NSLog(@"尾页跳回");
    if (operation == UINavigationControllerOperationPop) {
        PingInvertTransition *pingInvert = [PingInvertTransition new];
        return pingInvert;
    }else{
        return nil;
    }
}

-(void)pushBtnAction{
    ThirdVC *thirdVC = [[ThirdVC alloc]init];
    [self.navigationController pushViewController:thirdVC animated:YES];
}

-(void)popBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
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
        _pushBtn.frame = CGRectMake(0, 0, 100, 30);
        _pushBtn.center = CGPointMake(self.view.frame.size.width/2+50, self.view.frame.size.height/2);
        _pushBtn.backgroundColor = [UIColor purpleColor];
        [_pushBtn setTitle:@"Push" forState:UIControlStateNormal];
        [_pushBtn addTarget:self action:@selector(pushBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushBtn;
}

-(UIButton *)popBtn{
    if (!_popBtn) {
        _popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _popBtn.frame = CGRectMake(0, 0, 100, 30);
        _popBtn.center = CGPointMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2);
        _popBtn.backgroundColor = [UIColor purpleColor];
        [_popBtn setTitle:@"Pop" forState:UIControlStateNormal];
        [_popBtn addTarget:self action:@selector(popBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popBtn;
}
@end
