//
//  XSHouseRentInfoCell.m
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseInfoShowCell.h"



#pragma mark -基础类
@implementation XSHouseInfoCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;;
}
- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    _model = model;
}
+ (NSInteger)indexForClassName:(NSString *)className{
    Class class = NSClassFromString(className);
    if ([class isEqual:[XSHouseRentInfoCell class]]) {
        return 0;
    }else if ([class isEqual:[XSHouseDetailsImagesCell class]]){
        return 1;
    }else if ([class isEqual:[XSHouseDetailsBasicInfoCell class]]){
        return 2;
    }else if ([class isEqual:[XSHouseDetailsBusinessInfoCell class]]){
        return 3;
    }else if ([class isEqual:[XSHouseDetailsAddressInfoCell class]]){
        return 4;
    }else if ([class isEqual:[XSHouseDetailsFacilitiesInfoCell class]]){
        return 5;
    }else if ([class isEqual:[XSHouseDetailsIntroduceInfoCell class]]){
        return 6;
    }else if ([class isEqual:[XSHouseRecommendedCell class]]){
        return 7;
    }
    return 0;
}
@end


#pragma mark -租房列表
@implementation XSHouseRentInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dealStatusLable.layer.masksToBounds = YES;
    self.dealStatusLable.layer.cornerRadius = 2;
    self.titleLable.text = nil;
    self.infoLable.text = nil;
    self.featurePointsLablea.text = nil;
    self.featurePointsLableb.text = nil;
    self.featurePointsLablec.text = nil;
    self.featurePointsLableaW.constant = 0;
    self.featurePointsLablebW.constant = 0;
    self.featurePointsLablecW.constant = 0;
    self.dealStatusLable.text = nil;
    self.rentPricelabe.text = nil;
    self.watchNumLable.text = nil;
    self.watchNumBKView.hidden = YES;
    self.unitPriceLable.text = nil;
    XSHouseRentStatusView *statusView = [[XSHouseRentStatusView alloc]init];
    WEAK_SELF;
    self.statusEditView.clickEditStatus = ^(NSNumber * _Nonnull status,NSNumber * _Nonnull houseID) {
        STRONG_SELF;
        XSHouseInfoShowModel *newModel = (XSHouseInfoShowModel *)self.model;
        newModel.clickEditStatu(status,newModel.house_id);
    };
    
    [self.statusEditView addSubview:statusView];
    
}

