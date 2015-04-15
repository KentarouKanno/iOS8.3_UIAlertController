//
//  PickerActionSheetController.h
//  CutomActionSheet
//
//  Created by KentarOu on 2014/09/14.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import <UIKit/UIKit.h>


// Picker Type
typedef enum : NSInteger
{
    ActionControllerFormat_00 = 0,    // Pickerview
    ActionControllerFormat_000,
    ActionControllerFormat_0_0,
    ActionControllerFormat_00_0,
    ActionControllerFormat_000_0,
    
    ActionControllerFormat_Date = 5,  // DatePicker
    ActionControllerFormat_Time,
    ActionControllerFormat_DateAndTime,
    ActionControllerFormat_CountDownTimer
    
}ActionController_Type;

@interface PickerActionSheetController : UIAlertController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,readwrite)id delegate;
@property (nonatomic,readwrite) UIAlertController *controller;

// 初期化メソッド
- (id)initWithDelegate:(id)delegate
   ActionSheetWithType:(ActionController_Type)ActionControllerType
           inputString:(NSString*)string;

@end


// 設定、キャンセルボタンが押された時に文字列を返すDelegate
@protocol PickerActionSheetControllerDelegate <NSObject>

- (void)alertControllerSelectButtonIndex:(NSInteger)buttonIndex selectPikerString:(NSString*)string;

@end

