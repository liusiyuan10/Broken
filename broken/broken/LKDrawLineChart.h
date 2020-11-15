//
//  LKDrawLineChart.h
//  DrawLineChartDemo
//
//  Created by support on 2020/11/14.
//  Copyright © 2020 mars_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKDrawLineChart : UIView

/**
 *  横坐标数组
 */
@property (nonatomic,strong)NSArray *horizontalDateArray;

/**
 *  横坐标数组
 */
@property (nonatomic,strong)NSArray *verticalDateArray;

@property (nonatomic,strong)NSArray *verticalTitleArray;

/**
 *  需要展示的三组数据
 */
@property (nonatomic,strong)NSArray * dataArray;

/**
 *  线条的颜色
 */
@property (nonatomic,strong)NSArray * lineColorArray;
/**
 *  每条线条代表什么
 */
@property(nonatomic, strong) NSArray *titleArray;
/**
 *  绘制X、Y值 、虚线、折线
 */
- (void )drawLineDashWithHorizontalDateArray:(NSArray *)horizontalDateArray verticalTitleArray:(NSArray *)verticalTitleArray VerticalDateArray:(NSArray *)verticalDateArray SourceData:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
