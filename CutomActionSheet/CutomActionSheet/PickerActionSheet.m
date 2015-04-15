//
//  PickerActionSheet.m
//  CutomActionSheet
//
//  Created by KentarOu on 2014/03/08.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "PickerActionSheet.h"

#define CANCEL_BTN_TITLE @"キャンセル"
#define OTHER_BTN_TITLE @"設定"

@interface PickerActionSheet()
{
    UIDatePicker *datePicker;
    UIPickerView *pickerV;
    
    NSString *tmpString;
    
    // picker type
    ActionSheet_Type AS_Type;
    
    NSString *tmpString_0;
    NSString *tmpString_1;
    NSString *tmpString_2;
    NSString *tmpString_3;
    
    NSDateFormatter *df;
}
@property (nonatomic) NSString *selectString;

@end


@implementation PickerActionSheet

#pragma mark- initializer

// 初期化メソッド
- (id)initWithDelegate:(id<UIActionSheetDelegate>)delegate
   ActionSheetWithType:(ActionSheet_Type)ActionSheet_Type
           inputString:(NSString*)string
{
    self = [super initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n"
                       delegate:delegate
              cancelButtonTitle:CANCEL_BTN_TITLE
         destructiveButtonTitle:nil
              otherButtonTitles:OTHER_BTN_TITLE, nil];
    
    if (self) {
        AS_Type = ActionSheet_Type;
        tmpString = string;
        
        [self makePicker];
    }
    
    return self;
}

- (void)makePicker
{
    // pickerの値を変更しないで設定を押下した場合の為に文字列をセット
    self.selectString = tmpString;
    
    if (tmpString) {
        // 引数の文字列に「.」「年」「月」「日」「時」「分」があったら取り除く
        tmpString = [tmpString stringByReplacingOccurrencesOfString:@"年" withString:@""];
        tmpString = [tmpString stringByReplacingOccurrencesOfString:@"月" withString:@""];
        tmpString = [tmpString stringByReplacingOccurrencesOfString:@"日" withString:@""];
        tmpString = [tmpString stringByReplacingOccurrencesOfString:@"時" withString:@""];
        tmpString = [tmpString stringByReplacingOccurrencesOfString:@"分" withString:@""];
        tmpString = [tmpString stringByReplacingOccurrencesOfString:@"." withString:@""];
    }
    
    
    if (AS_Type < 5) {
        
        // PickerViewを生成
        pickerV = [[UIPickerView alloc]init];
        
        pickerV.delegate = self;
        pickerV.dataSource = self;
        if ([tmpString length] > 0) {
            [self pickerViewSetValue1];
        }
        pickerV.showsSelectionIndicator = YES;
        [self addSubview:pickerV];
        
    } else {
        
        df = [[NSDateFormatter alloc]init];
        
        // DatePickerを生成
        datePicker = [UIDatePicker new];
        datePicker.date = [NSDate date];
    
        
        switch (AS_Type) {
            case ActionSheetFormat_Date:
                datePicker.datePickerMode = UIDatePickerModeDate;
                if ([tmpString length] > 0) {
                    df.dateFormat = @"yyyyMMdd";
                }
                break;
                
            case ActionSheetFormat_Time:
            case ActionSheetFormat_CountDownTimer:
                
                datePicker.datePickerMode = UIDatePickerModeTime;
                if ([tmpString length] > 0) {
                    df.dateFormat = @"HHmm";
                }
                break;
                
            case ActionSheetFormat_DateAndTime:
                datePicker.datePickerMode = UIDatePickerModeDateAndTime;
                if ([tmpString length] > 0) {
                    df.dateFormat = @"yyyyMMddHHmm";
                }
                break;
                
            default:
                break;
        }
        if (tmpString) {
            datePicker.date = [df dateFromString:tmpString];
        }
        
        [datePicker addTarget:self
                       action:@selector(DatePickerValueChanged:)
             forControlEvents:UIControlEventValueChanged];
        
        [self DatePickerValueChanged:datePicker];
        [self addSubview:datePicker];
    }
}

