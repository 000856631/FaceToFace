//
//  SSChangeSecretVC.m
//  NIM
//
//  Created by Samel on 2017/12/13.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "SSChangeSecretVC.h"
#import "PureLayout.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"
#import "AESCrypt.h"
#import "NSString+NTES.h"
#define  BolderSize 0.5
@interface SSChangeSecretVC()
@property(nonatomic,strong) UITextField *oldSecret;
@property(nonatomic,strong) UITextField *Secret;
@property(nonatomic,strong) UITextField *repeatSecret;
@property (nonatomic,strong) AFHTTPRequestOperationManager *flowcManager;
@end
@implementation SSChangeSecretVC
-(UITextField*)oldSecret
{
    if(_oldSecret == nil)
    {
        _oldSecret = [[UITextField alloc]initForAutoLayout];
        _oldSecret.placeholder = @"请输入旧密码";
        _oldSecret.backgroundColor = [UIColor whiteColor];
        _oldSecret.layer.borderWidth = BolderSize;
        _oldSecret.layer.borderColor = [[UIColor blackColor] CGColor];
        _oldSecret.secureTextEntry = YES;
    }
    return _oldSecret;
}
-(UITextField*)Secret
{
    if(_Secret == nil)
    {
        _Secret = [[UITextField alloc]initForAutoLayout];
        _Secret.placeholder = @"请输入新密码";
        _Secret.backgroundColor = [UIColor whiteColor];
        _Secret.layer.borderWidth = BolderSize;
        _Secret.layer.borderColor = [[UIColor blackColor] CGColor];
        _Secret.secureTextEntry = YES;
    }
    return _Secret;
}
-(UITextField*)repeatSecret
{
    if(_repeatSecret == nil)
    {
        _repeatSecret = [[UITextField alloc]initForAutoLayout];
        _repeatSecret.placeholder = @"请再输入一次新密码";
        _repeatSecret.backgroundColor = [UIColor whiteColor];
        _repeatSecret.layer.borderWidth = BolderSize;
        _repeatSecret.layer.borderColor = [[UIColor blackColor] CGColor];
        _repeatSecret.secureTextEntry = YES;
    }
    return _repeatSecret;
}
- (AFHTTPRequestOperationManager *)flowcManager
{
    if (_flowcManager == nil) {
        _flowcManager = [AFHTTPRequestOperationManager manager];
        _flowcManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _flowcManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _flowcManager.requestSerializer.timeoutInterval = 10;
        NSString *userAgentValue = [NSString stringWithFormat:@"%@ %@ fullversion:%@",@"ICBC",@"ICBC",@"ICBC"];
        [_flowcManager.requestSerializer setValue:userAgentValue forHTTPHeaderField:@"User-Agent"];
        
        
    }
    
    return _flowcManager;
}
-(void)setupConstrains
{
    [self.oldSecret autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80];
    [self.oldSecret autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.oldSecret autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.oldSecret autoSetDimension:ALDimensionHeight toSize:60];
    [self.Secret autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.oldSecret ];
    [self.Secret autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.Secret autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.Secret autoSetDimension:ALDimensionHeight toSize:60];
    [self.repeatSecret autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.Secret];
    [self.repeatSecret autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.repeatSecret autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.repeatSecret autoSetDimension:ALDimensionHeight toSize:60];
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录密码修改";
    self.view.backgroundColor = [UIColor whiteColor];
    [@[self.oldSecret,self.Secret,self.repeatSecret]enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addSubview:obj];
    }];
    [self setupConstrains];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"完成" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [loginBtn setTitleColor:[UIColor colorWithRed:191.0/255 green:51.0/255 blue:62.0/255 alpha:1] forState:UIControlStateNormal];
    
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_done_normal"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_done_pressed"] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(changePasswordProcess) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:loginBtn];
}
-(NSString*)encryptSign:(NSString*)text
{
    NSString *secretYinZi = @"gdvrios678912345";
    NSString *rtnText = [AESCrypt encrypt:text password:secretYinZi];
    return rtnText;
}
-(NSString*)deEncryptSign:(NSString*)text
{
    NSString *secretYinZi = @"gdvrios678912345";
    NSString *rtnText = [AESCrypt decrypt:text password:secretYinZi];
    return rtnText;
}
-(void)changePasswordProcess
{
    NSString *oldpass = _oldSecret.text;
    NSString *newpass = _Secret.text;
    NSString *repeatPsw = _repeatSecret.text;
    
    if (![newpass isEqualToString:repeatPsw])
    {
        NSString *toast = [NSString stringWithFormat:@"两次输入的密码不一致"];
        [self.view makeToast:toast duration:2.0 position:CSToastPositionCenter];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary *postParam = [[NSMutableDictionary alloc]init];
    NSString *encrytSecret = [self encryptSign:newpass];
    NSString *encryOldSecret = [oldpass tokenByPassword];
    NSLog(@"加密后的密文:%@",encrytSecret);
    NSLog(@"解密后的明文:%@",[self deEncryptSign:encrytSecret]);
    NSString *imuserid = [[NSUserDefaults standardUserDefaults]objectForKey:@"imuserid"];
    [postParam setObject:@"1.0.0" forKey:@"appver"];
    [postParam setObject:@"2" forKey:@"apptype"];
    [postParam setObject:imuserid forKey:@"userid"];
    [postParam setObject:encryOldSecret forKey:@"oldpass"];
    [postParam setObject:encrytSecret forKey:@"newpass"];
    NSLog(@"post  param = %@",postParam);
    NSString *urlStr = @"http://www.dlczjf.com/gdvrtest/fetchRecevier2.do";
    [self.flowcManager POST:urlStr parameters:postParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData*)responseObject;
        NSDictionary *dit = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"领取返回的dit = %@",dit);
        //        dit = {
        //            gdsessionid = 5eLwLMspMA5sU6UEIGDJarfMyJ8T3Qjh;
        //            imtk = 5b41c20851092d1f40890777e4f5a1b8;
        //            imuserid = 13711111111;
        //            retcode = 00000;
        //            retmsg = "";
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"postError %@",error);
        [SVProgressHUD dismiss];
    }];
}
@end
