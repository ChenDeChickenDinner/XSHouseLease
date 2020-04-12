//
//  XSHouseSubTableViewCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubTableViewCell.h"
#import "XSSearchEstateController.h"

#define lableWidth 2
static NSString *CollectionCellIdentifier = @"CollectionCellIdentifierA";
static NSString *CollectionCellIdentifierB = @"CollectionCellIdentifierB";



#pragma mark - 基础Cell
@implementation XSHouseSubTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;;
}
- (void)refreshData{
}

+ (NSInteger)indexForClassName:(NSString *)className{
    Class class = NSClassFromString(className);
    if ([class isEqual:[XSHouseSubListChooseTableViewCell class]]) {
        return 1;
    }else if ([class isEqual:[XSHouseSubTextFieldTableViewCell class]]){
        return 2;
    }else if ([class isEqual:[XSHouseSubTextViewCell class]]){
        return 3;
    }else if ([class isEqual:[XSHouseSubCollectionviewACell class]]){
        return 4;
    }else if ([class isEqual:[XSHouseSubCollectionviewBCell class]]){
        return 5;
    }else if ([class isEqual:[XSHouseSubPictureSubmitCell class]]){
        return 6;
    }else if ([class isEqual:[XSHouseSubProcessViewCell class]]){
        return 7;
    }
    return 0;
}
@end

#pragma mark - 选择器
@implementation XSHouseSubListChooseTableViewCell
- (void)refreshData{
    self.title.text = self.dataModel.title;
    
    XSKeyValueModel *model =  self.dataModel.arrayValue.firstObject;
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
    XSKeyValueModel *model =  self.dataModel.arrayValue.firstObject;
    XSValue *valueData = model.values.firstObject;
    WEAK_SELF;

    if ([valueData.key isEqualToString:@"city"]) {
        BRAddressPickerView *addressPickerView = [[BRAddressPickerView alloc]init];
        addressPickerView.pickerMode = BRAddressPickerModeArea;
        addressPickerView.pickerMode = BRAddressPickerModeProvince;
        addressPickerView.title = @"请选择地区";
        addressPickerView.dataSourceArr = [XSPublicServer sharedInstance].cityArray;
        addressPickerView.isAutoSelect = YES;
        addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            STRONG_SELF;
            NSString *valueStr = [NSString stringWithFormat:@"%@%@%@", province.name, city.name, area.name];
            NSLog(@"选择的值：%@", valueStr);
            valueData.value = [NSNumber numberWithInt:province.code.intValue];
            valueData.valueStr = province.name;
            self.value.text = valueStr;
            self.value.textColor = [UIColor hb_colorWithHexString:@"#444444" alpha:1];
        };

        [addressPickerView show];
    }else if ([valueData.key isEqualToString:@"estate"]){
       NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict safeSetObject:@"上海" forKey:@"city"];
        XSSearchEstateController *vc = [[XSSearchEstateController alloc]init];
        vc.dict = dict;
        vc.searchBlock = ^(XSHouseEsModel * _Nonnull model) {
            STRONG_SELF;
            valueData.value = model.ID;
            valueData.valueStr = model.name;
            self.value.text = model.name;
            self.value.textColor = [UIColor hb_colorWithHexString:@"#444444" alpha:1];
           self.dataModel.valuechangeStatus(self.dataModel, model, XSBHouseKeyValueEsSend);
        };
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
//        [[NSObject getTopViewController].navigationController pushViewController:vc animated:YES];
        [[NSObject getTopViewController] presentViewController:nav animated:YES completion:nil];
    }

}
@end

