//
//  ZPCircleProgressView.h
//  IOSAnimationCombination
//
//  Created by 吴桐 on 2017/11/14.
//  Copyright © 2017年 kfzx－wut. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EventHandler)(id sender);

@interface ZPCircleProgressView : UIView
///点击跳过block
@property (nonatomic,copy) EventHandler jumpOutBlock;
///倒计时完成block
@property (nonatomic,copy) EventHandler completeBlock;

//设置字体大小，以及label名称
-(void)setFontSize:(float)fontSize
           andName:(NSString *)labelName;

//设置动画时长，秒
-(void)setAnimationWithSecond:(CGFloat)time;
@end