- (void)updateWithModel:(XSHouseInfoShowModel *)NewModel{
    self.model = NewModel;
    
    // 1.图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:NewModel.firstImg]];

    NSString *stra = [NewModel.featurePointNames safeObjectAtIndex:0];;
    NSString *strb = [NewModel.featurePointNames safeObjectAtIndex:1];;
    NSString *strc = [NewModel.featurePointNames safeObjectAtIndex:2];;
    self.featurePointsLablea.text = stra;
    self.featurePointsLableb.text = strb;
    self.featurePointsLablec.text = strc;
    self.featurePointsLableaW.constant = stra.length > 0?[self.featurePointsLablea mj_textWidth] + 5:0;
    self.featurePointsLablebW.constant = strb.length > 0?[self.featurePointsLableb mj_textWidth] + 5:0;
    self.featurePointsLablecW.constant = strc.length > 0?[self.featurePointsLablec mj_textWidth] + 5:0;
    
    if (NewModel.source == XSBHouseInfoSource_MyPublish) {
         self.dealStatusLable.text = NewModel.statusName;
         self.dealStatusLable.textColor = [UIColor whiteColor];
         self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:XSHouseStatusTextColor(NewModel.status, NewModel.dealStatus, NewModel.source) alpha:1];
     }else{
         self.dealStatusLable.text = NewModel.dealStatusName;
         self.dealStatusLable.textColor = [UIColor whiteColor];
         self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:XSHouseStatusTextColor(NewModel.status, NewModel.dealStatus, NewModel.source) alpha:1];
     }
    
    self.watchNumLable.text = [NSString stringWithFormat:@"%@人已关注",NewModel.watchNum];
    self.watchNumBKView.hidden = NewModel.watchNum.intValue > 0?NO:YES;

    


    if (NewModel.houseType == XSBHouseType_New) {
        // 1.标题
        self.titleLable.text = [NSString stringWithFormat:@"%@ (%@)",NewModel.title,NewModel.purposeName];
        // 1.信息描述
        self.infoLable.text = [NSString stringWithFormat:@"%@ %@/建面 %@-%@m2",NewModel.region,NewModel.town,NewModel.minArea,NewModel.maxArea];
        // 1.价格描述
        self.rentPricelabe.text = [NSString stringWithFormat:@"%@万/每套",NewModel.referTotalPrice];
        self.unitPriceLable.text =  [NSString stringWithFormat:@"%@元/平",NewModel.referUnitPrice];
    }else if (NewModel.houseType == XSBHouseType_old){
        // 1.标题
        self.titleLable.text =  [NSString stringWithFormat:@"%@",NewModel.title];;
        // 1.信息描述
        NSString *area = [NSString stringWithFormat:@"%@ m2",NewModel.area];
        self.infoLable.text = [NSString stringWithFormat:@"%@/%@/x楼层 共%@层",area,NewModel.orientationName,NewModel.totalFloor];
        // 1.价格描述
        self.rentPricelabe.text = [NSString stringWithFormat:@"%@万",NewModel.totalPrice];
        self.unitPriceLable.text =  [NSString stringWithFormat:@"%@元/平",NewModel.unitPrice];
    }else{
        // 1.标题
        self.titleLable.text = [NSString stringWithFormat:@"%@",NewModel.title];;
        // 1.信息描述
        NSString *area = [NSString stringWithFormat:@"%@ m2",NewModel.area];
        self.infoLable.text = [NSString stringWithFormat:@"%@/%@/%@",area,NewModel.formType,NewModel.orientationName];
        // 1.价格描述
        self.rentPricelabe.text = [NSString stringWithFormat:@"%@元/每月",NewModel.rentPrice];
        self.unitPriceLable.text =  nil;
    }


    
 
    
    self.statusEditView.status = NewModel.status;
}


NSString * XSHouseStatusTextColor(NSNumber *status, NSNumber *dealStatus, XSBHouseInfoSource source) {
    NSString *color = @"";

    if (source == XSBHouseInfoSource_MyPublish) {
        // 个人 // 1待审核 2审核失败 3已取消 4下架 5暂停 6发布
        if (status.integerValue == XSBHouseSubStatus_DSH) {
            color = @"#E42629"; // 红色
        }else if (status.integerValue == XSBHouseSubStatus_SHSB){
            color = @"#E42629"; // 色
        }else if (status.integerValue == XSBHouseSubStatus_QXFB){
            color = @"#B7B7B9"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_XJ){
            color = @"B7B7B9"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_ZT){
            color = @"B7B7B9"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_FB){
            color = @"#30B936"; // 绿色
        }else{
            color = @"#E42629";// 红色
        }
    }else{
        // 公共 0未出租1是已出租
        if (dealStatus.integerValue == XSBHouseRentStatus_notrent) {
           color = @"#E42629";// 红色
        }else if (dealStatus.integerValue == XSBHouseRentStatus_rent){
           color = @"#FF642A";// 橙色
        }else{
           color = @"#FF642A";// 橙色
        }
    }
    return color;
}
NSString * XSHouseStatusBkColor(NSNumber *status, NSNumber *dealStatus, XSBHouseInfoSource source) {
    NSString *color = @"";

    if (source == XSBHouseInfoSource_MyPublish) {
        // 个人 // 1待审核 2审核失败 3已取消 4下架 5暂停 6发布
        if (status.integerValue == XSBHouseSubStatus_DSH) {
            color = @"待审核"; // 红色
        }else if (status.integerValue == XSBHouseSubStatus_SHSB){
            color = @"审核失败"; // 色
        }else if (status.integerValue == XSBHouseSubStatus_QXFB){
            color = @"已取消"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_XJ){
            color = @"下架"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_ZT){
            color = @"暂停"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_FB){
            color = @"发布"; // 绿色
        }else{
            color = @"其他";// 红色
        }
    }else{
        // 公共 0未出租1是已出租
        if (dealStatus.integerValue == XSBHouseRentStatus_notrent) {
           color = @"未出租";//
        }else if (dealStatus.integerValue == XSBHouseRentStatus_rent){
           color = @"已出租";//
        }else{
           color = @"未出租";//
        }
    }
    return color;

}
@end


