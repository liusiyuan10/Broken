//
//  LKLineRatioView.h
//  broken
//
//  Created by support on 2020/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKLineRatioView : UIView

@property(nonatomic, strong) NSMutableArray *dataArray; // 数据数组

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSMutableArray *)dataArray;


@end

NS_ASSUME_NONNULL_END
