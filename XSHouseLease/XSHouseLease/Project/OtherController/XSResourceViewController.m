//
//  XSResourceViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/4/19.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSResourceViewController.h"
#import "XSLogInVcModel.h"
@interface XSResourceViewController ()<UITextFieldDelegate,HXPhotoViewDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *renzhen;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *addess;
@property (weak, nonatomic) IBOutlet UITextField *manName;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@end

@implementation XSResourceViewController
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    self.photoView.frame = self.renzhen.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"中介信息认证";
    self.dict = [NSMutableDictionary dictionary];
    self.name.delegate = self;
    self.addess.delegate = self;
    self.manName.delegate = self;
    self.code.delegate = self;
    self.phone.delegate = self;
     self.photoView = [[HXPhotoView alloc]initWithFrame:CGRectMake(0, 0, 77, 77) manager:self.manager];
     self.photoView.delegate = self; //
     self.photoView.outerCamera = YES; // 是否把相机功能放在外面 默认NO
     self.photoView.editEnabled = NO;
     self.photoView.lineCount = 1; // 每行个数 默认 3 cell的宽高取决于 每行个数 与 HXPhotoView 的宽度 和 item间距
     self.photoView.spacing = 0; // 每个item间距 默认 3
     self.photoView.showAddCell = YES; // 是否显示添加的cell 默认 YES

     self.photoView.previewShowDeleteButton = YES; // 预览大图时是否显示删除按钮
     self.photoView.previewStyle = HXPhotoViewPreViewShowStyleDefault; //预览大图时的风格样式
     self.photoView.adaptiveDarkness = YES;// 底部选择视图是否自适应暗黑风格
    WEAK_SELF;
     self.photoView.changeCompleteBlock = ^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photos, NSArray<HXPhotoModel *> *videos, BOOL isOriginal) {
        STRONG_SELF;
        for (HXPhotoModel *photoModel in photos) {
            [photoModel requestImageURLStartRequestICloud:nil progressHandler:nil success:^(NSURL * _Nullable imageURL, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
                [self loadAllImageWithStr:imageURL];
            } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
                
            }];
        }
     };
    [self.renzhen addSubview:self.photoView];


}
- (void)loadAllImageWithStr:(NSURL *)imageURL{
    WEAK_SELF;
     [self.subInfoInterface uploadImage:[UIImage imageNamed:@""] imageUrl:imageURL callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
         STRONG_SELF;
            if (error == nil && responseModel.code.integerValue == SuccessCode) {
                [self.dict safeSetObject:responseModel.data forKey:@"licenseImg"];
            }else{
                [ProgressHUD showError:@"执照上传失败，请重新选择" Interaction:YES];
            }
     }];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        if (textField == self.name) {
            [self.dict safeSetObject:textField.text forKey:@"company"];
        }else if (textField == self.addess){
            [self.dict safeSetObject:textField.text forKey:@"address"];
        }else if (textField == self.manName){
            [self.dict safeSetObject:textField.text forKey:@"legalName"];
        }else if (textField == self.code){
            [self.dict safeSetObject:textField.text forKey:@"legalId"];
        }else if (textField == self.phone){
            [self.dict safeSetObject:textField.text forKey:@"tel"];
        }
    }
}
- (IBAction)sub:(id)sender {

//    else if (![XSLogInVcModel validateContactNumber:(NSString *)[self.dict objectForKey:@"tel"]]){
//        [ProgressHUD showError:@"请填写正确的联系方式" Interaction:YES];
//    }
    
     if (![self.dict objectForKey:@"licenseImg"]){
        [ProgressHUD showError:@"请上传执照" Interaction:YES];
    }else if (![self.dict objectForKey:@"company"]) {
        [ProgressHUD showError:@"请填写公司名称" Interaction:YES];
    }else if (![self.dict objectForKey:@"address"]){
        [ProgressHUD showError:@"请填写公司地址" Interaction:YES];
    }else if (![self.dict objectForKey:@"legalName"]){
        [ProgressHUD showError:@"请填写法人姓名" Interaction:YES];
    }else if (![self.dict objectForKey:@"legalId"]){
        [ProgressHUD showError:@"请填写法人身份证号" Interaction:YES];
    }else if (![self.dict objectForKey:@"tel"]){
        [ProgressHUD showError:@"请填写联系方式" Interaction:YES];
    }else{
        [self.dict safeSetObject:@(0) forKey:@"status"];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        WEAK_SELF;
        [self.subInfoInterface saveagencyWithDict:self.dict callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
            [MBProgressHUD  hideHUDForView:self.view animated:YES];
            [NSThread sleepForTimeInterval:0.25];
            [ProgressHUD showError:@"认证申请已提交" Interaction:YES];
            [XSUserServer sharedInstance].userModel.agency = YES;
            NSDictionary *dict =  [[XSUserServer sharedInstance].userModel mj_keyValues];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userInfo"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
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
    _manager.configuration.maxNum = 1;
    _manager.configuration.photoMaxNum = 1;
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