#pragma mark- Set Picker Data

- (void)pickerViewSetValue1
{
    switch ([tmpString length]) {
        case 4:
            tmpString_3 = [tmpString substringWithRange:NSMakeRange(3, 1)];
            
        case 3:
            tmpString_2 = [tmpString substringWithRange:NSMakeRange(2, 1)];
            
        case 2:
            tmpString_1 = [tmpString substringWithRange:NSMakeRange(1, 1)];
            tmpString_0 = [tmpString substringWithRange:NSMakeRange(0, 1)];
            
            break;
            
        default:
            break;
    }
    [self pickerViewSetValue2];
}

// 引数の値をPickerに反映
- (void)pickerViewSetValue2
{
    
    switch (AS_Type) {
        case ActionSheetFormat_00:
            [pickerV selectRow:[tmpString_0 intValue] inComponent:0 animated:NO];
            [pickerV selectRow:[tmpString_1 intValue] inComponent:1 animated:NO];
            break;
            
        case ActionSheetFormat_000:
            [pickerV selectRow:[tmpString_0 intValue] inComponent:0 animated:NO];
            [pickerV selectRow:[tmpString_1 intValue] inComponent:1 animated:NO];
            [pickerV selectRow:[tmpString_2 intValue] inComponent:2 animated:NO];
            
            break;
        case ActionSheetFormat_0_0:
            [pickerV selectRow:[tmpString_0 intValue] inComponent:0 animated:NO];
            [pickerV selectRow:[tmpString_1 intValue] inComponent:2 animated:NO];
            break;
            
        case ActionSheetFormat_00_0:
            [pickerV selectRow:[tmpString_0 intValue] inComponent:0 animated:NO];
            [pickerV selectRow:[tmpString_1 intValue] inComponent:1 animated:NO];
            [pickerV selectRow:[tmpString_2 intValue] inComponent:3 animated:NO];
            break;
            
        case ActionSheetFormat_000_0:
            [pickerV selectRow:[tmpString_0 intValue] inComponent:0 animated:NO];
            [pickerV selectRow:[tmpString_1 intValue] inComponent:1 animated:NO];
            [pickerV selectRow:[tmpString_2 intValue] inComponent:2 animated:NO];
            [pickerV selectRow:[tmpString_3 intValue] inComponent:4 animated:NO];
            break;
            
        default:
            break;
    }
}

#pragma mark-

// ピッカーに表示する行数を返す
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (AS_Type) {
        case ActionSheetFormat_00:
            return 2;
            break;
            
        case ActionSheetFormat_000:
        case ActionSheetFormat_0_0:
            return 3;
            break;
    
        case ActionSheetFormat_00_0:
            return 4;
            break;
            
        case ActionSheetFormat_000_0:
            return 5;
            break;
            
        default:
            break;
    }
    return 0;
}


// ピッカーに表示する列数を返す
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (AS_Type) {
        case ActionSheetFormat_00:
            
            break;
            
        case ActionSheetFormat_000:
            
            break;
            
        case ActionSheetFormat_0_0:
            if (component == 1) {
                return 1;
            }
            break;
            
        case ActionSheetFormat_00_0:
            if (component == 2) {
                return 1;
            }
            break;
            
        case ActionSheetFormat_000_0:
            if (component == 3) {
                return 1;
            }
            break;
            
        default:
            break;
    }
    return 10;
}


// 行のサイズを変更
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    switch (AS_Type) {
        case ActionSheetFormat_00:
            
            break;
            
        case ActionSheetFormat_000:
            
            break;
            
        case ActionSheetFormat_0_0:
            if (component == 1) {
                return 40;
            }
            
            break;
            
        case ActionSheetFormat_00_0:
            if (component == 2) {
                return 40;
            }
            break;
            
        case ActionSheetFormat_000_0:
            if (component == 3) {
                return 40;
            }
            
            break;
            
        default:
            break;
    }
    return 50.0;
}


