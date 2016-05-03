//
//  WJColorfulSlider.m
//  WJColorfulSlider
//
//  Created by 王傲云 on 16/5/3.
//  Copyright © 2016年 WangJace. All rights reserved.
//

#import "WJColorfulSlider.h"

#define sliderHeight CGRectGetHeight(self.frame)
#define sliderWidth CGRectGetWidth(self.frame)

@interface WJColorfulSlider ()
{
    CGFloat _distance;
}

@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation WJColorfulSlider

- (instancetype) init
{
    if ((self = [super init])) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self setSubview];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setSubview];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setSubview];
    }
    return self;
}

- (void)setSubview
{
    _lineHeight = 5;
    _circleRadius = _lineHeight*2;
    [self addSubview:self.circleView];
    [self addSubview:self.textLabel];
}

- (void)layoutSubviews
{
    _distance = CGRectGetWidth(self.frame);
    [self updateUI];
}

- (void)updateUI
{
    _circleView.frame = CGRectMake(0, (sliderHeight-_circleRadius*2)/2.0, _circleRadius*2, _circleRadius*2);
    _circleView.layer.cornerRadius = _circleRadius;
    
    _textLabel.frame = CGRectMake(0, 0, 60, 30);
    _textLabel.center = CGPointMake(_circleView.center.x, _circleView.center.y-30);
}

- (UIView *)circleView
{
    if (!_circleView) {
        _circleView = [[UIView alloc] init];
        _circleView.backgroundColor = [UIColor colorWithRed:0.51 green:0.81 blue:0.21 alpha:1.00];
        _circleView.layer.masksToBounds = YES;
        _circleView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        pan.maximumNumberOfTouches = 1;
        pan.minimumNumberOfTouches = 1;
        [_circleView addGestureRecognizer:pan];
    }
    return _circleView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = [UIColor colorWithRed:0.50 green:0.82 blue:0.20 alpha:1.00];
        _textLabel.font = [UIFont boldSystemFontOfSize:20];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.text = @"0%";
    }
    return _textLabel;
}

- (void)panAction:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateEnded) {
        CGPoint offset = [sender translationInView:self];
        CGPoint circleViewCenter = _circleView.center;
        CGPoint textLabelCenter = _textLabel.center;
        if (offset.x+circleViewCenter.x >= 0 && offset.x+circleViewCenter.x <= sliderWidth+1) {
            _circleView.center = CGPointMake(offset.x+circleViewCenter.x, circleViewCenter.y);
            _textLabel.center = CGPointMake(offset.x+textLabelCenter.x, textLabelCenter.y);
            int persent = (int)(100*(offset.x+circleViewCenter.x)/_distance);
            _textLabel.text = [NSString stringWithFormat:@"%d%%",persent];
            if (_SliderValue) {
                _SliderValue(persent);
            }
            [sender setTranslation:CGPointZero inView:self];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateEnded) {
        CGPoint tapPoint = [sender locationInView:self];
        _circleView.center = CGPointMake(tapPoint.x, _circleView.center.y);
        _textLabel.center = CGPointMake(tapPoint.x, _textLabel.center.y);
        int persent = (int)(100*tapPoint.x/_distance);
        _textLabel.text = [NSString stringWithFormat:@"%d%%",persent];
        if (_SliderValue) {
            _SliderValue(persent);
        }
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // get the contect
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //now draw the rounded rectangle
    [[UIColor clearColor] setStroke];
    
    //since I need room in my rect for the shadow, make the rounded rectangle a little smaller than frame);
    CGFloat radius = 3;
    // the rest is pretty much copied from Apples example
    
    CGFloat x1 = 0, x2 = sliderWidth/4.0, x3 = sliderWidth/2.0, x4 = sliderWidth*3/4.0, x5 = sliderWidth*7/8, x6 = sliderWidth;
    CGFloat y1 = (sliderHeight-_lineHeight)/2.0, y2 = (sliderHeight-_lineHeight)/2.0+_lineHeight/2.0, y3 = (sliderHeight-_lineHeight)/2.0+_lineHeight;
    
    
    CGContextMoveToPoint(context, x1, y2);
    CGContextAddArcToPoint(context, x1, y1, x2, y1, radius);
    CGContextAddArcToPoint(context, x3, y1, x3, y2, 0);
    CGContextAddArcToPoint(context, x3, y3, x2, y3, 0);
    CGContextAddArcToPoint(context, x1, y3, x1, y2, radius);
    CGContextClosePath(context);
    [[UIColor colorWithRed:0.48 green:0.78 blue:0.29 alpha:1.00] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGPoint yellowPoints[4];
    yellowPoints[0] = CGPointMake(x3, y1);
    yellowPoints[1] = CGPointMake(x4, y1);
    yellowPoints[2] = CGPointMake(x4, y3);
    yellowPoints[3] = CGPointMake(x3, y3);
    CGContextAddLines(context, yellowPoints, 4);
    CGContextClosePath(context);
    [[UIColor colorWithRed:0.98 green:0.77 blue:0.26 alpha:1.00] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextMoveToPoint(context, x4, y2);
    CGContextAddArcToPoint(context, x4, y1, x5, y1, 0);
    CGContextAddArcToPoint(context, x6, y1, x6, y2, radius);
    CGContextAddArcToPoint(context, x6, y3, x5, y3, radius);
    CGContextAddArcToPoint(context, x4, y3, x4, y2, 0);
    CGContextClosePath(context);
    [[UIColor colorWithRed:0.93 green:0.37 blue:0.38 alpha:1.00] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)setSliderWithValue:(int)value
{
    CGFloat x = _distance*value/100.0;
    _circleView.center = CGPointMake(x, _circleView.center.y);
    _textLabel.center = CGPointMake(x, _textLabel.center.y);
    _textLabel.text = [NSString stringWithFormat:@"%d%%",value];
}

@end
