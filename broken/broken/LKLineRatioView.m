//
//  LKLineRatioView.m
//  broken
//
//  Created by support on 2020/11/29.
//

#import "LKLineRatioView.h"
#import "JXCircleModel.h"

@implementation LKLineRatioView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSMutableArray *)dataArray{
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataArray = dataArray;
        
        
    }
    return self;
}

/// 比例
- (CGFloat)getShareNumber:(NSMutableArray *)arr{
    CGFloat f = 0.0;
    for (int  i = 0; i < arr.count; i++) {
        
        JXCircleModel *model = arr[i];
        f += [model.number floatValue];
    }
    //NSLog(@"总量：%.2f  比例:%.2f",f,360.0 / f);
    return self.frame.size.width / f;
}
- (void)drawRect:(CGRect)rect {
    
    // 1.所占比例
    CGFloat bl = [self getShareNumber:self.dataArray];
    
    // 2.开启上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat line_start = 0; //开始时的弧度  －－－－－ 旋转200度
    CGFloat ff = 0;  //记录偏转的角度 －－－－－ 旋转200度
    
//    [self drawLine3];
    
    for (int i = 0; i < self.dataArray.count; i ++) {


        JXCircleModel *model = self.dataArray[i];

        CGFloat line_end =  [model.number floatValue] * bl + ff;  //结束

        ff += [model.number floatValue] * bl;

        [self addLineWithCGContextRef:ctx andX:line_start andY:line_end andWithColor:model.color];


        line_start = line_end;

    }
//
//    [self addLineWithCGContextRef:ctx andX:0.000000 andY:21.428572 andWithColor:[UIColor redColor]];
}
    
- (void)drawLine2
{
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();

    //设置路径
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 20, 0);
//    CGContextSetFillColorWithColor(context , [UIColor redColor].CGColor);
    CGContextSetRGBFillColor(context, 1, 1, 0, 1);
    //画上去
    CGContextStrokePath(context);
    
//    CGContextSetLineWidth(context, 5.0);
//    　　//设置线条样式
//    　　CGContextSetLineCap(context, kCGLineCapButt);
//    　　//设置画笔颜色：黑色
//    　　CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
//    　　//画点连线
//    　　CGContextAddLines(context, points, count);
//    　　//执行绘画
//    　　CGContextStrokePath(context);
    
    
//
}

    - (void)drawLine3
    {
        
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor redColor].CGColor;
        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        dashLayer.lineWidth = 5.0;
        
        UIBezierPath *path = [UIBezierPath bezierPath];

        [path moveToPoint:CGPointMake(0, 0)];

        [path addLineToPoint:CGPointMake(20, 0)];
        
//        [path setLineDash:dash count:2 phase:10];
//        [path stroke];
//
//        dashLayer.path = path.CGPath;

        [path stroke];
        
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];
        
        
//        [lineView.layer addSublayer:shapeLayer];

    }
    

    
- (void)addLineWithCGContextRef:(CGContextRef)ctx andX:(float)xx andY:(float)yy andWithColor:(UIColor *)color
{
    
    NSLog(@"----------%f,=========%f",xx,yy);
        // 9.画指引线
        CGContextBeginPath(ctx);

        CGContextMoveToPoint(ctx, xx, 15);
        CGContextAddLineToPoint(ctx, yy, 15);
        CGContextSetLineWidth(ctx, 5);

        //填充颜色
    CGContextSetStrokeColorWithColor(ctx , color.CGColor);
        CGContextStrokePath(ctx);

//    CAShapeLayer * dashLayer = [CAShapeLayer layer];
//    dashLayer.strokeColor = color.CGColor;
//    dashLayer.fillColor = [[UIColor clearColor] CGColor];
//    // 默认设置路径宽度为0，使其在起始状态下不显示
//    dashLayer.lineWidth = 5.0;
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//
//    [path moveToPoint:CGPointMake(xx, 15)];
//
//    [path addLineToPoint:CGPointMake(yy, 15)];
//
//    [path stroke];
//
//    dashLayer.path = path.CGPath;
//    [self.layer addSublayer:dashLayer];
    
    // 11.画指引线下的文字
    // 11.1设置段落风格
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.alignment = NSTextAlignmentLeft;

    NSLog(@"sfdfdf===%f",yy -xx );
    [@"比例" drawInRect:CGRectMake(xx, 0, yy- xx, 15) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize: 10],NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraph}];
    
}
    
/// 重绘
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    
    [self setNeedsDisplay];
}
    
@end
