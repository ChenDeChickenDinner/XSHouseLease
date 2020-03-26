//
//  Demo2ViewController.m
//  照片选择器
//
//  Created by 洪欣 on 17/2/17.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import "XSPhotoPickerView.h" 
#import "HXPhotoPicker.h"

static const CGFloat kPhotoViewMargin = 10.0;

@interface XSPhotoPickerView ()<HXPhotoViewDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic)   HXPhotoView *photoView;



@property (assign, nonatomic) BOOL needDeleteItem;

@end

@implementation XSPhotoPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
//        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}
//+ (instancetype)photoPickerViewWithFrame:(CGRect)frame{
//   XSPhotoPickerView *pickerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
//    if (pickerView) {
//        pickerView.frame = frame;
//        [pickerView addSubViews];
////        self.backgroundColor = [UIColor blackColor];
//    }
//    return pickerView;
//}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.scrollView.frame = self.containerView.bounds;
//    self.photoView.frame = CGRectMake(0, kPhotoViewMargin, self.scrollView.width, 0);
//}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(0, 45, self.width, self.height - 45);
    self.photoView.frame = CGRectMake(0, kPhotoViewMargin, self.scrollView.width, 0);
}
- (void)addSubViews{
 
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,23,85,17.5);
    label.text = @"房源图片上传";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor hb_colorWithHexString:@"#929292" alpha:1];;
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    
     UILabel *label2 = [[UILabel alloc] init];
     label2.frame = CGRectMake(105,23,120,17.5);
     label2.font = [UIFont systemFontOfSize:11];
     label2.text = @"(最多上传5张照片)";
     label2.textAlignment = NSTextAlignmentLeft;

     label2.textColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];;
     [self addSubview:label2];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
//    scrollView.backgroundColor = [UIColor yellowColor];
    scrollView.alwaysBounceVertical = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager scrollDirection:UICollectionViewScrollDirectionVertical];
//    photoView.backgroundColor = [UIColor orangeColor];
    photoView.frame = CGRectMake(0, kPhotoViewMargin, self.scrollView.width, 0);
    photoView.collectionView.contentInset = UIEdgeInsetsMake(0, kPhotoViewMargin, 0, kPhotoViewMargin);
    photoView.delegate = self; //
    photoView.outerCamera = YES; // 是否把相机功能放在外面 默认NO
    
    photoView.lineCount = 3; // 每行个数 默认 3 cell的宽高取决于 每行个数 与 HXPhotoView 的宽度 和 item间距
    photoView.spacing = kPhotoViewMargin; // 每个item间距 默认 3
    photoView.showAddCell = YES; // 是否显示添加的cell 默认 YES
    //    photoView.addImageName = nil; // 添加按钮的图片
    //    photoView.deleteImageName = nil; // 删除按钮图片

    photoView.previewShowDeleteButton = YES; // 预览大图时是否显示删除按钮
    photoView.previewStyle = HXPhotoViewPreViewShowStyleDefault; //预览大图时的风格样式
    photoView.adaptiveDarkness = YES;// 底部选择视图是否自适应暗黑风格
    photoView.updateFrameBlock = ^(CGRect frame) {
        
        NSLog(@"frame:%@",NSStringFromCGRect(frame));
    };
    
    [photoView.collectionView reloadData];
    [scrollView addSubview:photoView];
    self.photoView = photoView;
}

- (void)setChangeCompleteBlock:(HXPhotoViewChangeCompleteBlock)changeCompleteBlock{
    _changeCompleteBlock = changeCompleteBlock;
    self.photoView.changeCompleteBlock = changeCompleteBlock;

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
    }else  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *url = info[UIImagePickerControllerMediaURL];
        
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools saveVideoToCustomAlbumWithName:self.manager.configuration.customAlbumName videoURL:url location:nil complete:^(HXPhotoModel *model, BOOL success) {
                if (success) {
                    if (weakSelf.manager.configuration.useCameraComplete) {
                        weakSelf.manager.configuration.useCameraComplete(model);
                    }
                }else {
                    [weakSelf hx_showImageHUDText:@"保存视频失败"];
                }
            }];
        }else {
            HXPhotoModel *model = [HXPhotoModel photoModelWithVideoURL:url];
            if (self.manager.configuration.useCameraComplete) {
                self.manager.configuration.useCameraComplete(model);
            }
        }
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}








/**
 照片/视频发生改变、HXPohotView初始化、manager赋值时调用 - 选择、移动顺序、删除、刷新视图
 调用 refreshView 会触发此代理
 
 @param photoView self
 @param allList 所有类型的模型数组
 @param photos 照片类型的模型数组
 @param videos 视频类型的模型数组
 @param isOriginal 是否原图
 */