#pragma mark -TextField输入
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
        self.textFieldFirst.text =valueData.sendType == XSValueSendType_Int?valueData.value.stringValue:valueData.valueStr;;
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
               
                self.textFieldFirst.text =  valueData.sendType == XSValueSendType_Int?valueData.value.stringValue:valueData.valueStr;;
                self.textFieldFirst.placeholder = valueData.placeholder;
                self.frontDescribeLableFirst.text = valueData.frontDescribe;
                self.hindDescribeLablethFirst.text = valueData.hindDescribe;
                self.frontDescribeWidthFirst.constant = [self.frontDescribeLableFirst mj_textWidth] + lableWidth;
                self.hindDescribeWidthFirst.constant = [self.hindDescribeLablethFirst mj_textWidth] + lableWidth;
            }else{
                self.textFieldSceend.text = valueData.sendType == XSValueSendType_Int?valueData.value.stringValue:valueData.valueStr;;
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

#pragma mark -TextView输入
@implementation XSHouseSubTextViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.delegate = self;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.textColor = [UIColor hb_colorWithHexString:@"#4A4A4A" alpha:1];

    XSKeyValueModel *model = [self.dataModel.arrayValue safeObjectAtIndex:0];
     XSValue *valueData = model.values.firstObject;
    if (valueData.valueStr == nil) {
        textView.text = nil;
    }
//    if (model.valuechangeStatus) {
//        model.valuechangeStatus(model.key, XSBHouseKeyValueEditBegin);
//    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    XSKeyValueModel *model = [self.dataModel.arrayValue safeObjectAtIndex:0];
     XSValue *valueData = model.values.firstObject;
     valueData.valueStr = textView.text.length > 0?textView.text:nil;
}
- (void)refreshData{
    if ([self.dataModel isKindOfClass:[XSKeyValue class]]) {
        XSKeyValue *keyValueModel = (XSKeyValue *)self.dataModel;
        self.title.text = keyValueModel.key;
        self.textView.text = keyValueModel.value;
        self.userInteractionEnabled = NO;
        self.textView.textColor = [UIColor hb_colorWithHexString:@"#4A4A4A" alpha:1];
    }else{
         self.title.text = self.dataModel.title;
         XSKeyValueModel *model = [self.dataModel.arrayValue safeObjectAtIndex:0];
         XSValue *valueData = model.values.firstObject;
        self.textView.text = valueData.valueStr?valueData.valueStr:valueData.placeholder;
        self.textView.textColor = [UIColor hb_colorWithHexString:valueData.valueStr?@"#4A4A4A":@"#E76D66" alpha:1];
        self.userInteractionEnabled = YES;
    }
}
@end

#pragma mark -CollectionViewA
@implementation XSHouseSubCollectionviewACell
- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout =  [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake(77, 28);
        _layout.minimumInteritemSpacing = 12;
        _layout.minimumLineSpacing = 12;
    }
    return _layout;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.collectionViewLayout = self.layout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.scrollEnabled = NO;

    self.collectionView.pagingEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[XSCollectionViewCell class] forCellWithReuseIdentifier:CollectionCellIdentifier];

}
- (void)refreshData{
    self.title.text = self.dataModel.title;
    XSKeyValueModel *dataModel = self.dataModel.arrayValue.firstObject;
    CGFloat itemSizeWidth = self.layout.itemSize.width;
    CGFloat Spacing = self.layout.minimumInteritemSpacing;
    self.collectionViewWidth.constant = (itemSizeWidth + Spacing) * dataModel.values.count;
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:section];
    return dataModel.values.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:indexPath.section];
    XSValue *valeModel = [dataModel.values safeObjectAtIndex:indexPath.row];
    XSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellIdentifier forIndexPath:indexPath];
    cell.valueModel = valeModel;
    [cell refreshData];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    NSLog(@"1111");
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:indexPath.section];
    XSValue *valeModel = [dataModel.values safeObjectAtIndex:indexPath.row];
    if (dataModel.multiple) {
        valeModel.isSelect = !valeModel.isSelect;
    }else{
         for (XSValue *valeModel  in dataModel.values) {
              valeModel.isSelect = NO;
          }
        valeModel.isSelect = YES;
    }
    [self.collectionView reloadData];
}
@end

