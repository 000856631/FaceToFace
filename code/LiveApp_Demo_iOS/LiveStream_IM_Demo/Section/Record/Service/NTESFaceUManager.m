//
//  NTESFaceUManager.m
//  LiveStream_IM_Demo
//
//  Created by emily on 2017/7/25.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "NTESFaceUManager.h"
#import "FURenderer.h"
#import "authpack.h"
#include <sys/mman.h>
#include <sys/stat.h>

@interface NTESFaceUManager () 
{
    int items[3];
    int frameID;
}
@property(nonatomic, strong) EAGLContext *mcontext;
@property(nonatomic, assign) BOOL isFuInit;
@end

@implementation NTESFaceUManager

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NTESFaceUManager shareInstance] start];
    });
}

+ (instancetype)shareInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NTESFaceUManager alloc] init];
    });
    return instance;
}


- (instancetype)init {
    if (self = [super init]) {
        
        [self setupFaceUnity];
        [self reloadItem:nil];
        [self loadFilter];
        
    }
    return self;
}


#pragma mark - Private

- (void)start {
    NSLog(@"NTESFaceUnity Manager start");
}

- (void)setupFaceUnity {
    int size = 0;
    void *v3 = [self mmap_bundle:@"v3.bundle" psize:&size];
    //CAVEAT:请联系Faceunity获取测试证书并替换到 authpack 文件
    //如果这里需要直接运行，而无需 FaceUnity 效果，可改为如下代码
    [[FURenderer shareRenderer] setupWithData:v3 ardata:NULL authPackage:NULL authSize:sizeof(g_auth_package)];
//    [[FURenderer shareRenderer] setupWithData:v3 ardata:NULL authPackage:&g_auth_package authSize:sizeof(g_auth_package)];
    
    fuSetMaxFaces(3);
}

- (void)reloadItem:(NSString *)selectedItem {
    [self setupContext];
    
    if ([selectedItem isEqual: @"noitem"] || selectedItem == nil)
    {
        if (items[0] != 0) {
            NSLog(@"faceunity: destroy item");
            fuDestroyItem(items[0]);
        }
        items[0] = 0;
        return;
    }
    
    int size = 0;
    // 先创建再释放可以有效缓解切换道具卡顿问题
    void *data = [self mmap_bundle:[selectedItem stringByAppendingString:@".bundle"] psize:&size];
    
    int itemHandle = fuCreateItemFromPackage(data, size);
    
    if (items[0] != 0) {
        NSLog(@"faceunity: destroy item");
        fuDestroyItem(items[0]);
    }
    
    items[0] = itemHandle;
    NSLog(@"faceunity: load item");
}

- (void)setupContext
{
    if(!_mcontext){
        _mcontext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    if(!_mcontext || ![EAGLContext setCurrentContext:_mcontext]){
        NSLog(@"faceunity: failed to create / set a GLES2 context");
    }

}

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    [self setupContext];
    //设置美颜效果（滤镜、磨皮、美白、瘦脸、大眼....）
    fuItemSetParamd(items[1], "cheek_thinning", 1.0); //瘦脸
    fuItemSetParamd(items[1], "eye_enlarging", 0.5); //大眼
    fuItemSetParamd(items[1], "color_level", 0.2); //美白
    fuItemSetParams(items[1], "filter_name", "nature"); //滤镜
    fuItemSetParamd(items[1], "blur_level", 5); //磨皮
    fuItemSetParamd(items[1], "face_shape", 3); //瘦脸类型
    fuItemSetParamd(items[1], "face_shape_level", 0.5); //瘦脸等级
    fuItemSetParamd(items[1], "red_level", 0.5); //红润

    //Faceunity核心接口，将道具及美颜效果作用到图像中，执行完此函数pixelBuffer即包含美颜及贴纸效果
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    [[FURenderer shareRenderer] renderPixelBuffer:pixelBuffer withFrameId:frameID items:items itemCount:3 flipx:YES];
    frameID += 1;

}

- (void)loadFilter
{
    [self setupContext];
    
    int size = 0;
    void *data = [self mmap_bundle:@"face_beautification.bundle" psize:&size];
    items[1] = fuCreateItemFromPackage(data, size);
}

- (void *)mmap_bundle:(NSString *)bundle psize:(int *)psize {
    void* zip = NULL;
    // Load item from predefined item bundle
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundle];
    const char *fn = [str UTF8String];
    int fd = open(fn,O_RDONLY);
    
    int size = 0;
    
    if (fd == -1) {
        NSLog(@"faceunity: failed to open bundle");
        size = 0;
    }else
    {
        size = [self getFileSize:fd];
        zip = mmap(nil, size, PROT_READ, MAP_SHARED, fd, 0);
    }
    *psize = size;
    return zip;
}

- (int)getFileSize:(int)fd
{
    struct stat sb;
    sb.st_size = 0;
    fstat(fd, &sb);
    return (int)sb.st_size;
}



@end
