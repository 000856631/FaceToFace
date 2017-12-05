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
@interface SSAppointmentVC ()
@property(nonatomic,strong) UILabel *redLabel;
@property(nonatomic,strong) UILabel *smallLabel;
@property(nonatomic,strong) UIImageView *smallImageView;
@property(nonatomic,strong) UIImageView *middleImageView;
@property(nonatomic,strong) UIImageView *userImageView;
@property(nonatomic,strong) UITextField *usernameTextField;
@property(nonatomic,strong) UIButton *connectButton;
@property(nonatomic,assign) BOOL isUpdateConstrains;
@end

@implementation SSAppointmentVC
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
        _smallLabel.textAlignment = NSTextAlignmentCenter;
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
        
    }
    return _middleImageView;
}
-(UIImageView*)userImageView
{
    if (_userImageView == nil) {
        _userImageView = [[UIImageView alloc]initForAutoLayout];
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
        _connectButton.layer.cornerRadius = 5.0f;
    }
    return _connectButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self updateViewConstraints];
    // Do any additional setup after loading the view.
}
-(void)updateViewConstraints
{
    [super updateViewConstraints];
    if (!_isUpdateConstrains) {
        [@[self.redLabel,self.smallImageView,self.smallLabel,self.middleImageView,self.userImageView,self.usernameTextField,self.connectButton]enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.view addSubview:view];
        }];
        [self.redLabel autoSetDimension:ALDimensionWidth toSize:APP_CONTENT_WIDTH];
        [self.redLabel autoSetDimension:ALDimensionHeight toSize:44];
        [self.smallImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.smallImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
        [self.smallImageView autoSetDimension:ALDimensionWidth toSize:20];
        [self.smallImageView autoSetDimension:ALDimensionHeight toSize:20];
        [self.smallLabel autoSetDimension:ALDimensionWidth toSize:50];
        [self.smallLabel autoSetDimension:ALDimensionHeight toSize:20];
        [self.smallLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
        [self.smallLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
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

@end
