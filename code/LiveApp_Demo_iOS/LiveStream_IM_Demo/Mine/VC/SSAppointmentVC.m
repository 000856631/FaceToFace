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
    }
    return _redLabel;
}
-(UILabel*)smallLabel
{
    if (_smallLabel == nil) {
        _smallLabel = [[UILabel alloc]initForAutoLayout];
    }
    return _smallLabel;
}
-(UIImageView*)smallImageView
{
    if (_smallImageView == nil) {
        _smallImageView = [[UIImageView alloc]initForAutoLayout];
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
    }
    return _usernameTextField;
}
-(UIButton*)connectButton
{
    if(_connectButton == nil)
    {
        _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _connectButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
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
