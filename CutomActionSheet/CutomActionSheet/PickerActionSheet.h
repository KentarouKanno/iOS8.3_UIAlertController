//
//  PickerActionSheet.h
//  CutomActionSheet
//
//  Created by KentarOu on 2014/03/08.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import <UIKit/UIKit.h>

// Picker Type
typedef enum : NSInteger
{
    ActionSheetFormat_00 = 0,    // Pickerview
    ActionSheetFormat_000,
    ActionSheetFormat_0_0,
    ActionSheetFormat_00_0,
    ActionSheetFormat_000_0,
    
    ActionSheetFormat_Date = 5,  // DatePicker
    ActionSheetFormat_Time,
    ActionSheetFormat_DateAndTime,
    ActionSheetFormat_CountDownTimer
    
}ActionSheet_Type;

@interface PickerActionSheet : UIActionSheet<UIPickerViewDataSource,UIPickerViewDelegate>

// 初期化メソッド
- (id)initWithDelegate:(id<UIActionSheetDelegate>)delegate
   ActionSheetWithType:(ActionSheet_Type)ActionSheetType
           inputString:(NSString*)string;

// 選択している文字列を返す
- (NSString*)getSelectString;

@end