- (void)photoView:(HXPhotoView *)photoView
   changeComplete:(NSArray<HXPhotoModel *> *)allList
           photos:(NSArray<HXPhotoModel *> *)photos
           videos:(NSArray<HXPhotoModel *> *)videos
         original:(BOOL)isOriginal{
//         HXPhotoModel *photoModel = allList.firstObject;
         
         [allList hx_requestImageWithOriginal:isOriginal completion:^(NSArray<UIImage *> * _Nullable imageArray, NSArray<HXPhotoModel *> * _Nullable errorArray) {
             // imageArray 获取成功的image数组
             // errorArray 获取失败的model数组
             NSSLog(@"\nimage: %@\nerror: %@",imageArray,errorArray);
         }];
}

- (void)photoViewChangeComplete:(HXPhotoView *)photoView
                   allAssetList:(NSArray<PHAsset *> *)allAssetList
                    photoAssets:(NSArray<PHAsset *> *)photoAssets
                    videoAssets:(NSArray<PHAsset *> *)videoAssets
                       original:(BOOL)isOriginal{
                           
}

/**
 相册相片列表点击了完成按钮/删除/移动、HXPohotView初始化且有数据、manager赋值且有数据时
 调用 refreshView 不会触发此代理

 @param photoView self
 @param allList 所有类型的模型数组
 @param photos 照片类型的模型数组
 @param videos 视频类型的模型数组
 @param isOriginal 是否原图
 */
- (void)photoListViewControllerDidDone:(HXPhotoView *)photoView
                               allList:(NSArray<HXPhotoModel *> *)allList
                                photos:(NSArray<HXPhotoModel *> *)photos
                                videos:(NSArray<HXPhotoModel *> *)videos
                              original:(BOOL)isOriginal{
                                  
                              }

/**
 点击了添加cell的事件

 @param photoView self
 */
- (void)photoViewDidAddCellClick:(HXPhotoView *)photoView{
    
}

/**
 当view高度改变时调用

 @param photoView self
 @param frame 位置大小
 */
- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame{
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);

}

/**
 点击取消时调用

 @param photoView self
 */
- (void)photoViewDidCancel:(HXPhotoView *)photoView{
    
}

/**
 删除网络图片时调用

 @param photoView self
 @param networkPhotoUrl 被删除的图片地址
 */
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl{
    
}

/**
 当前删除的模型

 @param photoView self
 @param model 模型
 @param index 下标
 */
- (void)photoView:(HXPhotoView *)photoView currentDeleteModel:(HXPhotoModel *)model currentIndex:(NSInteger)index{
    NSSLog(@"currentDeleteModel %@ --> index - %ld",model,index);

}

/**
 长按手势结束时是否删除当前拖动的cell
 
 @param photoView self
 @return 是否删除
 */
- (BOOL)photoViewShouldDeleteCurrentMoveItem:(HXPhotoView *)photoView
                           gestureRecognizer:(UILongPressGestureRecognizer *)longPgr
                                   indexPath:(NSIndexPath *)indexPath{
   return self.needDeleteItem;

}

/**
 长按手势发生改变时调用

 @param photoView self
 @param longPgr 长按手势识别器
 */
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerChange:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath{
    CGPoint point = [longPgr locationInView:self];
    NSSLog(@"长按手势改变了 %@ - %ld",NSStringFromCGPoint(point), indexPath.item);
}

/**
 长按手势开始时调用

 @param photoView self
 @param longPgr 长按手势识别器
 */
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerBegan:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath{
    NSSLog(@"长按手势开始了 - %ld",indexPath.item);

}

/**
 长按手势结束时调用

 @param photoView self
 @param longPgr 长按手势识别器
 */
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerEnded:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath{
        CGPoint point = [longPgr locationInView:self];
    //        [self.photoView deleteModelWithIndex:indexPath.item];

        NSSLog(@"长按手势结束了 - %ld",indexPath.item);
}

/**
 collectionView是否可以选择item（不包括添加按钮）

 @param photoView self
 @param indexPath 选择Cell的indexPath
 @return yes 可以选 no 不可以,点击无反应
 */
- (BOOL)photoView:(HXPhotoView *)photoView collectionViewShouldSelectItemAtIndexPath:(NSIndexPath *)indexPath model:(HXPhotoModel *)model{
    return YES;

}

/// 当前选择的model数组，不是已经选择的model数组
/// 例: 已经选择了 照片1、视频1，再跳转相册选择了照片2、视频2，那么一共就是 照片1、视频1、照片2、视频2.那这个代理返回的数据就是 照片2、视频2
/// 只有在相册列表点了确定按钮才会触发
/// @param allList 所有类型
/// @param photos 照片类型
/// @param videos 视频类型
/// @param isOriginal 是否原图
- (void)photoViewCurrentSelected:(NSArray<HXPhotoModel *> *)allList
                          photos:(NSArray<HXPhotoModel *> *)photos
                          videos:(NSArray<HXPhotoModel *> *)videos
                        original:(BOOL)isOriginal{
    for (HXPhotoModel *photoModel in allList) {
          NSSLog(@"当前选择----> %@", photoModel.selectIndexStr);
      }
}

