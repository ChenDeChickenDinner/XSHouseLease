//
//  XSLocationSearchview.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSLocationSearchview.h"
@interface XSLocationSearchview ()<SDCycleScrollViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *hotSearchView;
@property (weak, nonatomic) IBOutlet UIView *hotSearchStrView;
@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UITextField *searchTextFiled;
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong) NSMutableArray *hotsViewArray;

@end
@implementation XSLocationSearchview
+ (instancetype)locationSearchview{
    XSLocationSearchview *view  = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    return view;
}
- (NSMutableArray *)hotsViewArray{
    if (!_hotsViewArray) {
        _hotsViewArray = [NSMutableArray array];
    }
    return _hotsViewArray;
}
- (void)awakeFromNib{
    [super awakeFromNib];
     self.hotsSearchArray = [XSHouseFixedData sharedInstance].hotsSearchArray;

    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage: [UIImage imageNamed:@"homePageIcon"]];
     cycleScrollView.imageURLStringsGroup = nil;
     cycleScrollView.showPageControl = YES;
     cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
     cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
     cycleScrollView.imageURLStringsGroup = [XSHouseFixedData sharedInstance].bunnerUrlArray;
    self.cycleScrollView = cycleScrollView;
    [self.bkView addSubview:cycleScrollView];

    self.searchView.layer.masksToBounds = YES;
    self.searchView.layer.cornerRadius = 8.5;
    
    self.searchTextFiled.delegate = self;
    self.searchTextFiled.keyboardType =  UIKeyboardTypeDefault;
}
- (void)setHotsSearchArray:(NSMutableArray<XSHousehots *> *)hotsSearchArray{
    _hotsSearchArray = hotsSearchArray;
    
    for (UIView *view in self.hotsViewArray) {
        [view removeFromSuperview];
    }
    
     for (int i = 0; i < hotsSearchArray.count; i++) {
         XSHousehots *hots =  [hotsSearchArray safeObjectAtIndex:i];
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         btn.tag = i;
         btn.backgroundColor = [UIColor clearColor];
         btn.titleLabel.font = [UIFont systemFontOfSize:10];
         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [btn setTitle:hots.name forState:UIControlStateNormal];
         [btn addTarget:self action:@selector(clickHost:) forControlEvents:UIControlEventTouchUpInside];
         [self.hotsViewArray addObject:btn];
         [self.hotSearchStrView addSubview:btn];
     }

    [self hotsSubViewFrame];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.cycleScrollView.frame = self.bkView.bounds;
    self.cycleScrollView.imageURLStringsGroup = [XSHouseFixedData sharedInstance].bunnerUrlArray;
    [self hotsSubViewFrame];
}
- (void)hotsSubViewFrame{
    if (self.superview == nil) {
        return;
    }
       for (int i = 0; i < self.hotsViewArray.count; i++) {
           UIButton *btn = [self.hotsViewArray safeObjectAtIndex:i];
           UIButton *frontbtn = [self.hotsViewArray safeObjectAtIndex:i - 1];
           btn.frame = CGRectMake(frontbtn.x + frontbtn.width, 0, [btn.titleLabel mj_textWidth] + 5, self.hotSearchStrView.height);
       }
}
- (void)setImagePathsGroup:(NSArray *)imagePathsGroup{
    _imagePathsGroup = imagePathsGroup;
    self.cycleScrollView.imageURLStringsGroup = imagePathsGroup;
    
}

- (IBAction)cityChoose:(id)sender {
    WEAK_SELF;
    if ([XSHouseFixedData sharedInstance].cityArray.count == 0) {
        return;
    }
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
    NSMutableArray *modelArr = [[NSMutableArray alloc]init];
    stringPickerView.pickerMode = BRStringPickerComponentSingle;
    for (BRProvinceModel *dataModel in [XSHouseFixedData sharedInstance].cityArray) {
        BRResultModel *model = [[BRResultModel alloc]init];
        model.key = dataModel.code;
        model.value = dataModel.name;
        model.remark  = @"";
        [modelArr addObject:model];
    }

    [BRStringPickerView showPickerWithTitle:@"请选择城市" dataSourceArr:[modelArr copy] selectIndex:0 resultBlock:^(BRResultModel *resultModel) {
        STRONG_SELF;
        NSArray *strArray= [resultModel.value componentsSeparatedByString:@"市"];
        self.cityLable.text = strArray.firstObject?(NSString *)strArray.firstObject:resultModel.value;
        [XSUserServer sharedInstance].cityModel.name = resultModel.value;
        [XSUserServer sharedInstance].cityModel.code = resultModel.key;
    }];
    
}
- (void)clickHost:(UIButton *)btn{
    XSHousehots *hots = [self.hotsSearchArray safeObjectAtIndex:btn.tag];
     if(self.searchBlack)self.searchBlack(hots.name);
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        if(self.searchBlack)self.searchBlack(textField.text);
    }
    
}
- (IBAction)search:(id)sender {
    if (self.searchTextFiled.text.length > 0) {
        if(self.searchBlack)self.searchBlack(self.searchTextFiled.text);
    }
}

@end