#pragma mark -房屋图片
@implementation XSHouseDetailsImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
    lable.text = @"图片";
    lable.font = [UIFont systemFontOfSize:11];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.layer.masksToBounds = YES;
    lable.layer.cornerRadius = 8;
    self.lable = lable;
    
    self.tipLabel.layer.masksToBounds = YES;
    self.tipLabel.layer.cornerRadius = 8;
    self.tipLabel.text = nil;
    self.tipLabel.backgroundColor = [UIColor hb_colorWithHexString:@"#FFFFFF" alpha:0.32];
    WEAK_SELF;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
    cycleScrollView.imageURLStringsGroup = nil;
    cycleScrollView.showPageControl = YES;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
     __weak typeof(SDCycleScrollView *) weakCycleScrollView = cycleScrollView;
    cycleScrollView.itemDidScrollOperationBlock = ^(NSInteger currentIndex) {
        STRONG_SELF;
        NSInteger Index =  currentIndex + 1;
        self.tipLabel.text = [NSString stringWithFormat:@"%ld/%ld",Index,weakCycleScrollView.imageURLStringsGroup.count];
    };
    
    self.cycleScrollView = cycleScrollView;
    [self.bkView addSubview:lable];
    [self.bkView addSubview:cycleScrollView];
    [self.bkView bringSubviewToFront:self.lable];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.cycleScrollView.frame = self.bkView.bounds;
    self.lable.width = 50;
    self.lable.height = 18;
    self.lable.y = self.bkView.height - 28;
    self.lable.centerX = self.bkView.centerX;
    
}
- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    self.model = model;
    self.cycleScrollView.imageURLStringsGroup = model.contentImg;
    self.tipLabel.text = [NSString stringWithFormat:@"1/%ld",self.cycleScrollView.imageURLStringsGroup.count];
}

@end

#pragma mark -基本信息
@implementation XSHouseDetailsBasicInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLable.text = nil;
    self.rentPricelabe.text = nil;
    self.formTypelabe.text = nil;
    self.rarealabe.text = nil;
    self.featurePointsLablea.text = nil;
    self.featurePointsLableb.text = nil;
    self.featurePointsLablec.text = nil;

}

