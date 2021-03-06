//
//  LKDrawLineChart.m
//  DrawLineChartDemo
//
//  Created by support on 2020/11/14.
//  Copyright © 2020 mars_liu. All rights reserved.
//

#import "LKDrawLineChart.h"

@interface LKDrawLineChart()<CAAnimationDelegate>
@property (nonatomic, strong) UIView *gradientBackgroundView;//展示折线的背景
@end
static CGFloat bounceX = 10;
static CGFloat bounceY = 20;

@implementation LKDrawLineChart

- (void)drawRect:(CGRect)rect {

    [self createLabelX];
    [self createLabelY];
    [self setLineDash];
    [self dravLine];
//    [self setLineMean];
}



#pragma mark --- 绘制X、Y值 、虚线
- (void )drawLineDashWithHorizontalDateArray:(NSArray *)horizontalDateArray verticalTitleArray:(NSArray *)verticalTitleArray VerticalDateArray:(NSArray *)verticalDateArray SourceData:(NSArray *)dataArray{
    _horizontalDateArray = horizontalDateArray;
    _verticalDateArray = verticalDateArray;
    _dataArray = dataArray;
    _verticalTitleArray = verticalTitleArray;
    
    [self setNeedsDisplay];
}

#pragma mark --- 创建x轴的数据
- (void)createLabelX{
    CGFloat  xCount = self.horizontalDateArray.count;
    for (NSInteger i = 0; i < self.horizontalDateArray.count; i++) {
        CGFloat widthlable = (self.frame.size.width - bounceX)/xCount;
        CGFloat heightlable = bounceY;
        UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - bounceX)/xCount * i + bounceX, self.frame.size.height - bounceY+bounceX/4.0, widthlable, heightlable-bounceX/4.0)];
        LabelMonth.textAlignment = NSTextAlignmentCenter;
        LabelMonth.tag = 1000 + i;
        LabelMonth.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
        LabelMonth.text = self.horizontalDateArray[i];
        LabelMonth.font = [UIFont systemFontOfSize:10];
        LabelMonth.numberOfLines = 0;
        LabelMonth.lineBreakMode = 0;
        [self addSubview:LabelMonth];
    }
}

#pragma mark 创建y轴数据
- (void)createLabelY{
    CGFloat Ydivision = self.verticalTitleArray.count-1;
    for (NSInteger i = 0; i < self.verticalTitleArray.count ; i++) {
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.frame.size.height -  bounceY)/Ydivision *i, bounceX, bounceX)];
        labelYdivision.tag = 2000 + i;
        labelYdivision.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
        labelYdivision.text = [NSString stringWithFormat:@"%@",self.verticalTitleArray[i]];
        labelYdivision.font = [UIFont systemFontOfSize:10];
        [self addSubview:labelYdivision];
    }
}

#pragma mark --- 传添加虚线
- (void)setLineDash{
    self.gradientBackgroundView =[[UIView alloc] initWithFrame:CGRectMake(bounceX, 0, self.bounds.size.width - bounceX, self.bounds.size.height - bounceY+bounceX/4.0)];
    [self addSubview:self.gradientBackgroundView];
    
    for (NSInteger i = 0;i < self.verticalDateArray.count; i++ ) {
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:1].CGColor;
        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        dashLayer.lineWidth = 1.0;
        
        UILabel * label1 = (UILabel*)[self viewWithTag:2000 + i];
        
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor whiteColor];
        
        [color set];
        [path moveToPoint:CGPointMake( 0, label1.frame.origin.y+label1.frame.size.height*0.5)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - bounceX,label1.frame.origin.y+label1.frame.size.height*0.5)];
        CGFloat dash[] = {2,2};
        [path setLineDash:dash count:2 phase:10];
        [path stroke];

        dashLayer.path = path.CGPath;
        dashLayer.lineDashPattern=[NSArray arrayWithObjects:[NSNumber numberWithInt:1],
                                   [NSNumber numberWithInt:2],nil];
        [self.gradientBackgroundView.layer addSublayer:dashLayer];

    }
}






