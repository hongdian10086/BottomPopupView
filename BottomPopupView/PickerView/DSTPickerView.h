//
//  DSTPickerView.h
//  Fairy
//
//  Created by gordon on 16/11/8.
//  Copyright © 2016年 gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickSureButton)(NSArray *dataArray);

@interface DSTPickerView : UIView

@property (copy,nonatomic) void (^clickSureButton)(NSArray *dataArray);

- (instancetype)initWithpickerViewWithCenterTitle:(NSString *)title andSure:(NSString *)sure andListDataArray:(NSArray *)array;

- (void)pickerVIewClickCancelBtnBlockSureBtClcik:(clickSureButton)sureBlock;

- (void)pickerVIewClickCancelBtnBlockCanleClcik:(clickSureButton)sureBlock;


@end