- (void)updateWithModel:(XSHouseInfoShowModel *)dataModel{
    self.model = dataModel;
    self.titleLable.text = [NSString stringWithFormat:@"%@ %@ %@",dataModel.rentWayName,dataModel.estate,dataModel.formType];
    if (dataModel.houseType == XSBHouseType_Rent) {
        self.titleLable.text = dataModel.title;
        self.rentPricelabeBow.text = @"租金";
        self.rentPricelabe.text = [NSString stringWithFormat:@"%@元/每月",dataModel.rentPrice];
    }else{
        self.titleLable.text = dataModel.titleDetail;
        self.rentPricelabeBow.text = @"售价";
        self.rentPricelabe.text = [NSString stringWithFormat:@"%@万",dataModel.totalPrice];
    }
    self.formTypelabe.text = dataModel.formType;
      self.rarealabe.text = [NSString stringWithFormat:@"%@㎡",dataModel.area];
    
    NSString *stra = [dataModel.featurePointNames safeObjectAtIndex:0];;
    NSString *strb = [dataModel.featurePointNames safeObjectAtIndex:1];;
    NSString *strc = [dataModel.featurePointNames safeObjectAtIndex:2];;
    if ([stra isKindOfClass:[NSString class]]) {
        self.featurePointsLablea.text = [NSString stringWithFormat:@"%@",stra];
        self.featurePointsLableb.text = [NSString stringWithFormat:@"%@",strb];;
        self.featurePointsLablec.text = [NSString stringWithFormat:@"%@",strc];;
        self.featurePointsLableaW.constant = stra.length > 0?[self.featurePointsLablea mj_textWidth] + 5:0;
        self.featurePointsLablebW.constant = strb.length > 0?[self.featurePointsLableb mj_textWidth] + 5:0;
        self.featurePointsLablecW.constant = strc.length > 0?[self.featurePointsLablec mj_textWidth] + 5:0;
    }else{
        self.featurePointsLablea.text = nil;
        self.featurePointsLableb.text = nil;
        self.featurePointsLablec.text = nil;;
        self.featurePointsLableaW.constant = [self.featurePointsLablea mj_textWidth];
        self.featurePointsLablebW.constant = [self.featurePointsLableb mj_textWidth];
        self.featurePointsLablecW.constant = [self.featurePointsLablec mj_textWidth];
    }
}


@end

#pragma mark -其它信息
@implementation XSHouseDetailsBusinessInfoCell

- (void)awakeFromNib{
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
     [self.collectionView registerClass:[XSHouseInfoBCollectionCell class] forCellWithReuseIdentifier:XSHouseDetailsBusinessInfoCellStr];
    
}

- (void)updateWithModel:(XSHouseInfoShowModel *)dataModel{
    self.model = dataModel;
    self.array = [dataModel houseInfoBArray];
    [self.collectionView reloadData];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSHouseInfoBModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    XSHouseInfoBCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XSHouseDetailsBusinessInfoCellStr forIndexPath:indexPath];
    cell.model = dataModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XSHouseInfoBModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    if ([dataModel.key isEqualToString:@"other"]) {
        if (self.model.clickBlack) {
            self.model.clickBlack(self.model, nil, XSBHouseKeyValueInfoBMore);
        }
    }
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout =  [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake((KScreenWidth - 30)/2, 19);
        _layout.minimumInteritemSpacing = 0;
        _layout.minimumLineSpacing = 8;
    }
    return _layout;
}


@end



#pragma mark -配套设施
@implementation XSHouseDetailsFacilitiesInfoCell

- (void)awakeFromNib{
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
     [self.collectionView registerClass:[XSFacilitiesCollectionCell class] forCellWithReuseIdentifier:XSHouseDetailsFacilitiesInfoCellStr];
    
}

- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    self.model = model;
    
    NSMutableArray *allArray  =  [[XSPublicServer sharedInstance].facilitiesArray mutableCopy];
    for (XSHouseFacilitiesModel *showModel in allArray) {
        for (NSNumber *number in model.facilities) {
                 if ([number isEqualToNumber:showModel.ID]) {
                     showModel.status = YES;
                 }
             }
    }
     self.array = allArray;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSHouseFacilitiesModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    XSFacilitiesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XSHouseDetailsFacilitiesInfoCellStr forIndexPath:indexPath];
    cell.model = dataModel;
    return cell;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout =  [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake(50, 85);
        _layout.minimumInteritemSpacing = 25 ;
        _layout.minimumLineSpacing = 0;
    }
    return _layout;
}

@end


#pragma mark -地图信息
@implementation XSHouseDetailsAddressInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.locationLable.text = nil;
    UIView *view = self.mapVc.view;
    view.frame = self.mapBkView.bounds;
    [self.mapBkView addSubview:self.mapVc.view];
    
}

