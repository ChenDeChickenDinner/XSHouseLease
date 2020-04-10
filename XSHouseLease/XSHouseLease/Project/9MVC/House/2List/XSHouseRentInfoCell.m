//
//  XSHouseRentInfoCell.m
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseRentInfoCell.h"



#pragma mark -基础类
@implementation XSHouseInfoCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;;
}
- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    _model = model;
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
    XSHouseRentStatusView *statusView = [[XSHouseRentStatusView alloc]init];
    WEAK_SELF;
    self.statusEditView.clickEditStatus = ^(NSNumber * _Nonnull status,NSNumber * _Nonnull houseID) {
        STRONG_SELF;
        XSHouseInfoShowModel *newModel = (XSHouseInfoShowModel *)self.model;
        newModel.clickEditStatu(status,newModel.house_id);
    };
    
    [self.statusEditView addSubview:statusView];
    
}

- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    self.model = model;
    XSHouseInfoShowModel *newModel = (XSHouseInfoShowModel *)self.model;
    self.titleLable.text = newModel.title;
    [self.image sd_setImageWithURL:[NSURL URLWithString:newModel.firstImg]];
    [self.image sd_setImageWithURL:[NSURL URLWithString:newModel.firstImg] placeholderImage:[UIImage imageNamed:@"houseDefImage"]];
    NSString *area = [NSString stringWithFormat:@"%@ m2",newModel.area];
    self.infoLable.text = [NSString stringWithFormat:@"%@/%@/%@",area,newModel.formType,newModel.orientationName];
    
    NSString *stra = [newModel.featurePointNames safeObjectAtIndex:0];;
    NSString *strb = [newModel.featurePointNames safeObjectAtIndex:1];;
    NSString *strc = [newModel.featurePointNames safeObjectAtIndex:2];;

    self.featurePointsLablea.text = stra;
    self.featurePointsLableb.text = strb;
    self.featurePointsLablec.text = strc;
    self.featurePointsLableaW.constant = stra.length > 0?[self.featurePointsLablea mj_textWidth] + 5:0;
    self.featurePointsLablebW.constant = strb.length > 0?[self.featurePointsLableb mj_textWidth] + 5:0;
    self.featurePointsLablecW.constant = strc.length > 0?[self.featurePointsLablec mj_textWidth] + 5:0;

    self.rentPricelabe.text = [NSString stringWithFormat:@"%@元/每月",newModel.rentPrice];
    self.watchNumLable.text = [NSString stringWithFormat:@"%@人已关注",newModel.watchNum];
    self.watchNumBKView.hidden = newModel.watchNum.intValue > 0?NO:YES;
    
    if (newModel.source == XSBHouseInfoSource_MyPublish) {
        self.statusEditViewHeight.constant = 23.0;
        self.dealStatusLable.text = newModel.statusName;
        self.dealStatusLable.textColor = [UIColor whiteColor];
        self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:XSHouseStatusTextColor(newModel.status, newModel.dealStatus, newModel.source) alpha:1];
    }else{
       
        self.dealStatusLable.text = newModel.dealStatusName;
        self.dealStatusLable.textColor = [UIColor whiteColor];
        self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:XSHouseStatusTextColor(newModel.status, newModel.dealStatus, newModel.source) alpha:1];
        self.statusEditViewHeight.constant = 0;
        [self.statusEditView removeFromSuperview];
    }
    
    self.statusEditView.status = newModel.status;
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
    [self.bkView bringSubviewToFront:self.tipLabel];

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
    self.rentPricelabe.text = [NSString stringWithFormat:@"%@元/每月",dataModel.rentPrice];
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
     [self.collectionView registerClass:[XSBusinessCollectionCell class] forCellWithReuseIdentifier:XSHouseDetailsBusinessInfoCellStr];
    
}