/// 取消预览大图的回调
/// @param photoView self
- (void)photoViewPreviewDismiss:(HXPhotoView *)photoView{
    
}

/// 实现这个代理返回的高度就是HXPhotoView的高度，不会进行自动计算高度.
/// 每次需要更新高度的时候触发，请确保高度正确
/// @param photoView self
//- (CGFloat)photoViewHeight:(HXPhotoView *)photoView{
//
//}



- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.openCamera = YES;  //是否打开相机功能
        _manager.configuration.photoStyle = HXPhotoStyleDefault; // 相册风格
        _manager.configuration.albumShowMode = HXPhotoAlbumShowModeDefault; // 相册风格

        
        _manager.configuration.maxNum = 5;
        _manager.configuration.photoMaxNum = 5;
        _manager.configuration.videoMaxNum = 0;
        
        _manager.configuration.photoCanEdit = NO;///  照片是否可以编辑   default YES
        _manager.configuration.limitPhotoSize = 0; // 限制照片的大小 单位：b 字节 默认 0字节 不限制
        _manager.configuration.selectPhotoLimitSize = NO; // 选择视频时是否限制照片大小

        _manager.configuration.showOriginalBytes = YES; // 原图按钮显示已选照片的大小
        _manager.configuration.showOriginalBytesLoading = YES; // 原图按钮显示已选照片大小时是否显示加载菊花
        _manager.configuration.requestImageAfterFinishingSelection = YES; /// 在照片列表选择照片完后点击完成时是否请求图片和视频地址
        _manager.configuration.clarityScale = [UIScreen mainScreen].bounds.size.width;  //小图照片清晰度 越大越清晰、越消耗性能

        
        _manager.configuration.themeColor = [UIColor whiteColor]; // 主题颜色  默认 tintColor
        _manager.configuration.creationDateSort = YES;/// 照片列表是否按照片添加日期排序  默认YES
        _manager.configuration.saveSystemAblum = NO; //拍摄的 照片/视频 是否保存到系统相册  默认NO
        _manager.configuration.selectTogether = NO;  // 图片和视频是否能够同时选择 默认 NO
        _manager.configuration.lookGifPhoto = NO;  //是否开启查看GIF图片功能 - 默认开启
       _manager.configuration.cameraCellShowPreview = YES;  //相机cell是否显示预览
        _manager.configuration.downloadICloudAsset = NO; //下载iCloud上的资源  默认YES

        _manager.configuration.hideOriginalBtn = NO;  //是否隐藏原图按钮  默认 NO
        _manager.configuration.originalNormalImageName = nil;  //原图按钮普通状态下的按钮图标名
        _manager.configuration.originalSelectedImageName = nil;  //原图按钮选中状态下的按钮图标名


        _manager.configuration.navBarBackgroudColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1]; // 导航栏背景颜色
        _manager.configuration.statusBarStyle = UIStatusBarStyleLightContent; // 状态栏样式 默认 UIStatusBarStyleDefault
        _manager.configuration.navigationTitleColor = [UIColor whiteColor]; // 导航栏标题颜色
        _manager.configuration.cellSelectedBgColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];  // cell选中时的背景颜色
        _manager.configuration.cellSelectedTitleColor = [UIColor whiteColor];  // cell选中时的文字颜色
        _manager.configuration.selectedTitleColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];  // 选中时数字的颜色
        _manager.configuration.navBarTranslucent = NO;  //导航栏是否半透明，默认YES
        _manager.configuration.bottomViewBgColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1]; // 底部视图的背景颜色
        _manager.configuration.bottomViewTranslucent = NO; // 底部视图是否半透明效果 默认YES
//        _manager.configuration.navBarBackgroundImage = [UIImage imageNamed:@"APPCityPlayer_bannerGame"];
        HXWeakSelf
        _manager.configuration.photoListBottomView = ^(HXPhotoBottomView *bottomView) {
//            bottomView.bgView.translucent = NO;
//            if ([HXPhotoCommon photoCommon].isDark) {
//                bottomView.bgView.barTintColor = [UIColor blackColor];
//            }else {
//                bottomView.bgView.barTintColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
//            }
        };
        _manager.configuration.previewBottomView = ^(HXPhotoPreviewBottomView *bottomView) {
//            bottomView.bgView.translucent = NO;
//            bottomView.tipView.translucent = NO;
//            if ([HXPhotoCommon photoCommon].isDark) {
//                bottomView.bgView.barTintColor = [UIColor blackColor];
//                bottomView.tipView.barTintColor = [UIColor blackColor];
//            }else {
//                bottomView.bgView.barTintColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
//                bottomView.tipView.barTintColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
//            }
        };
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}
@end