- (XSMapViewController *)mapVc{
    if (_mapVc == nil) {
        _mapVc = [[XSMapViewController alloc]init];
    }
    return _mapVc;
}
- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    self.model = model;
    self.locationLable.text = [NSString stringWithFormat:@"%@/%@",model.region,model.estate];
    self.mapVc.location = CLLocationCoordinate2DMake(model.latitude.floatValue, model.longitude.floatValue);
}

@end


#pragma mark -房源介绍
@implementation XSHouseDetailsIntroduceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
    self.line  = view;
    [self.bkView addSubview:view];
    self.btn1.selected = YES;
    self.selbtn = self.btn1;

    [self.btn1 setTitleColor:XSColor(26, 26, 26) forState:UIControlStateNormal];
    [self.btn1 setTitleColor:XSColor(232, 43, 43) forState:UIControlStateSelected];

    [self.btn2 setTitleColor:XSColor(26, 26, 26) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:XSColor(232, 43, 43) forState:UIControlStateSelected];
    [self.btn3 setTitleColor:XSColor(26, 26, 26) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:XSColor(232, 43, 43) forState:UIControlStateSelected];
    [self.btn4 setTitleColor:XSColor(26, 26, 26) forState:UIControlStateNormal];
    [self.btn4 setTitleColor:XSColor(232, 43, 43) forState:UIControlStateSelected];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self lineFrame];
    [self showText];
}
- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    self.model = model;
    if (model.houseType == XSBHouseType_Rent) {
        [self.btn4 removeFromSuperview];
    }
    [self showText];
}

- (IBAction)click:(UIButton *)sender {
    self.btn1.selected = NO;
    self.btn2.selected = NO;
    self.btn3.selected = NO;
    self.btn4.selected = NO;
    sender.selected = YES;
    self.selbtn = sender;
    [self lineFrame];
    [self showText];

}
- (void)showText{
//    if ([self.model isKindOfClass:[XSHouseInfoShowModel class]]) {
//          XSHouseInfoShowModel *dataModel = (XSHouseInfoShowModel *)self.model;
//
//    }else{
//        self.textView.text = nil;
//    }
      if (self.selbtn == self.btn1) {
           self.textView.text = self.model.coreIntroduced;
       }else if (self.selbtn == self.btn2){
           self.textView.text = self.model.estateIntroduced;
       }else if (self.selbtn == self.btn3){
           self.textView.text = self.model.transportation;
       }else if (self.selbtn == self.btn4){
           self.textView.text = self.model.modelIntroduced;
       }else{
           self.textView.text = nil;
       }
}
- (void)lineFrame{
    [UIView animateWithDuration:0.2 animations:^{
        self.line.frame = CGRectMake(self.selbtn.x, self.bkView.height - 1, self.selbtn.width, 1);
    }];

}
- (IBAction)houseSource:(id)sender {
    if (self.model.clickBlack) {
        self.model.clickBlack(self.model, nil, XSBHouseKeyValueIntroduce);
    }
}

@end


#pragma mark -更多推荐
@implementation XSHouseRecommendedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    XSMyPublishHosueController *listvc = [[XSMyPublishHosueController alloc]init];
    listvc.view.frame = self.bkView.bounds;
    self.listvc = listvc;
    [self.bkView addSubview:listvc.view];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.listvc.view.frame = self.bkView.bounds;
}
- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    self.model = model;
    self.listvc.alittle = YES;
    self.listvc.houseType = model.houseType;
    self.listvc.source = XSBHouseInfoSource_HouseIdPush;
    self.listvc.house_id = model.house_id;
    [self.listvc loadData];
}
- (IBAction)more:(id)sender {
    XSMyPublishHosueController *listvc = [[XSMyPublishHosueController alloc]init];
    listvc.houseType = self.model.houseType;
    listvc.source = XSBHouseInfoSource_HouseIdPush;
    listvc.house_id = self.model.house_id;
    [[NSObject getTopViewController].navigationController pushViewController:listvc animated:YES];
}

