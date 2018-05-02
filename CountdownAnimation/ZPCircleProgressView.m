//
//  ZPCircleProgressView.m
//  IOSAnimationCombination
//
//  Created by wt on 2017/11/14.
//  Copyright © 2017年 kfzx－wut. All rights reserved.
//

#import "ZPCircleProgressView.h"

@interface ZPCircleProgressView ()<CAAnimationDelegate>
/// 基座圆
@property (nonatomic, strong)CAShapeLayer *bigBaseLayer;
/// 带颜色的圆
@property (nonatomic, strong)CAShapeLayer *bigShapeLayer;
/// [跳过]label
@property (nonatomic, strong)UILabel *label;

@end

@implementation ZPCircleProgressView{
    CABasicAnimation *basAniamtion;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置ui
        [self setUpSubViews];
    }
    return self;
    
}

//设置ui
- (void)setUpSubViews {
    NSString * name = @"跳过";
    self.bigBaseLayer = [CAShapeLayer layer];
    self.bigBaseLayer.lineWidth = 1.0f;
    self.bigBaseLayer.strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
    self.bigBaseLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
    [self.layer addSublayer:self.bigBaseLayer];
    
    self.bigShapeLayer = [CAShapeLayer layer];
    self.bigShapeLayer.lineWidth = 2.0f;
    self.bigShapeLayer.lineCap = kCALineCapRound;
    self.bigShapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.bigShapeLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
    [self.bigBaseLayer addSublayer:self.bigShapeLayer];
    
    //需要确认颜色
    CGRect rect =  [name boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}
                                                context:nil];
    _label = [[UILabel alloc]initWithFrame:CGRectMake((self.bounds.size.width - rect.size.width)/2, (self.bounds.size.height - rect.size.height)/2, rect.size.width, rect.size.height)];
    _label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightUltraLight];
    _label.text =name;
    _label.textColor = [UIColor colorWithRed:240 green:240 blue:240 alpha:0.8];
    _label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [self addSubview:_label];
    
    //增加单击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpOut)];
    [self addGestureRecognizer:gesture];
    
}

- (void)layoutSubviews {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height)/2;
    CGFloat bigRadius = radius;
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:center radius:bigRadius startAngle:- M_PI_2 endAngle: (M_PI * 2)- M_PI_2 clockwise:YES];

    self.bigBaseLayer.path = bigPath.CGPath;
    self.bigShapeLayer.path = bigPath.CGPath;
    
}

//单击block
-(void)jumpOut{
    if (_jumpOutBlock) {
        _jumpOutBlock(nil);
    }
}

-(void)setAnimationWithSecond:(CGFloat)time{
    basAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basAniamtion.delegate = self;
    basAniamtion.fromValue=[NSNumber numberWithInteger:0];
    basAniamtion.toValue=[NSNumber numberWithInteger:1];
    basAniamtion.removedOnCompletion = NO;
    basAniamtion.fillMode = kCAFillModeForwards;
    basAniamtion.duration= time;
    [self.bigShapeLayer addAnimation:basAniamtion forKey:@"key"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    basAniamtion.delegate = nil;
    [self.bigShapeLayer removeAllAnimations];
    if (_completeBlock) {
        _completeBlock(nil);
    }
}

//设置字体大小，以及label名称
-(void)setFontSize:(float)fontSize
           andName:(NSString *)labelName{
    CGRect rect1 =  [labelName boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                                      context:nil];
    _label.frame = CGRectMake((self.bounds.size.width - rect1.size.width)/2, (self.bounds.size.height - rect1.size.height)/2, rect1.size.width, rect1.size.height);
    _label.text = labelName;
    _label.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
}

-(void)dealloc{
    NSLog(@"dealloc succ");
}

@end
