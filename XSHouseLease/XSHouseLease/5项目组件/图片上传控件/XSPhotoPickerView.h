//
//  Demo2ViewController.h
//  照片选择器
//
//  Created by 洪欣 on 17/2/17.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSPhotoPickerView : UIView
+ (instancetype)photoPickerViewWithFrame:(CGRect)frame;
@property (strong, nonatomic) NSMutableArray<NSString *> *imageUrlArray;
@property (copy, nonatomic) HXPhotoViewChangeCompleteBlock changeCompleteBlock;
@end
