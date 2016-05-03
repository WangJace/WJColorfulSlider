//
//  ViewController.m
//  WJColorfulSlider
//
//  Created by 王傲云 on 16/5/3.
//  Copyright © 2016年 WangJace. All rights reserved.
//

#import "ViewController.h"
#import "WJColorfulSlider.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet WJColorfulSlider *colorfulSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak ViewController *weakSelf = self;
    [_colorfulSlider setSliderValue:^(int value) {
        weakSelf.valueTextField.text = [NSString stringWithFormat:@"%d",value];
    }];
}

- (IBAction)changeValueAction:(UITextField *)sender {
    int value = [sender.text intValue];
    if (value >= 0 && value <= 100) {
        [_colorfulSlider setSliderWithValue:value];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([_valueTextField isFirstResponder]) {
        [_valueTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