#pragma mark -CollectionViewB
@implementation XSHouseSubCollectionviewBCell
- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout =  [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake(77, 28);
        _layout.minimumInteritemSpacing = 12;
        _layout.minimumLineSpacing = 12;
    }
    return _layout;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.collectionViewLayout = self.layout;
    self.collectionView.backgroundColor = [UIColor clearColor];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.pagingEnabled = NO;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[XSCollectionViewCell class] forCellWithReuseIdentifier:CollectionCellIdentifierB];

}
- (void)refreshData{
    self.title.text = self.dataModel.title;
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:section];
    return dataModel.values.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:indexPath.section];
    XSValue *valeModel = [dataModel.values safeObjectAtIndex:indexPath.row];
    XSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellIdentifierB forIndexPath:indexPath];
    cell.valueModel = valeModel;
    [cell refreshData];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:indexPath.section];
    XSValue *valeModel = [dataModel.values safeObjectAtIndex:indexPath.row];

    if (dataModel.multiple) {
        valeModel.isSelect = !valeModel.isSelect;
    }else{
         for (XSValue *valeModel  in dataModel.values) {
              valeModel.isSelect = NO;
          }
        valeModel.isSelect = YES;
    }

    NSLog(@"选中cell: %ld", indexPath.row);
    [self.collectionView reloadData];

}
- (void)setHighlighted:(BOOL)highlighted{
    self.backgroundView.backgroundColor = nil;
}

@end


#pragma mark -图片上传采集
@implementation XSHouseSubPictureSubmitCell

