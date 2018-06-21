//
//  ViewController.m
//  BottomPopupView
//
//  Created by laikidi on 2018/6/21.
//  Copyright © 2018年 Algor. All rights reserved.
//

#import "ViewController.h"
#import "DSTPickerView.h"
#import "PickerModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *content;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)show:(id)sender {
    
    //PickerView每一列显示的数据
    NSArray *array = @[@"网页",@"新闻",@"贴吧",@"文章"];
    NSArray *array1 = @[@"音乐",@"图片",@"视频",@"摄像"];
    NSArray *array2 = @[@"北京",@"上海",@"广州",@"重庆"];
    NSArray *array3 = @[@"58同城",@"赶集网",@"百姓网",@"安居客"];
    NSArray *array4 = @[@"家政",@"金融",@"影楼",@"百科"];
    NSArray *array5 = @[@"家政",@"金融",@"影楼",@"百科"];
    
    
    //每一列的Title
    NSDictionary *dic = @{@"常用功能单选":@[array]};
    NSDictionary *dic1 = @{@"最多设置5列":@[array1,array2,array3]};
    NSDictionary *dic2 = @{@"多项选择":@[array4,array5]};
    
    
    //
    DSTPickerView *pickerView = [[DSTPickerView alloc]initWithpickerViewWithCenterTitle:@"请选择" andSure:@"确定" andListDataArray:@[dic,dic1,dic2]];
    [pickerView pickerVIewClickCancelBtnBlockSureBtClcik:^(NSArray *dataArray) {
        
        NSString *string = [NSString string];
        for (NSString *str in dataArray) {
            
            string = [string stringByAppendingString:str];
            
        }
        self.content.text = string;

    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
