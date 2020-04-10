//
//  XSHouseSubListChooseTableViewCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubTableViewCell.h"

@interface XSHouseSubListChooseTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *value;

@end
@implementation XSHouseSubListChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
- (void)refreshData{
    XSKeyValueModel *model =  self.dataModel.arrayValue.firstObject;
    self.title.text = self.dataModel.title;
    XSValue *valueData = model.values.firstObject;
    if (valueData.valueStr == nil) {
        self.value.text = valueData.placeholder;
        self.value.textColor = [UIColor hb_colorWithHexString:@"#BFBFBF" alpha:1];
    }else{
        self.value.text = valueData.valueStr;
        self.value.textColor = [UIColor hb_colorWithHexString:@"#444444" alpha:1];
    }

}
- (IBAction)listChoose:(UIButton *)sender {
    WEAK_SELF;
    BRAddressPickerView *addressPickerView = [[BRAddressPickerView alloc]init];
    addressPickerView.pickerMode = BRAddressPickerModeArea;
    addressPickerView.title = @"请选择地区";
//    addressPickerView.selectValues = @[@"浙江省", @"杭州市", @"西湖区"];
    addressPickerView.dataSourceArr = [XSPublicServer sharedInstance].cityArray;
//    addressPickerView.selectIndexs = @[@10, @0, @4];
    addressPickerView.isAutoSelect = YES;
    addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        STRONG_SELF;
        
        NSString *valueStr = [NSString stringWithFormat:@"%@%@%@", province.name, city.name, area.name];
        NSLog(@"选择的值：%@", valueStr);
        self.value.text = valueStr;
        self.value.textColor = [UIColor hb_colorWithHexString:@"#444444" alpha:1];

          XSKeyValueModel *model = [self.dataModel.arrayValue safeObjectAtIndex:0];
          XSValue *valueData = model.values.firstObject;
          valueData.valueStr = valueStr;
       
//        [[XSHouseSubMitServer sharedInstance] LocationParameterUpdateWithProvince:province city:city area:area];

    };

    [addressPickerView show];
}
@end