@end

@implementation XSHouseMasterInfoCell
- (void)awakeFromNib{
    [super awakeFromNib];
     self.callIm.layer.masksToBounds = YES;
     self.callIm.layer.cornerRadius = 5;
     self.cellPhone.layer.masksToBounds = YES;
     self.cellPhone.layer.cornerRadius = 5;
     self.cellPhone.layer.borderWidth = 1;
     self.cellPhone.layer.borderColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1].CGColor;
}
- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    self.model = model;
    [self.image sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"userIcon"]];
    self.name.text = model.callName;
}
- (IBAction)callPhone:(id)sender {
    NSString *telString = [NSString stringWithFormat:@"telprompt://%@",self.model.callPhone];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString] options:@{} completionHandler:nil];
    }
    
}
- (IBAction)callMassage:(id)sender {
    [ProgressHUD showSuccess:@"努力开发中"];
}
@end


@implementation XSHouseInfoBCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        self.contentView.backgroundColor = [UIColor clearColor];

        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.font = [UIFont systemFontOfSize:14];
        titleLable.textAlignment = NSTextAlignmentLeft;

        titleLable.textColor = [UIColor hb_colorWithHexString:@"#BFBFBF" alpha:1];
         [self.contentView addSubview:titleLable];
          self.titleLable = titleLable;
        
        UILabel *contentLable = [[UILabel alloc] init];
         contentLable.backgroundColor = [UIColor clearColor];
         contentLable.font = [UIFont systemFontOfSize:14];
         contentLable.textAlignment = NSTextAlignmentLeft;

         contentLable.textColor = [UIColor hb_colorWithHexString:@"#1A1A1A" alpha:1];
          [self.contentView addSubview:contentLable];
          self.contentLable = contentLable;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor orangeColor];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLable.frame = CGRectMake(0, 0, 45, self.height);
    self.contentLable.frame = CGRectMake(45, 0, self.width - 45, self.height);
}
- (void)setModel:(XSHouseInfoBModel *)model{
    _model = model;
    self.titleLable.text = model.keyName;
    self.contentLable.text = model.value?model.value:nil;
    
}
@end


@implementation XSFacilitiesCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIView *bkView = [[UIView alloc]init];
        bkView.layer.masksToBounds = YES;
        bkView.layer.cornerRadius = 25;

        bkView.backgroundColor = [UIColor hb_colorWithHexString:@"#FF7A7A" alpha:1];
        [self.contentView addSubview:bkView];
        self.bkView = bkView;

        //添加自己需要个子视图控件
        self.contentView.backgroundColor = [UIColor clearColor];

        UIImageView *image = [[UIImageView alloc] init];
         [self.bkView addSubview:image];
         self.image = image;

        UILabel *contentLable = [[UILabel alloc] init];
         contentLable.backgroundColor = [UIColor clearColor];
         contentLable.font = [UIFont systemFontOfSize:12];
         contentLable.textAlignment = NSTextAlignmentCenter;

         contentLable.textColor = [UIColor hb_colorWithHexString:@"#BFBFBF" alpha:1];
          [self.contentView addSubview:contentLable];
          self.contentLable = contentLable;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.bkView.frame = CGRectMake(0, 0, self.width, 50);;
    self.image.frame = self.bkView.bounds;
    self.contentLable.frame = CGRectMake(0, 50, self.width, self.height -50);
}
- (void)setModel:(XSHouseFacilitiesModel *)model{
    _model = model;
    self.bkView.backgroundColor = [UIColor hb_colorWithHexString:model.status?@"#FF7A7A":@"#FFCCCC" alpha:1];
    [self.image  sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.contentLable.text = model.name;
}
@end

