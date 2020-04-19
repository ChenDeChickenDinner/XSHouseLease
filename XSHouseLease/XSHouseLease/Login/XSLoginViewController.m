//
//  XSLoginViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSLoginViewController.h"
#import "XSRoundedView.h"
#import "XSLogInVcModel.h"
#import "XSUserLogInModel.h"

#define MessageWaitTime 60



typedef void (^sendMessageSuccessful)(BOOL successful);

@interface XSLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *picyureCheckView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picyureCheckViewHeight;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pictureTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreedBtn;


@property (strong, nonatomic)  XSLogInVcModel *logInModel;
@property (strong, nonatomic)  CADisplayLink *displayLink;

@property (assign, nonatomic)  NSUInteger midCount;

@end

@implementation XSLoginViewController
- (XSLogInVcModel *)logInModel{
    if (!_logInModel) {
        _logInModel = [[XSLogInVcModel alloc]init];
    }
    return _logInModel;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
     self.displayLink = nil;
    [self.view endEditing:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneTextField.delegate = self;
    self.pictureTextField.delegate = self;
    self.messageTextField.delegate = self;
    self.picyureCheckViewHeight.constant = 0.1;
    
    [self refreshUIData];
}

- (void)refreshUIData{
//    [self.view endEditing:YES];
    self.phoneTextField.text = self.logInModel.phone;
    self.pictureTextField.text = self.logInModel.pictureCheckCode;
    self.messageTextField.text = self.logInModel.messageCheckCode;

    self.picyureCheckViewHeight.constant = self.logInModel.pictureData?58:0.1;
    self.picyureCheckView.hidden = self.logInModel.pictureData?NO:YES;

    
    self.pictureImage.image = [UIImage imageWithData:self.logInModel.pictureData scale:0];
    if (self.logInModel.waitingMessage) {
//        [self.messageBtn setTitle:@"等待接收中" forState:UIControlStateNormal];
        self.messageBtn.userInteractionEnabled = NO;
    }else{
        [self.messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.messageBtn.userInteractionEnabled = YES;
    }
    [self.loginBtn setSelected:self.logInModel.allowLogin];

    if (self.logInModel.allowLogin) {
//        [self.loginBtn setTitleColor:XSColor(255, 255, 255) forState:UIControlStateNormal];
        [self.loginBtn setBackgroundColor:XSColor(235, 48, 48)];
    }else{
//        [self.loginBtn setTitleColor:XSColor(255, 204, 204) forState:UIControlStateNormal];
        [self.loginBtn setBackgroundColor:XSColor(255, 204, 204)];

    }
//    self.loginBtn.userInteractionEnabled = self.logInModel.allowLogin;
    
    self.agreedBtn.selected = self.logInModel.agreement;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.phoneTextField) {
        self.logInModel.phone = textField.text;
    }else if (textField == self.pictureTextField){
        self.logInModel.pictureCheckCode = textField.text;
    }else if (textField == self.messageTextField){
        self.logInModel.messageCheckCode = textField.text;
    }
    [self refreshUIData];
}


- (IBAction)sendMessage:(id)sender {
    [self.view endEditing:YES];
    if (self.logInModel.phone) {
        if (![XSLogInVcModel validateContactNumber:self.logInModel.phone]) {
            [self alertWithMessage:@"请输入正确的号码"];
            return;
        }
        WEAK_SELF;
        [self sendPhoneMessage:^(BOOL successful) {
            STRONG_SELF;
            if (successful) {
                self.logInModel.waitingMessage = YES;
                self.messageBtn.userInteractionEnabled = NO;
                [self.messageBtn setTitle:@"60" forState:UIControlStateNormal];
                 self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateMidLabel)];
                 [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            }
           
        }];
    }else{
        [self alertWithMessage:@"请输入号码"];
    }
}
- (void)sendPhoneMessage:(sendMessageSuccessful)block{
    WEAK_SELF;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.userInfoInterface sendmessageWithPhone:self.logInModel.phone pictureCode:self.logInModel.pictureCheckCode callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        if (error == nil) {
            if (responseModel.code.integerValue == SuccessCode) {
                if (block)block(YES);
                  [self alertWithMessage:@"短信已发送"];
            }else{
                NSData *pictureData = [NSData base64DataFromString:responseModel.data];
                self.logInModel.pictureData = pictureData;
                [self refreshUIData];
                [self alertWithMessage:@"输入图形验证码"];
            }
        }else{
            [self alertWithMessage:error.localizedDescription];
        }
    }];
    
}

- (void)sendPictureMeaasge{
    WEAK_SELF;
    [self.userInfoInterface sendpictureWithPhone:self.logInModel.phone callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        if (error == nil) {
            if (responseModel.code.integerValue == SuccessCode) {
                  NSData *pictureData = [NSData base64DataFromString:responseModel.message];
                if (pictureData) {
                    self.logInModel.pictureData = pictureData;
                    self.logInModel.pictureCheckCode = nil;
                    [self refreshUIData];
                }
   
            }
        }else{
            
        }
    }];
}


- (IBAction)loginClick:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    XSUserLogInModel *model = [XSUserLogInModel userLogInModelForVcModel:self.logInModel];
    WEAK_SELF;
    [self.userInfoInterface loginWithCheckInfo:model callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        if (error == nil) {
            [ProgressHUD showSuccess:responseModel.message];
           if (responseModel.code.integerValue == SuccessCode) {
               [self loginSuccess:responseModel];
           }
        }else{
            [ProgressHUD showError:error.description];
        }
    }];
}
- (void)loginSuccess:(XSNetworkResponse *)responseModel{
//    XSUserServer
    [[NSUserDefaults standardUserDefaults] setObject:responseModel.data forKey:@"userInfo"];
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    XSUserModel *model =  [XSUserModel mj_objectWithKeyValues:userInfo];
    [XSUserServer sharedInstance].userModel = model;

    WEAK_SELF;
    [self dismissViewControllerAnimated:YES completion:^{
        STRONG_SELF;
           if(self.successBlack)self.successBlack();
    }];
}
- (void)loginFailure{
    
}

- (IBAction)dismissViewController:(UIButton *)sender {
    WEAK_SELF;
    [self dismissViewControllerAnimated:YES completion:^{
        STRONG_SELF;
        if(self.cancelBlack)self.cancelBlack();
    }];
}

- (IBAction)agreementClick:(UIButton *)sender {
    [self.view endEditing:YES];
    self.logInModel.agreement =  !self.logInModel.agreement;
    [self refreshUIData];
//    sender.selected = !sender.selected;
//    sender.state = sender.selected?UIControlStateSelected:UIControlStateNormal;
}



- (void)updateMidLabel {
    _midCount += 1;
    if (_midCount % 60 == 0) {
        NSInteger result = MessageWaitTime - _midCount / 60;
         NSString *str = [NSString stringWithFormat:@"%ld",result];
        [self.messageBtn setTitle:str forState:UIControlStateNormal];
        if (result == 0) {
            [self.displayLink invalidate];
            self.midCount = 0;
            self.logInModel.waitingMessage = NO;
            [self refreshUIData];
        }

    }
}

@end
