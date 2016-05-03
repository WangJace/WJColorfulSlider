//
//  WJColorfulSlider.h
//  WJColorfulSlider
//
//  Created by 王傲云 on 16/5/3.
//  Copyright © 2016年 WangJace. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface WJColorfulSlider : UIView
/**
 *  WJColorfulSlider线条的线宽
 */
@property (nonatomic, assign) IBInspectable CGFloat lineHeight;
/**
 *  WJColorfulSlider滑块的半径
 */
@property (nonatomic, assign) IBInspectable CGFloat circleRadius;
/**
 *  通过代码块获取WJColorSliderColor当前的值
 */
@property (nonatomic, strong) void (^SliderValue)(int);

- (void)setSliderWithValue:(int)value;

@end
