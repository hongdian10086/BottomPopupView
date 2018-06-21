//
//  DSTPickerView.m
//  Fairy
//
//  Created by gordon on 16/11/8.
//  Copyright © 2016年 gordon. All rights reserved.
//

#import "DSTPickerView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface DSTPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString *titleStr;
    NSString *rightStr;
    NSInteger index;
    NSInteger count;
    NSInteger tap;
    NSMutableArray *seleteStringArr;
}

@property (nonatomic,strong)UIPickerView *pickerView;

@property (strong, nonatomic)NSMutableArray *listArray;


@property (nonatomic,strong)UILabel *bottomShowLable;

@property (nonatomic,strong)UILabel *bottomLabel;

@property (nonatomic,strong)UIButton *leftButton;

@property (nonatomic,strong)UIButton *rightButton;

//toolBar
@property (nonatomic,strong)UIToolbar *toolBarOne;
//组合view
@property (nonatomic,strong)UIView *containerView;

@property (strong, nonatomic)NSArray *fishArray;

@property (strong, nonatomic)NSArray *lastArray;


@end

@implementation DSTPickerView

//懒加载控件
- (UIPickerView *)pickerViewLoanMoney {
    
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor=[UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.frame = CGRectMake(0, 40, WIDTH, 216);

    }
    
    return _pickerView;
}

- (UIToolbar *)toolBarOne {
    
    if (_toolBarOne == nil) {
        
        _toolBarOne = [self setToolbarStyle:titleStr andCancel:nil andSure:rightStr];
    }
    
    return _toolBarOne;
}


- (UIView *)containerView {
    
    if (_containerView == nil) {
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 256, WIDTH, 256)];
        _containerView.backgroundColor = [UIColor redColor];
        
        
        [_containerView addSubview:self.toolBarOne];
        [_containerView addSubview:self.pickerViewLoanMoney];
    }
    return _containerView;
    
}

- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        
        _bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, WIDTH, 20)];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.font = [UIFont systemFontOfSize:10];
        [_containerView addSubview:self.bottomLabel];

        
    }
    return _bottomLabel;

    
}
- (UILabel *)bottomShowLable{
    if (_bottomShowLable == nil) {
        
        _bottomShowLable = [[UILabel alloc]initWithFrame:CGRectMake(0,KIsiPhoneX?225:236, WIDTH, 20)];
        _bottomShowLable.textAlignment = NSTextAlignmentCenter;
        _bottomShowLable.font = [UIFont systemFontOfSize:10];
        [_containerView addSubview:_bottomShowLable];
        
        
    }
    return _bottomShowLable;

}

- (UIButton *)leftButton {
    
    if (_leftButton == nil) {
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, HEIGHT - 216/2-20, 40, 40);
        [_leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton.layer addAnimation:[self opacityForever_Animation:0.8] forKey:nil];

    }
    return _leftButton;
    
}

- (UIButton *)rightButton {
    
    if (_rightButton == nil) {
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(WIDTH-40, HEIGHT - 216/2-20, 40, 40);
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton.layer addAnimation:[self opacityForever_Animation:0.8] forKey:nil];

    }
    return _rightButton;
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    self.frame = [UIScreen mainScreen].bounds;
}


-  (UIToolbar *)setToolbarStyle:(NSString *)titleString andCancel:(NSString *)cancelString andSure:(NSString *)sureString{
    
    UIToolbar *toolbar=[[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, WIDTH, 40);
    UIView *view = [[UIView alloc]initWithFrame:toolbar.frame];
    view.backgroundColor = [UIColor colorWithRed:42/255.0 green:115/255.0 blue:241/255.0 alpha:1.0];
    [toolbar addSubview:view];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, WIDTH-80 , 40)];
    ;
    titleLable.text = titleString;
    titleLable.textAlignment = 1;
    titleLable.textColor = [UIColor whiteColor];
    titleLable.numberOfLines = 0;
    titleLable.adjustsFontSizeToFitWidth = YES;
    titleLable.font = [UIFont systemFontOfSize:18];
    [toolbar addSubview:titleLable];
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.backgroundColor = [UIColor clearColor];
    chooseBtn.frame = CGRectMake(0, 5, 40, 35);
    chooseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    chooseBtn.layer.cornerRadius = 2;
    chooseBtn.layer.masksToBounds = YES;
    [chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chooseBtn setTitle:sureString forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(doneItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    centerSpace.width = 70;
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:chooseBtn];
    
    toolbar.items=@[centerSpace,rightItem];
    
    return toolbar;
}

//点击确定按钮
- (void)doneItemClick:(UIButton *) btn {

    if (self.clickSureButton) {
        
        self.clickSureButton(seleteStringArr);
        
    }
    [self dissMissView];
}
- (void)rightButtonClick{
    tap = tap+count;

    if (index < self.listArray.count-1) {
        index ++;
        [_pickerView reloadAllComponents];

    }

    NSDictionary *dic = self.listArray[index];
    NSArray *array = dic[dic.allKeys.firstObject];
    for (int i = 0; i<array.count; i++) {
        [_pickerView selectRow:0 inComponent:i animated:NO];
        
        NSInteger row=[_pickerView selectedRowInComponent:i];
        
        NSDictionary *dic = self.listArray[index];
        NSArray *array = dic[dic.allKeys.firstObject];
        
        NSArray *lastArr = array[i];
        
        [seleteStringArr replaceObjectAtIndex:tap+i withObject:lastArr[row]];
    }
    _bottomShowLable.text = [seleteStringArr componentsJoinedByString:@""];

}

