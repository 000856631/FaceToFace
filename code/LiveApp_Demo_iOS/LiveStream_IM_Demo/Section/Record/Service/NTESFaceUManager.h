//
//  NTESFaceUManager.h
//  LiveStream_IM_Demo
//
//  Created by emily on 2017/7/25.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTESFaceUManager : NSObject

+ (instancetype)shareInstance;

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer;

- (void)reloadItem:(NSString *)selectedItem;

@end
