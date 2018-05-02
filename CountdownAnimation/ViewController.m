//
//  ViewController.m
//  CountdownAnimation
//
//  Created by 吴桐 on 2018/5/2.
//  Copyright © 2018年 tong.wu. All rights reserved.
//

#import "ViewController.h"
#import "ZPCircleProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建倒计时
    ZPCircleProgressView * countdown= [[ZPCircleProgressView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 80)/2 , ([UIScreen mainScreen].bounds.size.height - 80)/2, 80, 80)];
    //设置倒计时长为5秒
    [countdown setAnimationWithSecond:5];
    //设置点击跳过后的block
    __weak __typeof(countdown) weakCd = countdown;
    countdown.jumpOutBlock = ^(id sender) {
        NSLog(@"点击了跳过，移除动画");
        [weakCd removeFromSuperview];
    };
    //设置倒计时完成后的block
    countdown.completeBlock = ^(id sender) {
        NSLog(@"倒计时完成");
        
    };
    //设置字体大小
    [countdown setFontSize:16 andName:@"跳过"];
    [self.view addSubview:countdown];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
