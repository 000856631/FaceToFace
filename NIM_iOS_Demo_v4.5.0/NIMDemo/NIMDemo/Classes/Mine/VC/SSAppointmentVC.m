//
//  SSAppointmentVC.m
//  LiveStream_IM_Demo
//
//  Created by Samel on 2017/12/4.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "SSAppointmentVC.h"
#import "PureLayout.h"
#import "ConstantMacro.h"
#import "NTESSettingViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "NTESVideoChatViewController.h"
#import "TZLocationManager.h"
#import <AddressBookUI/AddressBookUI.h>
@interface SSAppointmentVC ()
@property(nonatomic,strong) UILabel *redLabel;
@property(nonatomic,strong) UILabel *smallLabel;
@property(nonatomic,strong) UIImageView *smallImageView;
@property(nonatomic,strong) UIImageView *middleImageView;
@property(nonatomic,strong) UIImageView *userImageView;
@property(nonatomic,strong) UITextField *usernameTextField;
@property(nonatomic,strong) UIButton *connectButton;
@property(nonatomic,strong) UIButton *moreBtn;
@property(nonatomic,assign) BOOL isUpdateConstrains;
@property (nonatomic,strong) AFHTTPRequestOperationManager *flowcManager;


@end

@implementation SSAppointmentVC
-(UIButton*)moreBtn
{
    if (_moreBtn == nil) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn setImage:[UIImage imageNamed:@"icon_sessionlist_more_normal"] forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"icon_sessionlist_more_pressed"] forState:UIControlStateHighlighted];
        [_moreBtn sizeToFit];
    }
    return _moreBtn;
}
-(UILabel*)redLabel
{
    if (_redLabel == nil) {
        _redLabel = [[UILabel alloc]initForAutoLayout ];
        _redLabel.backgroundColor = [UIColor colorWithRed:192.0/255 green:51.0/255 blue:60.0/255 alpha:1];
    }
    return _redLabel;
}
-(UILabel*)smallLabel
{
    if (_smallLabel == nil) {
        _smallLabel = [[UILabel alloc]initForAutoLayout];
        
        _smallLabel.text = @"在线签约";
        
        _smallLabel.textColor = [UIColor whiteColor];
        _smallLabel.font = [UIFont systemFontOfSize:13];
    }
    return _smallLabel;
}
-(UIImageView*)smallImageView
{
    if (_smallImageView == nil) {
        _smallImageView = [[UIImageView alloc]initForAutoLayout];
        _smallImageView.image = [UIImage imageNamed:@"logo1"];
    }
    return _smallImageView;
}
-(UIImageView*)middleImageView
{
    if (_middleImageView == nil) {
        _middleImageView = [[UIImageView alloc]initForAutoLayout];
        _middleImageView.image = [UIImage imageNamed:@"ic_multiport_detail"];
        
    }
    return _middleImageView;
}
-(UIImageView*)userImageView
{
    if (_userImageView == nil) {
        _userImageView = [[UIImageView alloc]initForAutoLayout];
        _userImageView.image = [UIImage imageNamed:@"ic_secretary"];
    }
    return _userImageView;
}
-(UITextField*)usernameTextField
{
    if (_usernameTextField == nil) {
        _usernameTextField = [[UITextField alloc]initForAutoLayout];
        _usernameTextField.placeholder = @"请输入签约客户证件号码";
    }
    return _usernameTextField;
}
-(UIButton*)connectButton
{
    if(_connectButton == nil)
    {
        _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_connectButton setTitle:@"请求通话" forState:UIControlStateNormal];
        [_connectButton setBackgroundColor:[UIColor colorWithRed:221.0f/255 green:88.0f/255 blue:102.0f/255 alpha:1]];
        [_connectButton addTarget:self action:@selector(beginConnect) forControlEvents:UIControlEventTouchUpInside];
        _connectButton.layer.cornerRadius = 5.0f;
    }
    return _connectButton;
}
-(void)beginConnect
{
    [SVProgressHUD show];
    NSMutableDictionary *postParam = [[NSMutableDictionary alloc]init];
    _usernameTextField.text = @"44150908198005231231";
    NSString *idnumber = _usernameTextField.text;
    [[NSUserDefaults standardUserDefaults]setObject:idnumber forKey:@"idnumber"];
    NSString *imuserid = [[NSUserDefaults standardUserDefaults]objectForKey:@"imuserid"];
    NSString *imtk = [[NSUserDefaults standardUserDefaults]objectForKey:@"imtk"];
    NSString *gdsessionid = [[NSUserDefaults standardUserDefaults]objectForKey:@"gdsessionid"];
    [postParam setObject:@"1.0.0" forKey:@"appver"];
    [postParam setObject:@"2" forKey:@"apptype"];
    [postParam setObject:imuserid forKey:@"userid"];
    [postParam setObject:gdsessionid forKey:@"gdsessionid"];
    [postParam setObject:imtk forKey:@"imtk"];
    [postParam setObject:idnumber forKey:@"idnumber"];
    NSLog(@"post param = %@",postParam);
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
        NSString *busino = [dit objectForKey:@"busino"];
        [[NSUserDefaults standardUserDefaults]setObject:busino forKey:@"busino"];
        NSString *receiverid = [dit objectForKey:@"receiverid"];
        NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:receiverid];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:vc animated:NO];
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"postError %@",error);
        [SVProgressHUD dismiss];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    __weak SSAppointmentVC *wself = self;
    [[TZLocationManager manager] startLocationWithGeocoderBlock:^(NSArray *geocoderArray) {
        NSLog(@"geocoderArray = %@",geocoderArray);
        
        CLPlacemark *mark = [geocoderArray lastObject];
        NSString * address  = [wself nameForPlaceMark:mark];
        
        NSString *latitude = [NSString stringWithFormat:@"%lf",mark.location.coordinate.latitude];
         NSString *longitude = [NSString stringWithFormat:@"%lf",mark.location.coordinate.longitude];
        [[NSUserDefaults standardUserDefaults]setObject:address forKey:@"address"];
        [[NSUserDefaults standardUserDefaults]setObject:latitude forKey:@"latitude"];
        [[NSUserDefaults standardUserDefaults]setObject:longitude forKey:@"longitude"];
        NSLog(@"获取的地址:%@ 经度：%@，纬度:%@",address,latitude,longitude);
        
    }];
    [self updateViewConstraints];
    // Do any additional setup after loading the view.
}
- (NSString *)nameForPlaceMark: (CLPlacemark *)mark
{
    NSString *name = ABCreateStringWithAddressDictionary(mark.addressDictionary,YES);
    unichar characters[1] = {0x200e};   //format之后会出现这个诡异的不可见字符，在android端显示会很诡异，需要去掉
    NSString *invalidString = [[NSString alloc]initWithCharacters:characters length:1];
    NSString *formattedName =  [[name stringByReplacingOccurrencesOfString:@"\n" withString:@" "]
                                stringByReplacingOccurrencesOfString:invalidString withString:@""];
    return formattedName;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self.navigationController.navigationBar setHidden:NO];
}
- (void)more:(id)sender
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil
                                                                message:nil
                                                         preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *markAllMessagesReadAction = [UIAlertAction actionWithTitle:@"个人设置"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                                          NTESSettingViewController *vc = [[NTESSettingViewController alloc]init];
                                                                          [self.navigationController pushViewController:vc animated:YES];
                                                                      }];
    [vc addAction:markAllMessagesReadAction];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [vc addAction:cancel];
    
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)updateViewConstraints
{
    [super updateViewConstraints];
    if (!_isUpdateConstrains) {
        [@[self.redLabel,self.smallImageView,self.smallLabel,self.middleImageView,self.userImageView,self.usernameTextField,self.connectButton,self.moreBtn]enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.view addSubview:view];
        }];
        [self.redLabel autoSetDimension:ALDimensionWidth toSize:APP_CONTENT_WIDTH];
        [self.redLabel autoSetDimension:ALDimensionHeight toSize:64];
        [self.redLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.redLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.smallImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.smallImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
        [self.smallImageView autoSetDimension:ALDimensionWidth toSize:20];
        [self.smallImageView autoSetDimension:ALDimensionHeight toSize:20];
        [self.smallLabel autoSetDimension:ALDimensionWidth toSize:150];
        [self.smallLabel autoSetDimension:ALDimensionHeight toSize:20];
        [self.smallLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
        [self.smallLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
        [self.moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
        [self.moreBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.middleImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.middleImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:120];
        [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
        [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:APP_CONTENT_HEIGHT/2 - 60];
        [self.userImageView autoSetDimension:ALDimensionWidth toSize:40];
        [self.userImageView autoSetDimension:ALDimensionHeight toSize:40];
        [self.usernameTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userImageView withOffset:20];
        [self.usernameTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.userImageView];
        [self.usernameTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
        [self.connectButton autoSetDimension:ALDimensionWidth toSize:APP_CONTENT_WIDTH - 20];
        [self.connectButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.connectButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:APP_CONTENT_HEIGHT/2];
        _isUpdateConstrains = YES;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
@end
