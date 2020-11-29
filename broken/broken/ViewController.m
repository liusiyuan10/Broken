//
//  ViewController.m
//  broken
//
//  Created by support on 2020/11/15.
//

#import "ViewController.h"
#import "JXCircleModel.h"
#import "JXCircleRatioView.h"
#import "LKDrawLineChart.h"
#import "LKLineRatioView.h"

#define PIE_HEIGHT  250
#define Radius 75 //圆形比例图的半径


@interface ViewController ()


@property(nonatomic, strong) JXCircleRatioView *circleView_one;


@property(nonatomic, strong) LKLineRatioView *lineView_one;

@property(nonatomic, strong) NSMutableArray *data1;


@end


@implementation ViewController


- (NSMutableArray *)data1{
    if (_data1 == nil) {
        _data1 = [NSMutableArray array];
        
        NSArray *colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor blueColor]];
        NSArray *numbers = @[@"100",@"200",@"400"];
        NSArray *names = @[@"信托产品",@"粤财汇",@"投资"];
        
        
        for (int i = 0; i < numbers.count; i++) {
            JXCircleModel *model = [[JXCircleModel alloc]init];
            model.color = colors[i];
            model.number = numbers[i];
            model.name = names[i];
            
            
            
            [_data1  addObject:model];
        }
        
    }
    return _data1;
}


- (JXCircleRatioView *)circleView_one{
    if (!_circleView_one) {
        
//        _circleView_one = [[JXCircleRatioView alloc]initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, PIE_HEIGHT)  andDataArray:self.data1 CircleRadius:Radius];
        _circleView_one = [[JXCircleRatioView alloc]initWithFrame:CGRectMake(0, 104, 150, 150)  andDataArray:self.data1 CircleRadius:Radius];
        _circleView_one.backgroundColor = [UIColor purpleColor];
    }
    return _circleView_one;
}

- (LKLineRatioView *)lineView_one{
    if (!_lineView_one) {
        
//        _circleView_one = [[JXCircleRatioView alloc]initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, PIE_HEIGHT)  andDataArray:self.data1 CircleRadius:Radius];
        _lineView_one = [[LKLineRatioView alloc]initWithFrame:CGRectMake(10, 300, 300, 20)  andDataArray:self.data1];
        _lineView_one.backgroundColor = [UIColor whiteColor];
////        _lineView_one.layer.cornerRadius = 2.5;
//        _lineView_one.layer.cornerRadius = 7.5;
////        
//        _lineView_one.layer.masksToBounds = YES;
//        
    }
    return _lineView_one;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //添加圆形比例图
    [self.view addSubview:self.circleView_one];
    
    [self.view addSubview:self.lineView_one];
    
    [self drawNewChart];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    UIImage *image = [UIImage imageNamed:@"tupian.jpg"];
    textAttachment.image = image;
    textAttachment.bounds = CGRectMake(0, 0, image.size.width/image.scale, image.size.height/image.scale);
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"梅西去了伊比萨高端夜店lio Ibiza。结果在夜店中，梅西偶遇纳达尔。按照TyC电视台的说法，梅西和纳达尔进行了“简单但友好”的对话，并且进行了合影。尽管纳达尔是皇马死忠球迷，但他和梅西仍然惺惺相惜。\n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    [attri appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, 400, 200)];
    label.numberOfLines = 0;
    label.attributedText = attri;
    [self.view addSubview:label];
}

- (void )drawNewChart{
    LKDrawLineChart *chartView = [[LKDrawLineChart alloc] initWithFrame:CGRectMake(160, 104, 150, 150)];
    chartView.backgroundColor = [UIColor whiteColor];
    chartView.lineColorArray = @[ [UIColor colorWithRed:237/255.0 green:117/255.0 blue:103/255.0 alpha:1],[UIColor colorWithRed:117/255.0 green:217/255.0 blue:193/255.0 alpha:1],[UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1]];
//    [chartView drawLineDashWithHorizontalDateArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] VerticalDateArray:@[@"红",@"走",@"黑"] SourceData:@[@[@"红",@"走",@"黑",@"红",@"走",@"黑",@"黑"],@[@"红",@"黑",@"黑",@"红",@"红",@"黑",@"黑"],@[@"红",@"红",@"黑",@"红",@"走",@"黑",@"红"]]];

    [chartView drawLineDashWithHorizontalDateArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] verticalTitleArray:@[@"红",@"走",@"黑"] VerticalDateArray:@[@20,@10,@0] SourceData:@[@[@(10),@(20),@(0),@0,@(0),@(0),@0]]];

//    chartView.titleArray = @[@"收缩压"];
    
//    [chartView drawLineDashWithHorizontalDateArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] VerticalDateArray:@[@180,@120,@0] SourceData:@[@[@(180),@(20),@(0),@0,@(0),@(0),@0]]];
//    chartView.titleArray = @[@"收缩压",@"舒张压",@"心率"];
    
//    [chartView drawLineDashWithHorizontalDateArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] VerticalDateArray:@[@180,@120,@0] SourceData:@[@[@(180),@(20),@(0),@0,@(0),@(0),@0],@[@(0),@(0),@(0),@0,@(0),@(20),@180],@[@(20),@(0),@(0),@0,@(0),@(0),@180]]];
//    chartView.titleArray = @[@"收缩压",@"舒张压",@"心率"];
    
    [self.view addSubview:chartView];
    
    
    
}


@end
