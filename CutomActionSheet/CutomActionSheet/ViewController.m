//
//  ViewController.m
//  CutomActionSheet
//
//  Created by KentarOu on 2014/03/08.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "ViewController.h"
#import "PickerActionSheet.h"
#import "PickerActionSheetController.h"

@interface ViewController ()<PickerActionSheetControllerDelegate>
{
    UIButton *selectBtn;
    PickerActionSheet *pickerAS;
    PickerActionSheetController *picker;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}



- (IBAction)pickerBtn:(UIButton*)sender
{
    
    selectBtn = sender;
    
    Class class = NSClassFromString(@"UIAlertController");
    
    if (class) {
        // iOS8はUIAlertControllerを使用
        
        PickerActionSheetController *pickerController = [[PickerActionSheetController alloc]initWithDelegate:self ActionSheetWithType:sender.tag inputString:sender.currentTitle];
        
        [self presentViewController:pickerController.controller animated:YES completion:nil];
        
    } else {
        
        // ※iOS8で実行すると中のPickerが表示されません。
        
        // PickerActionSheet生成 ActionSheetTypeをここではボタンのタグNo.で呼び出しています。
        pickerAS = [[PickerActionSheet alloc]initWithDelegate:self
                                          ActionSheetWithType:sender.tag
                                                  inputString:sender.currentTitle];
        [pickerAS showInView:self.view];
    }
}


// ActionSheetのDelegateでの処理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"done");
            [selectBtn setTitle:[pickerAS getSelectString] forState:UIControlStateNormal];
            break;
            
        case 1:
            NSLog(@"cancel");
            break;
            
        default:
            break;
    }
}

-(void)alertControllerSelectButtonIndex:(NSInteger)buttonIndex selectPikerString:(NSString *)string
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"done");
            [selectBtn setTitle:string forState:UIControlStateNormal];
            break;
            
        case 1:
            NSLog(@"cancel");
        
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
