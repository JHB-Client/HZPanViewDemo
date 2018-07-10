//
//  ViewController.m
//  HZPanViewDemo
//
//  Created by 季怀斌 on 2018/7/10.
//  Copyright © 2018年 huazhuo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpPanView];
}

- (void)setUpPanView {
    
    
    //1. 得有一个layer才可以看到。
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    shaperLayer.strokeColor = [UIColor greenColor].CGColor;
    shaperLayer.lineWidth = 5;
    shaperLayer.lineCap = kCALineCapRound;
    // clockwise:顺时针方向的
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100 startAngle:- M_PI endAngle:0 clockwise:true];
    //
    shaperLayer.path = circlePath.CGPath;
    
    [self.view.layer addSublayer:shaperLayer];
    
    //2. 刻度
    CGFloat perAngle = M_PI / 50;
    
    
    for (int i = 0; i < 51; i++) {
        CGFloat startAngle = -M_PI + perAngle * i;
        CGFloat endAngle = startAngle + perAngle/6; // 获取结尾的角度： /8是获取perangle的一部分
        
        //
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        //
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:150 startAngle:startAngle endAngle:endAngle clockwise:true];
        if (i % 5 == 0) {
            perLayer.strokeColor = [UIColor colorWithRed:0.62 green:0.84 blue:0.93 alpha:1.0].CGColor;
            perLayer.lineWidth = 10.f;
            
            //
            //3. 字体
            CGPoint point = [self getLabelPositonWithRadious:130 arcCenter:self.view.center angle:startAngle + perAngle/12];
            
            //默认label的大小14 * 14
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.x - 10, point.y - 10, 20, 20)];
            //            label.backgroundColor = [UIColor redColor];
            label.text = [NSString stringWithFormat:@"%d",i * 2];
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = [UIColor colorWithRed:0.54 green:0.78 blue:0.91 alpha:1.0];
            label.textAlignment = NSTextAlignmentCenter;
            // 旋转
            label.transform = CGAffineTransformMakeRotation(M_PI_2 + startAngle + perAngle/12);
            [self.view addSubview:label];
            
        } else {
            perLayer.strokeColor = [UIColor colorWithRed:0.22 green:0.66 blue:0.87 alpha:1.0].CGColor;
            perLayer.lineWidth = 5;
        }
        
        perLayer.path = tickPath.CGPath;
        [self.view.layer addSublayer:perLayer];
    }
    
}

//
- (CGPoint)getLabelPositonWithRadious:(CGFloat)radious arcCenter:(CGPoint)center angle:(CGFloat)angel {
    CGFloat x = radious * cosf(angel);
    CGFloat y = radious * sinf(angel);
    return CGPointMake(center.x + x, center.y + y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
