//
//  XSHouseSubTableViewCell.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSHouseRentInfoModel.h"


@interface XSHouseSubTableViewCell : UITableViewCell
@property(nonatomic,strong) XSHouseInfoCellModel *dataModel;
- (void)refreshData;
+ (NSInteger)indexForClassName:(NSString *)className;
@end


@interface XSHouseSubListChooseTableViewCell : XSHouseSubTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *value;

@end

@interface XSHouseSubTextFieldTableViewCell : XSHouseSubTableViewCell<UITextFieldDelegate>
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

@interface XSHouseSubTextViewCell : XSHouseSubTableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextView *textView ;
@end

@interface XSHouseSubCollectionviewACell : XSHouseSubTableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewWidth;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@end

@interface XSHouseSubCollectionviewBCell : XSHouseSubTableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView ;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@end

@interface XSHouseSubPictureSubmitCell : XSHouseSubTableViewCell<HXPhotoViewDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic) IBOutlet HXPhotoView *photoView;

@end
@interface XSHouseSubProcessViewCell : XSHouseSubTableViewCell

@end

