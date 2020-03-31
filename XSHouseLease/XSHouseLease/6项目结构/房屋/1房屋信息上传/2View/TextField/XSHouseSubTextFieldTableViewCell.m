//
//  XSHouseSubTextFieldTableViewCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubTextFieldTableViewCell.h"
#define lableWidth 2

@interface XSHouseSubTextFieldTableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titlew;

@property (weak, nonatomic) IBOutlet UITextField *textFieldFirst;
@property (weak, nonatomic) IBOutlet UILabel *frontDescribeLableFirst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontDescribeWidthFirst;

@property (weak, nonatomic) IBOutlet UILabel *hindDescribeLablethFirst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hindDescribeWidthFirst;

@property (weak, nonatomic) IBOutlet UIView *valueViewSceend;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *valueViewSceendWidth;

@property (weak, nonatomic) IBOutlet UITextField *textFieldSceend;
@property (weak, nonatomic) IBOutlet UILabel *frontDescribeLableSceend;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontDescribeWidthSceend;

@property (weak, nonatomic) IBOutlet UILabel *hindDescribeLablethSceend;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hindDescribeWidthSceend;


@end

@implementation XSHouseSubTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textFieldFirst.delegate = self;
    self.textFieldSceend.delegate = self;

        XSValue *valueData = nil;
       self.textFieldFirst.text = valueData.valueStr;
       self.textFieldFirst.placeholder = valueData.placeholder;
       self.frontDescribeLableFirst.text = valueData.frontDescribe;
       self.hindDescribeLablethFirst.text = valueData.hindDescribe;
       self.textFieldSceend.text = valueData.valueStr;
       self.textFieldSceend.placeholder = valueData.placeholder;
       self.frontDescribeLableSceend.text = valueData.frontDescribe;
       self.hindDescribeLablethSceend.text = valueData.hindDescribe;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        if (textField == self.textFieldFirst) {
            XSKeyValueModel *mode = [self.dataModel.arrayValue safeObjectAtIndex:0];
            XSValue *valueData = mode.values.firstObject;
                if (valueData.sendType == XSValueSendType_Int) {
                    valueData.value =  [NSNumber numberWithDouble:textField.text.doubleValue];
                }else{
                    valueData.valueStr =  textField.text;
                }
            valueData.valueStr =  textField.text;
        }else if (textField == self.textFieldSceend){
            XSKeyValueModel *mode = [self.dataModel.arrayValue safeObjectAtIndex:1];
            XSValue *valueData = mode.values.firstObject;
                if (valueData.sendType == XSValueSendType_Int) {
                    valueData.value =  [NSNumber numberWithDouble:textField.text.doubleValue];
                }else{
                    valueData.valueStr =  textField.text;
                }
        }
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.dataModel.arrayValue.count == 1) {
        self.titlew.constant = [self.title mj_textWidth] +5;
        self.valueViewSceendWidth.constant = 10;
    }else{
    self.titlew.constant = [self.title mj_textWidth] +5 + 40;
    self.valueViewSceendWidth.constant = (self.width - 30 - 45)/2;
    }
    
}
- (void)refreshData{
    self.title.text = self.dataModel.title;
    if (self.dataModel.arrayValue.count == 1) {
        self.titlew.constant = [self.title mj_textWidth] +5;

        self.valueViewSceend.hidden =YES;
        self.valueViewSceendWidth.constant = 10;
        
        XSKeyValueModel *model = [self.dataModel.arrayValue safeObjectAtIndex:0];
        XSValue *valueData = model.values.firstObject;
        self.textFieldFirst.text = valueData.valueStr;
        self.textFieldFirst.placeholder = valueData.placeholder;
        self.frontDescribeLableFirst.text = valueData.frontDescribe;
        self.hindDescribeLablethFirst.text = valueData.hindDescribe;
        self.frontDescribeWidthFirst.constant = [self.frontDescribeLableFirst mj_textWidth] + lableWidth;
        self.hindDescribeWidthFirst.constant = [self.hindDescribeLablethFirst mj_textWidth] + lableWidth;

    
    }else{
        self.titlew.constant = [self.title mj_textWidth] +5 + 40;

        self.valueViewSceend.hidden =NO;
        self.valueViewSceendWidth.constant = (self.width - 30 - 45)/2;
        
        for (int i = 0; i <self.dataModel.arrayValue.count ; i++) {
            XSKeyValueModel *model = [self.dataModel.arrayValue safeObjectAtIndex:i];
            XSValue *valueData = model.values.firstObject;
            if (i == 0) {
                self.textFieldFirst.text = valueData.valueStr;
                self.textFieldFirst.placeholder = valueData.placeholder;
                self.frontDescribeLableFirst.text = valueData.frontDescribe;
                self.hindDescribeLablethFirst.text = valueData.hindDescribe;
                self.frontDescribeWidthFirst.constant = [self.frontDescribeLableFirst mj_textWidth] + lableWidth;
                self.hindDescribeWidthFirst.constant = [self.hindDescribeLablethFirst mj_textWidth] + lableWidth;
            }else{
                self.textFieldSceend.text = valueData.valueStr;
                self.textFieldSceend.placeholder = valueData.placeholder;
                self.frontDescribeLableSceend.text = valueData.frontDescribe;
                self.hindDescribeLablethSceend.text = valueData.hindDescribe;
                
                self.frontDescribeWidthSceend.constant = [self.frontDescribeLableSceend mj_textWidth] + lableWidth;
                self.hindDescribeWidthSceend.constant = [self.hindDescribeLablethSceend mj_textWidth] + lableWidth;
            }
        }
 
    }
}

@end
