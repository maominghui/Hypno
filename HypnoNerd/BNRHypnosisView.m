//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by 茆明辉 on 15/9/21.
//  Copyright © 2015年 brzt.com. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property(strong, nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置BNRHypnosisView对象的背景颜色为透明
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    //根据bounds 计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
//    //根据视图宽高中的较小值计算圆形半径
//    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    
    //使最外层圆形成为视图的外接圆
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
//    //以中心点为圆心、radius 的值为半径，定义一个0到M_PI * 2.0 弧度的路径
//    [path addArcWithCenter:center
//                    radius:radius
//                startAngle:0.0
//                  endAngle:M_PI * 2.0
//                 clockwise:YES];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    //设置线条宽度为10点
    path.lineWidth = 10;
    
    
    //设置颜色
    //[[UIColor lightGrayColor]setStroke];
    
    [self.circleColor setStroke];
    
    //绘制路径
    [path stroke];
}

//BNRHypnosisView被触摸时会收到该消息
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    //获取三个0到1之间的数字
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    self.circleColor = randomColor;
}

-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

@end