#pragma mark 画折线图
- (void)dravLine{
    CGFloat MaxY ;
    CGFloat firstdate = [[NSString stringWithFormat:@"%@",self.verticalDateArray[0]] floatValue] ;
    CGFloat lastdate = [[NSString stringWithFormat:@"%@",[self.verticalDateArray lastObject]] floatValue];
    MaxY = firstdate - lastdate;
    for(NSInteger LineNumber = 0; LineNumber  < self.dataArray.count; LineNumber++){
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor greenColor];
        [color set];
        UIColor * linecolors = (UIColor*)self.lineColorArray[LineNumber];
        NSArray *array = self.dataArray[LineNumber];
        
        
        //判断是否是一个可显示的第一个点
        BOOL isFirstPoint = NO;
        //创建折现点标记
        for (NSInteger i = 0; i< self.horizontalDateArray.count; i++) {
            UILabel * label1 = (UILabel*)[self viewWithTag:1000 + i];
            CGFloat arc =[[NSString stringWithFormat:@"%@",array[i]] floatValue];
            if (![[NSString stringWithFormat:@"%@",array[0]] isEqualToString:@"-100"]) {
                //第一个数不是空的，是可用数
                if (i==0) {
                    [path moveToPoint:CGPointMake(label1.frame.origin.x+2,(MaxY -arc +lastdate) /MaxY * (self.frame.size.height - bounceY+bounceX/4.0)+2)];
                }else{
                    if (![[NSString stringWithFormat:@"%@",array[i]] isEqualToString:@"-100"]) {
                        [path addLineToPoint:CGPointMake(label1.frame.origin.x+2,(MaxY -arc +lastdate) /MaxY * (self.frame.size.height - bounceY+bounceX/4.0)+2)];
                    }
                    
                }
                
                
            }else{
                //第一个数是空的，不可用数
                UILabel * labelX = (UILabel*)[self viewWithTag:1000 + i];
                if (![[NSString stringWithFormat:@"%@",array[i]] isEqualToString:@"-100"]&&!isFirstPoint) {
                    
                    [path moveToPoint:CGPointMake(labelX.frame.origin.x+2,(MaxY -arc +lastdate) /MaxY * (self.frame.size.height - bounceY+bounceX/4.0+2))];
                    isFirstPoint = YES;
                }else{
                    if (![[NSString stringWithFormat:@"%@",array[i]] isEqualToString:@"-100"]&&isFirstPoint){
                        [path addLineToPoint:CGPointMake(labelX.frame.origin.x+2,(MaxY -arc +lastdate) /MaxY * (self.frame.size.height - bounceY+bounceX/4.0)+2)];
                    }
                }
                
                
            }
            
            
            //添加每个对应的点视图
            if (![[NSString stringWithFormat:@"%@",array[i]] isEqualToString:@"-100"]) {
                UILabel *pointView = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x, (MaxY -arc +lastdate) /MaxY * (self.frame.size.height - bounceY+bounceX/4.0), 4, 4)];
                pointView.tag = 4000 * (LineNumber + 1)+ i;
                pointView.backgroundColor = linecolors;
                pointView.layer.masksToBounds = YES;
                pointView.layer.cornerRadius = 2.f;
                [self.gradientBackgroundView addSubview:pointView];
            }
            
        }
        
        CAShapeLayer *lineChartLayer = [CAShapeLayer layer];
        
        lineChartLayer.path = path.CGPath;
        
        lineChartLayer.strokeColor = linecolors.CGColor;
        lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        lineChartLayer.lineCap = kCALineCapRound;
        lineChartLayer.lineJoin = kCALineJoinRound;
        lineChartLayer.lineWidth = 1;
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 2;
        pathAnimation.repeatCount = 1;
        pathAnimation.removedOnCompletion = YES;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
        pathAnimation.delegate = self;
//        [lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
            lineChartLayer.lineDashPattern=[NSArray arrayWithObjects:[NSNumber numberWithInt:1],
                                       [NSNumber numberWithInt:2],nil];

        [self.gradientBackgroundView.layer addSublayer:lineChartLayer];//直接添加导视图上
       
    }
    
    
}

///**
// *  通过 CAShapeLayer 方式绘制虚线
// *
// *  param lineView:       需要绘制成虚线的view
// *  param lineLength:     虚线的宽度
// *  param lineSpacing:    虚线的间距
// *  param lineColor:      虚线的颜色
// *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
// **/
//- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
//
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//
//    [shapeLayer setBounds:lineView.bounds];
//
//    if (isHorizonal) {
//
//        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
//
//    } else{
//        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
//    }
//
//    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
//    //  设置虚线颜色为blackColor
//    [shapeLayer setStrokeColor:lineColor.CGColor];
//    //  设置虚线宽度
//    if (isHorizonal) {
//        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
//    } else {
//
//        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
//    }
//    [shapeLayer setLineJoin:kCALineJoinRound];
//    //  设置线宽，线间距
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
//    //  设置路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, 0);
//
//    if (isHorizonal) {
//        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
//    } else {
//        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
//    }
//    
//    [shapeLayer setPath:path];
//     CGPathRelease(path);
//     //  把绘制好的虚线添加上来
//     [lineView.layer addSublayer:shapeLayer];
// }


#pragma mark -- 设置每条线对应颜色代表什么
- (void )setLineMean{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x+self.frame.size.width-55, 0, 45, 45)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self insertSubview:bgView aboveSubview:self.gradientBackgroundView];
    for(NSInteger LineNumber = 0; LineNumber < 3; LineNumber++){
        UIColor * linecolors = (UIColor*)self.lineColorArray[LineNumber];
        
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0,4+(bgView.frame.size.height/3.0)*LineNumber,7, 7)];
        colorView.backgroundColor = linecolors;
        [bgView addSubview:colorView];
        
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11, (bgView.frame.size.height/3.0)*LineNumber, bgView.frame.size.width-11, bgView.frame.size.height/3.0)];
        label.text = [NSString stringWithFormat:@"%@",self.titleArray[LineNumber]];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = linecolors;
        [bgView addSubview:label];
    }
}


@end
