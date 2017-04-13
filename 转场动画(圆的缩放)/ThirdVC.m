//
//  ThirdVC.m
//  转场动画(圆的缩放)
//
//  Created by ZH on 17/4/12.
//  Copyright © 2017年 ZH. All rights reserved.
//

#import "ThirdVC.h"

@interface ThirdVC ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UILabel *myLab;
@property(nonatomic,strong)UIButton *popBtn;
@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第三页";
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor orangeColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.myLab];
    [self.view addSubview:self.popBtn];
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

-(UIButton *)popBtn{
    if (!_popBtn) {
        _popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _popBtn.frame = CGRectMake(0, 0, 100, 30);
        _popBtn.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _popBtn.backgroundColor = [UIColor purpleColor];
        [_popBtn setTitle:@"Pop" forState:UIControlStateNormal];
        [_popBtn addTarget:self action:@selector(popBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popBtn;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
