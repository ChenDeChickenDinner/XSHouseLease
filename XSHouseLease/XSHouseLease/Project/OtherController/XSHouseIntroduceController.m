//
//  XSHouseIntroduceController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseIntroduceController.h"
#import "XSHouseSubTableViewCell.h"
#import "XSPhotoPickerView.h"
#import "XSHouseSubSuccessViewController.h"
#import "XSHouseMasterInfoView.h"
#import "XSHouseInfoShowCell.h"



@interface XSHouseIntroduceController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet XSHouseMasterInfoView *callView;
@property (strong, nonatomic) NSMutableArray<XSHouseMoreInfoCellMdeol *> *array;
@property(nonatomic,copy) NSString *cellClass;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation XSHouseIntroduceController
- (NSMutableArray<XSHouseMoreInfoCellMdeol *> *)array{
    if (!_array) {
        _array = [NSMutableArray array];
        if (self.infoType == XSBHouseKeyValueIntroduce) {
            XSHouseMoreInfoCellMdeol *model1 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model1.title = @"核心卖点";
            model1.value = self.dataModel.coreIntroduced;
            model1.cellClass = @"XSHouseSubTextViewCell";
            model1.cellHeight = [NSNumber numberWithInt:90];
            
            XSHouseMoreInfoCellMdeol *model11 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model11.title = @"户型介绍";
            model11.value = self.dataModel.modelIntroduced;
            model11.cellClass = @"XSHouseSubTextViewCell";
            model11.cellHeight = [NSNumber numberWithInt:90];
            
            XSHouseMoreInfoCellMdeol *model2 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model2.title = @"交通出行";
            model2.value = self.dataModel.transportation;
            model2.cellClass = @"XSHouseSubTextViewCell";
            model2.cellHeight = [NSNumber numberWithInt:90];
            
            XSHouseMoreInfoCellMdeol *model3 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model3.title = @"小区介绍";
            model3.value = self.dataModel.estateIntroduced;
            model3.cellClass = @"XSHouseSubTextViewCell";
            model3.cellHeight = [NSNumber numberWithInt:90];

            [_array addObject:model1];
            if (self.houseType == XSBHouseType_old)[_array addObject:model11];
            [_array addObject:model2];
            [_array addObject:model3];
        }else if (self.infoType == XSBHouseKeyValueInfoSMore){
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.itemSize = CGSizeMake(KScreenWidth -30, 19);
            layout.minimumInteritemSpacing = 0;
            layout.minimumLineSpacing = 8;
                    
            XSHouseMoreInfoCellMdeol *model1 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model1.title = @"基础属性";
            model1.cellClass = @"XSHouseDetailsBusinessInfoCell";
            model1.cellHeight = [NSNumber numberWithInt:244];
            model1.keyValueModuleModel = [self.dataModel houseInfoBArrayWithSourceType:secondHouseBaseInfo sourceDict:nil];
            model1.keyValueModuleModel.layout =layout;
            
            
            XSHouseMoreInfoCellMdeol *model2 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model2.title = @"交易属性";
            model2.cellClass = @"XSHouseDetailsBusinessInfoCell";
            model2.cellHeight = [NSNumber numberWithInt:244];
            model2.keyValueModuleModel = [self.dataModel houseInfoBArrayWithSourceType:secondHouseTradingInfo sourceDict:nil];
            model2.keyValueModuleModel.layout =layout;

            [_array addObject:model1];
            [_array addObject:model2];
        }else if (self.infoType == XSBHouseKeyValueInfoNMore){
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.itemSize = CGSizeMake(KScreenWidth -30, 19);
            layout.minimumInteritemSpacing = 0;
            layout.minimumLineSpacing = 8;
                    
            XSHouseMoreInfoCellMdeol *model1 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model1.title = @"基础属性";
            model1.cellClass = @"XSHouseDetailsBusinessInfoCell";
            model1.cellHeight = [NSNumber numberWithInt:360];
            model1.keyValueModuleModel = [self.dataModel houseInfoBArrayWithSourceType:newHouseBaseInfo sourceDict:[self.dataModel.basic mj_keyValues]];
            model1.keyValueModuleModel.layout =layout;
            
            
            XSHouseMoreInfoCellMdeol *model2 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model2.title = @"销售信息";
            model2.cellClass = @"XSHouseDetailsBusinessInfoCell";
            model2.cellHeight = [NSNumber numberWithInt:187];
            model2.keyValueModuleModel = [self.dataModel houseInfoBArrayWithSourceType:newHouseTradingInfo sourceDict:[self.dataModel.sellBasic mj_keyValues]];
            model2.keyValueModuleModel.layout =layout;

            XSHouseMoreInfoCellMdeol *model3 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model3.title = @"小区概况";
            model3.cellClass = @"XSHouseDetailsBusinessInfoCell";
            model3.cellHeight = [NSNumber numberWithInt:381];
            model3.keyValueModuleModel = [self.dataModel houseInfoBArrayWithSourceType:newHouseEstateInfo sourceDict:[self.dataModel.estateBasic mj_keyValues]];
            model3.keyValueModuleModel.layout =layout;


            XSHouseMoreInfoCellMdeol *model4 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model4.title = @"预售许可证";
            model4.cellClass = @"XSHouseDetailsBusinessInfoCell";
            model4.cellHeight = [NSNumber numberWithInt:138];
            model4.keyValueModuleModel = [self.dataModel houseInfoBArrayWithSourceType:newHouseDataLicenceInfo sourceDict:[self.dataModel.licenceBasic mj_keyValues]];
            model4.keyValueModuleModel.layout =layout;

            [_array addObject:model1];
            [_array addObject:model2];
            [_array addObject:model3];
            [_array addObject:model4];
        }else if (self.infoType == XSBHouseKeyValueInfoLDIX){
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
           layout.itemSize = CGSizeMake((KScreenWidth -30)/2, 19);
           layout.minimumInteritemSpacing = 0;
           layout.minimumLineSpacing = 8;
            for (XSHouseDetailsDataBuildingCellBasicInfosModel *infoModel in self.dataModel.buildingCellBasic.infos) {
                  XSHouseMoreInfoCellMdeol *model1 = [[XSHouseMoreInfoCellMdeol alloc]init];
                  model1.title = infoModel.cellNum?infoModel.cellNum.stringValue:nil;
                  model1.cellClass = @"XSHouseDetailsBusinessInfoCell";
                  model1.cellHeight = [NSNumber numberWithInt:130];
                  model1.keyValueModuleModel = [self.dataModel houseInfoBArrayWithSourceType:newHouseLdxiInfo sourceDict:[infoModel mj_keyValues]];
                  model1.keyValueModuleModel.title = [NSString stringWithFormat:@"%@号楼",infoModel.cellNum];
                  model1.keyValueModuleModel.layout =layout;
                [_array addObject:model1];

            }
        }
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.infoType == XSBHouseKeyValueIntroduce) {
        self.title = @"房源详情";
    }else if (self.infoType == XSBHouseKeyValueInfoSMore){
        self.title = @"房源信息";
    }else if (self.infoType == XSBHouseKeyValueInfoNMore){
        self.title = @"楼盘基础信息";
    }else if (self.infoType == XSBHouseKeyValueInfoLDIX){
        self.title = @"楼栋信息";
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, KScreenWidth, 281);
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.buildingCellBasic.contentImg]];

        self.tableView.tableHeaderView = imageView;
    }
    self.callView.model = self.dataModel;;
    if ([self.dataModel.house_id isEqual:[XSUserServer sharedInstance].userModel.ID]) {
        [self.callView removeFromSuperview];
    }

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XSHouseMoreInfoCellMdeol *dataModel = [self.array safeObjectAtIndex:indexPath.row];

    return dataModel.cellHeight?dataModel.cellHeight.floatValue:53.0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseMoreInfoCellMdeol *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    if ([dataModel.cellClass isEqualToString:@"XSHouseSubTextViewCell"]) {
        XSHouseSubTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dataModel.cellClass];
            if (!cell) {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XSHouseSubTableViewCell class]) owner:self options:nil];
                cell = [array safeObjectAtIndex:[XSHouseSubTableViewCell indexForClassName:dataModel.cellClass]];
            }
          cell.keyValueModel = dataModel;
          return cell;
    }else{
        XSHouseDetailsBusinessInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:dataModel.cellClass];
        if (!cell) {
               NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"XSHouseInfoShowCell" owner:self options:nil];
               cell = [array safeObjectAtIndex:[XSHouseInfoCell indexForClassName:dataModel.cellClass]];
         }
        cell.keyValueModuleModel = dataModel.keyValueModuleModel;
        return cell;
    }
    return nil;
}
@end

@implementation XSHouseMoreInfoCellMdeol



@end