// ピッカーに表示する値を返す
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (AS_Type) {
        case ActionSheetFormat_00:
            
            break;
            
        case ActionSheetFormat_000:
            
            break;
            
        case ActionSheetFormat_0_0:
            if (component == 1) {
                return @".";
            }
            
            break;
            
        case ActionSheetFormat_00_0:
            if (component == 2) {
                return @".";
            }
            break;
            
        case ActionSheetFormat_000_0:
            if (component == 3) {
                return @".";
            }
            break;
            
        default:
            break;
    }
    return [NSString stringWithFormat:@"%ld", (long)row];
}



// ピッカーの選択列が決まったときに呼ばれる
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (AS_Type) {
        case ActionSheetFormat_00:
            self.selectString = [NSString stringWithFormat:@"%ld%ld",
                                 (long)[pickerView selectedRowInComponent:0],
                                 (long)[pickerView selectedRowInComponent:1]];
            
            // デフォルトの値の場合はクリアする
            if ([self.selectString isEqualToString:@"00"]) {
                self.selectString = @"";
            }
            break;
            
        case ActionSheetFormat_000:
            self.selectString = [NSString stringWithFormat:@"%ld%ld%ld",
                                 (long)[pickerView selectedRowInComponent:0],
                                 (long)[pickerView selectedRowInComponent:1],
                                 (long)[pickerView selectedRowInComponent:2]];
            
            if ([self.selectString isEqualToString:@"000"]) {
                self.selectString = @"";
            }
            
            break;
            
        case ActionSheetFormat_0_0:
            self.selectString = [NSString stringWithFormat:@"%ld.%ld",
                                 (long)[pickerView selectedRowInComponent:0],
                                 (long)[pickerView selectedRowInComponent:2]];
            
            if ([self.selectString isEqualToString:@"0.0"]) {
                self.selectString = @"";
            }
            
            break;
            
        case ActionSheetFormat_00_0:
            self.selectString = [NSString stringWithFormat:@"%ld%ld.%ld",
                                 (long)[pickerView selectedRowInComponent:0],
                                 (long)[pickerView selectedRowInComponent:1],
                                 (long)[pickerView selectedRowInComponent:3]];
            
            if ([self.selectString isEqualToString:@"00.0"]) {
                self.selectString = @"";
            }
            break;
            
        case ActionSheetFormat_000_0:
            self.selectString = [NSString stringWithFormat:@"%ld%ld%ld.%ld",
                                 (long)[pickerView selectedRowInComponent:0],
                                 (long)[pickerView selectedRowInComponent:1],
                                 (long)[pickerView selectedRowInComponent:2],
                                 (long)[pickerView selectedRowInComponent:4]];
            
            if ([self.selectString isEqualToString:@"000.0"]) {
                self.selectString = @"";
            }
            
            break;
            
        default:
            break;
    }
}


#pragma mark- DatePikcer ValueChanged

// DatePickerの値が変わった時に呼ばれる
- (void)DatePickerValueChanged:(UIDatePicker*)sender
{
    switch (AS_Type) {
        case ActionSheetFormat_Date:
            df.dateFormat = @"yyyy年MM月dd日";
            break;
        case ActionSheetFormat_Time:
            df.dateFormat = @"HH時mm分";
            break;
        case ActionSheetFormat_DateAndTime:
            df.dateFormat = @"yyyy年MM月dd日HH時mm分";
            break;
        case ActionSheetFormat_CountDownTimer:
            df.dateFormat = @"HH時mm分";
            break;
            
        default:
            break;
    }
    self.selectString = [df stringFromDate:datePicker.date];
}

#pragma mark- Get PickerString

- (NSString*)getSelectString
{
    return self.selectString;
}


@end