- (void)leftButtonClick{

    if (index > 0) {
         index --;
        [_pickerView reloadAllComponents];
    }
    for (int i = tap; i< seleteStringArr.count; i++) {
        [seleteStringArr replaceObjectAtIndex:i withObject:@""];
    }

    tap = tap-count;

    
    NSDictionary *dic = self.listArray[index];
    NSArray *array = dic[dic.allKeys.firstObject];
    for (int i = 0; i<array.count; i++) {
        [_pickerView selectRow:0 inComponent:i animated:NO];
        
        NSInteger row=[_pickerView selectedRowInComponent:i];
        
        NSDictionary *dic = self.listArray[index];
        NSArray *array = dic[dic.allKeys.firstObject];
        
        NSArray *lastArr = array[i];
        
        [seleteStringArr replaceObjectAtIndex:tap+i withObject:lastArr[row]];
        
        
    }
    
    _bottomShowLable.text = [seleteStringArr componentsJoinedByString:@""];

    

}

- (void)dissMissView{
    
    [UIView animateWithDuration:.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.containerView.frame = CGRectMake(0, HEIGHT, WIDTH, 256);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dissMissView];
}

- (void)pickerVIewClickCancelBtnBlockCanleClcik:(clickSureButton)sureBlock{
    [self dissMissView];

}
- (instancetype)initWithpickerViewWithCenterTitle:(NSString *)title andSure:(NSString *)sure andListDataArray:(NSArray *)array{
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        titleStr = title;
        rightStr = sure;
        index = 0;
        self.rightButton.hidden = YES;
        self.leftButton.hidden = YES;
        
        self.listArray = [NSMutableArray arrayWithArray:array];
        [self addSubview:self.containerView];
        
        self.bottomShowLable.text = @"";

        seleteStringArr = [NSMutableArray array];
        for (NSDictionary *dic in self.listArray) {

            NSArray *array = dic[dic.allKeys.firstObject];
            for (int i = 0; i<array.count; i++) {
                [seleteStringArr addObject:@""];
            }
            
        }
        NSDictionary *dictionary = self.listArray.firstObject;
        NSArray *array = dictionary[dictionary.allKeys.firstObject];
        for (int i = 0; i < array.count; i++) {
            [_pickerView selectRow:0 inComponent:i animated:NO];
            [_pickerView reloadAllComponents];
            
            NSInteger row=[_pickerView selectedRowInComponent:i];
            
            NSDictionary *dic = self.listArray[index];
            NSArray *array = dic[dic.allKeys.firstObject];
            
            NSArray *lastArr = array[i];
            
            
            [seleteStringArr replaceObjectAtIndex:tap+i withObject:lastArr[row]];
            
        }
        _bottomShowLable.text = [seleteStringArr componentsJoinedByString:@""];

        
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"pickerViewleft"] forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"pickerViewright"] forState:UIControlStateNormal];
        
        UIWindow *currentWindows = [UIApplication sharedApplication].keyWindow;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        [currentWindows addSubview:self];
        
        
        
    }
    
    return self;
    
}

- (void)pickerVIewClickCancelBtnBlockSureBtClcik:(clickSureButton)sureBlock{
    self.clickSureButton = sureBlock;
}

#pragma pickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    NSDictionary *dic = self.listArray[index];
    NSString *key = dic.allKeys.firstObject;
    NSArray *array = dic[key];
    self.bottomLabel.text = key;
    if (index <= 0) {
        _leftButton.hidden = YES;
    }else{
        _leftButton.hidden = NO;
    }

    if (index >= self.listArray.count-1) {
        _rightButton.hidden = YES;
    }else{
        _rightButton.hidden = NO;
    }
    count = array.count;
    return array.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    NSDictionary *dic = self.listArray[index];
    NSArray *array = dic[dic.allKeys.firstObject];
    NSInteger rows = 0;
    switch (component) {
        case 0:
        {
            NSArray *firstarr = array[0];
            rows = firstarr.count;

        }
            break;
        case 1:
        {
            NSArray *lastArr = array[1];
            rows = lastArr.count;
        }
            break;
        case 2:
        {
            NSArray *lastArr = array[2];
            rows = lastArr.count;
        }
            break;
        case 3:
        {
            NSArray *lastArr = array[3];
            rows = lastArr.count;
        }
            break;
        case 4:
        {
            NSArray *lastArr = array[4];
            rows = lastArr.count;
        }
            break;
        default:
            break;
    }
    return rows;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    NSString * title = nil;
    NSDictionary *dic = self.listArray[index];
    NSArray *array = dic[dic.allKeys.firstObject];
    switch (component) {
        case 0:
        {
            NSArray *firstarr = array[0];
            title = firstarr[row];
            
        }
            break;
        case 1:
        {
            NSArray *lastArr = array[1];
            title = lastArr[row];
        }
            break;
        case 2:
        {
            NSArray *lastArr = array[2];
            title = lastArr[row];
        }
            break;
        case 3:
        {
            NSArray *lastArr = array[3];
            title = lastArr[row];
        }
            break;
        case 4:
        {
            NSArray *lastArr = array[4];
            title = lastArr[row];
        }
            break;
        default:
            break;
    }
    
    return title;
    
}


// 选中某一组中的某一行时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSDictionary *dic = self.listArray[index];
    NSArray *array = dic[dic.allKeys.firstObject];
    
    NSArray *lastArr = array[component];
    
    [seleteStringArr replaceObjectAtIndex:tap+component withObject:lastArr[row]];

    _bottomShowLable.text = [seleteStringArr componentsJoinedByString:@""];
}

#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}


@end
