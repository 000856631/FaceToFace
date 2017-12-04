//
//  SSLoginVC.m
//  LiveStream_IM_Demo
//
//  Created by Samel on 2017/12/4.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "SSLoginVC.h"
#import "PureLayout.h"
#import "ConstantMacro.h"
@interface SSLoginVC ()
@property(nonatomic,strong) UIImageView *backGroundView;
@end

@implementation SSLoginVC
-(UIImageView*)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
        _backGroundView.image = [UIImage imageNamed:@"login_bg"];
    }
    return _backGroundView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:self.backGroundView];
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