- (void)awakeFromNib{
    [super awakeFromNib];
     self.photoView = [[HXPhotoView alloc]initWithManager:self.manager];
     self.photoView.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
     self.photoView.delegate = self; //
     self.photoView.outerCamera = YES; // 是否把相机功能放在外面 默认NO
     self.photoView.editEnabled = NO;
     self.photoView.lineCount = 3; // 每行个数 默认 3 cell的宽高取决于 每行个数 与 HXPhotoView 的宽度 和 item间距
     self.photoView.spacing = 15; // 每个item间距 默认 3
     self.photoView.showAddCell = YES; // 是否显示添加的cell 默认 YES
     //    photoView.addImageName = nil; // 添加按钮的图片
     //    photoView.deleteImageName = nil; // 删除按钮图片
    [self.bkPhotoView addSubview:self.photoView];

     self.photoView.previewShowDeleteButton = YES; // 预览大图时是否显示删除按钮
     self.photoView.previewStyle = HXPhotoViewPreViewShowStyleDefault; //预览大图时的风格样式
     self.photoView.adaptiveDarkness = YES;// 底部选择视图是否自适应暗黑风格
     self.photoView.updateFrameBlock = ^(CGRect frame) {
         NSLog(@"frame:%@",NSStringFromCGRect(frame));
     };
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.photoView.frame = self.bkPhotoView.bounds;
    
}
- (void)refreshData{
    WEAK_SELF;
    self.photoView.changeCompleteBlock = ^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photos, NSArray<HXPhotoModel *> *videos, BOOL isOriginal) {
        STRONG_SELF;
        self.dataModel.valuechangeStatus(self.dataModel, nil, XSBHouseKeyValueImagesChange);
        for (HXPhotoModel *photoModel in photos) {
            [photoModel requestImageURLStartRequestICloud:nil progressHandler:nil success:^(NSURL * _Nullable imageURL, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
                if ([self.dataModel.title isEqualToString:@"户型图上传"]) {
                    self.dataModel.valuechangeStatus(self.dataModel, imageURL, XSBHouseKeyValueImagesSend);
                }else{
                    self.dataModel.valuechangeStatus(self.dataModel, imageURL, XSBHouseKeyValueImagesDoorSend);
                }
            } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
                
            }];
        }
     };

    if ([self.dataModel.title isEqualToString:@"户型图上传"]) {
        self.title.text = @"户型图上传";
        self.titleB.text = nil;

        self.manager.configuration.maxNum = 1;
        self.manager.configuration.photoMaxNum = 1;
    }else{
        self.title.text = @"房源图片上传";
         self.titleB.text = @"（最多上传5张照片）";

        self.manager.configuration.maxNum = 5;
        self.manager.configuration.photoMaxNum = 5;
    }
    self.manager.configuration.videoMaxNum = 0;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    HXWeakSelf
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools savePhotoToCustomAlbumWithName:self.manager.configuration.customAlbumName photo:image location:nil complete:^(HXPhotoModel *model, BOOL success) {
                if (success) {
                    if (weakSelf.manager.configuration.useCameraComplete) {
                        weakSelf.manager.configuration.useCameraComplete(model);
                    }
                }else {
                    [weakSelf hx_showImageHUDText:@"保存图片失败"];
                }
            }];
        }else {
            HXPhotoModel *model = [HXPhotoModel photoModelWithImage:image];
            if (self.manager.configuration.useCameraComplete) {
                self.manager.configuration.useCameraComplete(model);
            }
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.openCamera = YES;  //是否打开相机功能
        _manager.configuration.photoStyle = HXPhotoStyleDefault; // 相册风格
        _manager.configuration.albumShowMode = HXPhotoAlbumShowModeDefault; // 相册风格
        _manager.configuration.editAssetSaveSystemAblum = YES; /// 编辑后的照片/视频是否添加到系统相册中
        _manager.configuration.saveSystemAblum = YES; //拍摄的 照片/视频 是否保存到系统相册  默认NO
        _manager.configuration.hideOriginalBtn = YES;
        _manager.configuration.maxNum = 5;
        _manager.configuration.photoMaxNum = 5;
        _manager.configuration.videoMaxNum = 0;
        _manager.configuration.clarityScale = 1.4;
        _manager.configuration.photoCanEdit = NO;///  照片是否可以编辑   default YES
        _manager.configuration.limitPhotoSize = 0; // 限制照片的大小 单位：b 字节 默认 0字节 不限制
        _manager.configuration.selectPhotoLimitSize = NO; // 选择视频时是否限制照片大小
        _manager.configuration.showOriginalBytes = YES; // 原图按钮显示已选照片的大小
        _manager.configuration.showOriginalBytesLoading = YES; // 原图按钮显示已选照片大小时是否显示加载菊花
        _manager.configuration.requestImageAfterFinishingSelection = YES; /// 在照片列表选择照片完后点击完成时是否请求图片和视频地址
        _manager.configuration.clarityScale = [UIScreen mainScreen].bounds.size.width;  //小图照片清晰度 越大越清晰、越消耗性能        
        _manager.configuration.themeColor = [UIColor orangeColor]; // 主题颜色  默认 tintColor
        _manager.configuration.creationDateSort = YES;/// 照片列表是否按照片添加日期排序  默认YES
        _manager.configuration.selectTogether = NO;  // 图片和视频是否能够同时选择 默认 NO
        _manager.configuration.lookGifPhoto = NO;  //是否开启查看GIF图片功能 - 默认开启
       _manager.configuration.cameraCellShowPreview = YES;  //相机cell是否显示预览
        _manager.configuration.downloadICloudAsset = NO; //下载iCloud上的资源  默认YES

        _manager.configuration.hideOriginalBtn = NO;  //是否隐藏原图按钮  默认 NO
        _manager.configuration.originalNormalImageName = nil;  //原图按钮普通状态下的按钮图标名
        _manager.configuration.originalSelectedImageName = nil;  //原图按钮选中状态下的按钮图标名

        _manager.configuration.bottomViewTranslucent = NO; // 底部视图是否半透明效果 默认YES
    }
    return _manager;
}
@end





#pragma mark -上传流程提示
@implementation XSHouseSubProcessViewCell

@end

#pragma mark -选择Cell
@implementation XSCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        self.contentView.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;;
        label.layer.cornerRadius = 5;
        label.layer.borderWidth = 0.5;
        [self.contentView addSubview:label];
         self.textlabel = label;
    }
    return self;
}
- (void)layoutSubviews{
    self.textlabel.frame = self.bounds;
}
- (void)refreshData{
    self.textlabel.text = self.valueModel.valueStr;
    if (self.valueModel.isSelect) {
        self.textlabel.textColor = [UIColor hb_colorWithHexString:@"#FFFFFF" alpha:1];
        self.textlabel.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
        self.textlabel.layer.borderColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1].CGColor;
    }else{
        self.textlabel.textColor = [UIColor hb_colorWithHexString:@"#444444" alpha:1];
        self.textlabel.backgroundColor = [UIColor hb_colorWithHexString:@"#EFEFEF" alpha:1];
        self.textlabel.layer.borderColor = [UIColor hb_colorWithHexString:@"#EFEFEF" alpha:1].CGColor;
    }
}
@end
