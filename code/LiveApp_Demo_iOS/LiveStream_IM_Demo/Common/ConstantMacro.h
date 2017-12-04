//
//  ConstantMacro.h
//  Hotel
//
//  Created by Super_fy on 15/6/15.
//  Copyright (c) 2015年 Super_fy. All rights reserved.
//
//常量宏定义

#ifndef Hotel_ConstantMacro_h
#define Hotel_ConstantMacro_h


//主题类型，可新增
typedef enum{
    FeedBack_Theme_Normal            = 0,    //主题类型－正常
    FeedBack_Theme_Night             = 1,    //主题类型－夜间
    
}FeedBack_Theme_Type;

#define MainScreenBounds [[UIScreen mainScreen] bounds]
#define APP_SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define APP_SCREEN_HEIGHT   (APP_SCREEN_BOUNDS.size.height)
#define APP_SCREEN_WIDTH    (APP_SCREEN_BOUNDS.size.width)
#define APP_STATUS_FRAME    [UIApplication sharedApplication].statusBarFrame
#define APP_CONTENT_WIDTH   (APP_SCREEN_BOUNDS.size.width)
#define APP_CONTENT_HEIGHT  (APP_SCREEN_BOUNDS.size.height-APP_STATUS_FRAME.size.height)
#define BACK_BUTTON_WIDTH 45
#define BACK_BUTTON_HEIGHT 44
#define PLAIN_VIEW_MODE 0
#define BLACK_VIEW_MODE 1

#define iOS_Version                                 [[[UIDevice currentDevice] systemVersion] floatValue]
#define iPhone5  ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size):NO) //判断是不是长屏幕



/***********************Color ****************************/
//下面这部分是来自于工行的视觉用例中的标准色
#define ICBCCOLOR_MainTEXT       [UIColor colorWithRed:0.961 green:0.212 blue:0.271 alpha:1.000]
#define ICBCCOLOR_BLACK		([UIColor colorWithRed:15 / 255.0 green:18 / 255.0 blue:22 / 255.0 alpha:1.0])
#define ICBCCOLOR_RED		([UIColor colorWithRed:0.961 green:0.212 blue:0.271 alpha:1.000])
#define ICBCCOLORGRAY       [UIColor colorWithRed:0.474 green:0.474 blue:0.474 alpha:1.000]
#define ICBCCOLORFRIEND      [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.000]

#define ICBCDSBGCOLOR       [UIColor colorWithRed:0.961 green:0.212 blue:0.271 alpha:1.000]
#define ICBCDSCOLORRED		([UIColor colorWithRed:0.961 green:0.212 blue:0.271 alpha:1.000])

#define ICBCCOLORRED ICBCDSCOLORRED

#define FINANCECOLOR      [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]

#define COLOR_LINE  RGBCOLOR(228, 228, 228)
#define COLOR_BACK  RGBCOLOR(246, 246, 246)
//银行通上面板块的高的
#define bankHeiht  272.5
/*
 * 成功/失败图片，共2个
 */
#define SKIN_SUCCESS			@"success"
#define SKIN_SUCCESS1			@"success1"
#define SKIN_FAILURE			@"failure"
#define SKIN_NOTICE				@"notice"
#define SKIN_EXIT	            @"safeexit"

#define SKIN_BOOK_EDGE			@"bookEdge"
#define SKIN_BUBBLE				@"bubble"
#define SKIN_REMIND             @"remind"

/*
 * 标签图片
 */
#define SKIN_TAB_BAR				@"tabBar"
#define SKIN_TAB_ITEM_SELECTED		@"tabItemSelected"
//#define SKIN_NAVIGATION_BAR		@"navigationBar"
//#define SKIN_NAVIGATION_BAR_IOS6  @"navigationBar-ios6"new-background
#define SKIN_NAVIGATION_BAR			@"new-background"
#define SKIN_NAVIGATION_BAR_IOS6    @"new-background"
#define SKIN_TOOL_BAR				@"toolBar"

typedef enum {
    ICBCSimpleDateTypeSlash, //日期格式为:month/year
    ICBCSimpleDateTypeHyphen //日期格式为:year-month
} ICBCSimpleDateTypes;




#define Adv_MenuId @"adv"
#define Mall_MenuId @"mall"
#define College_MenuId @"college"
#define Activity_MenuId @"activity"


//金融学堂缓存需要
#define ID_FinancialSchoolTemp @"ID_SchoolTemp"
//活动缓存需要
#define ID_FinancialActivityTemp @"ID_ActivityTemp"
//招聘活动缓存需要
#define ID_PracticeTemp   @"ID_PracticeTemp"
//公益活动缓存需要
#define ID_VolunteerTemp   @"ID_VolunteerTemp"
//咨询类缓存表
#define Table_FinancialSaveTemp @"Table_FinancialSaveTemp"