- (void)updateWithModel:(XSHouseInfoShowModel *)dataModel{
    self.model = dataModel;
    NSMutableDictionary *modeDict = [dataModel mj_keyValues];
    NSMutableArray *infoArray = [NSMutableArray array];
    for (XSBusinessInfoJsonModel *infoJsonModel in [XSConfigServer sharedInstance].businessInfoArray) {
        XSBusinessInfoModel *infoModel = [[XSBusinessInfoModel alloc]init];
        infoModel.name = infoJsonModel.keyName ;
        infoModel.value = [NSString stringWithFormat:@"%@",[modeDict safeObjectForKey:infoJsonModel.key]];
        [infoArray addObject:infoModel];
    }
        
    self.array = infoArray;
    [self.collectionView reloadData];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSBusinessInfoModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    XSBusinessCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XSHouseDetailsBusinessInfoCellStr forIndexPath:indexPath];
    cell.model = dataModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XSBusinessInfoModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    if (dataModel.clickBlack) {
        dataModel.clickBlack(dataModel);
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
    
    NSMutableArray *allArray  =  [[XSConfigServer sharedInstance].facilitiesInfoArray mutableCopy];
    for (XSHouseDetailsFacilitiesModel *showModel in allArray) {
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
    XSHouseDetailsFacilitiesModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
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
    self.locationLable.text = [NSString stringWithFormat:@"%@/%@",model.region,model.town];
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
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self lineFrame];
    [self showText];
}
- (IBAction)click:(UIButton *)sender {
    self.btn1.selected = NO;
    self.btn2.selected = NO;
    self.btn3.selected = NO;
    sender.selected = YES;
    self.selbtn = sender;
    [self lineFrame];
    [self showText];

}
- (void)showText{
    if ([self.model isKindOfClass:[XSHouseInfoShowModel class]]) {
          XSHouseInfoShowModel *dataModel = (XSHouseInfoShowModel *)self.model;
          if (self.selbtn == self.btn1) {
              self.textView.text = dataModel.coreIntroduced;
          }else if (self.selbtn == self.btn2){
              self.textView.text = dataModel.estateIntroduced;
          }else if (self.selbtn == self.btn3){
              self.textView.text = dataModel.transportation;
          }else{
              self.textView.text = nil;
          }
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
    XSHouseInfoShowModel *dataModel = (XSHouseInfoShowModel *)self.model;
    
    XSKeyValue *model1 = [[XSKeyValue alloc]init];
    model1.key = @"核心卖点";
    model1.value = dataModel.coreIntroduced;
    model1.cellClass = @"XSHouseSubTextViewCell";
    model1.cellHeight = [NSNumber numberWithInt:90];
    XSKeyValue *model2 = [[XSKeyValue alloc]init];
    model2.key = @"交通出行";
    model2.value = dataModel.transportation;
    model2.cellClass = @"XSHouseSubTextViewCell";
    model2.cellHeight = [NSNumber numberWithInt:90];
    
    XSKeyValue *model3 = [[XSKeyValue alloc]init];
    model3.key = @"小区介绍";
    model3.value = dataModel.estateIntroduced;
    model3.cellClass = @"XSHouseSubTextViewCell";
    model3.cellHeight = [NSNumber numberWithInt:90];

    NSMutableArray *array = [NSMutableArray array];
    [array addObject:model1];
    [array addObject:model2];
    [array addObject:model3];

    XSHouseIntroduceController *vc = [[XSHouseIntroduceController alloc]init];
    vc.array = array;
    
    UIViewController *nav = [NSObject getTopViewController];
    [nav.navigationController pushViewController:vc animated:YES];
}
- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    self.model = model;
    [self showText];
}

@end


#pragma mark -更多推荐
@implementation XSHouseRecommendedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    XSMyPublishHosueController *listvc = [[XSMyPublishHosueController alloc]init];
    listvc.source = XSBHouseInfoSource_MyPush;
    listvc.alittle = YES;
    listvc.view.frame = self.bkView.bounds;
    self.listvc =listvc;
    [self.bkView addSubview:listvc.view];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.listvc.view.frame = self.bkView.bounds;
}
- (void)updateWithModel:(XSHouseInfoShowModel *)model{
    self.model = model;
    self.listvc.house_id = model.house_id;
    [self.listvc loadData];
}
- (IBAction)more:(id)sender {
    XSHouseInfoShowModel *dataModel = (XSHouseInfoShowModel *)self.model;
    XSMyPublishHosueController *listvc = [[XSMyPublishHosueController alloc]init];
    listvc.source = XSBHouseInfoSource_MyPush;
    listvc.house_id = dataModel.house_id;
    [[NSObject getTopViewController].navigationController pushViewController:listvc animated:YES];
}

@end