/************************通知**********************/
//登录状态改变
#define Notification_LoginChange @"Notification_LoginChange"
//刷新我的家
#define Notification_RefreshMyFamily @"Notification_RefreshMyFamily"
//在侧边栏发送退出的通知，如果tabindex在我的家需要tabindex ＝ 0 ,
#define Is_SideNotification @"Is_SideNotification"
/************************ends *****************************/



/***********************userDefault key********************/
#define Key_LoginID         @"Key_LoginID"      //登录id
#define Key_LoginIDEncrypt  @"key_LoginIDEncrypt" //登录id加密
#define Key_FirstLaunch     @"Key_FirstLaunch"  //第一启动
#define Key_FirstSelectMenu @"Key_FirstSelectMenu" //第一次选择菜单
#define Key_FirstLogin      @"Key_FirstLogin" //第一次登录
#define Key_FirstGame      @"Key_FirstGame" //第一次夺宝
//#define Key_UserLoginId     @"Key_UserLoginId"
#define Key_remeberUserName @"Key_remeberPassword"
//是否需要验证码
#define Key_CheckVerifyCodeFlag @"Key_CheckVerifyCodeFlag" //1 需要 0 不需要
//是否进入过AA收款
#define Key_already_AA @"Key_already_AA"
//是否进入过公益活动
#define Key_already_Activity @"Key_already_Activity"
#define key_alert_update @"key_alert_update" //提示更新时间key
#define key_refresh_update @"key_refresh_update" //提示刷新元宝时间key
//用户头像地址
#define key_user_photo @"key_user_photo"
//用户头像数据
#define ICBC_USER_PHOTO_USERDEFAULTS @"ICBC_USER_PHOTO_USERDEFAULTS"
//用户昵称
#define key_user_name @"key_user_name"
//用户姓名
#define key_user_custname @"key_user_custname"
//高校编号
#define key_college_cisnum @"key_college_cisnum"
//高校名字
#define key_college_name @"key_college_name"
//高调校徽地址
#define key_college_logo @"key_college_logo"
//地区编号
#define key_zone_cisnum @"key_zone_cisnum"
//金额是否可见
#define key_money_show @"key_money_show"
//消息边界值，用来获取是否有心的消息
#define key_message_last @"key_message_last"
//地区号
#define key_areaCode_str @"key_areaCode_str"
//apns登陆外登记
#define key_apns_regist @"key_apns_regist"
//devicetoken
#define key_device_token @"key_device_token"
//usertoken
#define key_user_token @"key_user_token"
//客户等级
#define key_studentUserLevel @"key_studentUserLevel"
//抽奖的时间戳
//#define Key_TimeStamp       @"Key_TimeStamp"
#define Get_TimeStamp(key)  [NSString stringWithFormat:@"Key_TimeStamp_%@",key];

/***********************后台需要key ****************************/

/***********************表  ****************************/
#define Table_Home @"Table_Home" //首页 表
#define Table_Life @"Table_Life" //生活秀 表
#define Table_Family @"Table_Family" //我的家 表
#define Table_Student_shop @"Table_Student_shop" //学生购 表
#define Table_message_list @"Table_message_list" //消息列表
#define Table_Gold_list @"Table_Gold_list" //元宝列表

/***********************表 －> key ****************************/
#define Key_HomeADVList @"Key_HomeADVList" //首页广告图的列表key
#define Key_LifeADVList @"Key_LifeADVList" //生活秀广告图列表
#define Key_FamilyInfo @"Key_FamilyInfo"  //我的家的信息
#define key_student_shoplist @"key_student_shoplist" //学生购页面列表key
#define key_home_data @"key_home_data"
#define key_home_userid @"key_home_userid" //校园行保存的userid
#define key_message_list @"key_message_list" //消息列表key
#define key_100_list @"key_100_list" //100米的元宝
#define key_400_list @"key_400_list" //400米的元宝
#define key_700_list @"key_700_list" //700米的元宝
#define key_gold_amount @"key_gold_amount" //缓存的元宝
#define key_power @"key_power" //缓存的体力
#define Key_uniqueID @"Key_uniqueID" //缓存的微信唯一ID


//字符串常量
#define Str_Alumni @"alumni"   //同学录menuid
#define Str_ICBC_College @"工银大学"  //这里是判断用户如果属于工行人员，可有些特殊设置
#define Share_Content @"正在使用工银e校园，非常棒的app，推荐给大家使用快去下载看看"
//活动报错语
#define ACTIVITYDATAERROR   @"服务器数据异常，请稍候再试"
//金融学堂报错语
#define FINANCEDATAERROR   @"服务器数据异常，请稍候再试"
//公益活动报错语
#define VOLUENTEERDATAERROR   @"服务器数据异常，请稍候再试"
//招聘活动报错语
#define JOBDATAERROR   @"服务器数据异常，请稍候再试"
#endif
