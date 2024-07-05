//
//  PioerDebugHelper.m
//  Sheng
//
//  Created by fanglin on 2019/1/17.
//  Copyright © 2019年 . All rights reserved.
//

#import "PioerDebugHelper.h"
#if __has_include("PioerDebugService-Swift.h")
#    import "PioerDebugService-Swift.h"
#else
#    import <PioerDebugService/PioerDebugService-Swift.h>
#endif
@interface PioerDebugHelper()
//@property(nonatomic,strong) KLLaunchAdModel *adModel;
@end

@implementation PioerDebugHelper
    
+(void)load{
    [self shareHelper];
}
    
+(PioerDebugHelper *)shareHelper{
    static PioerDebugHelper *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[PioerDebugHelper alloc] init];
    });
    return instance;
}
    
- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //初始化开屏广告
//            dispatch_async(dispatch_get_main_queue(), ^{
//                PioerDebugConfigManager *p = [PioerDebugConfigManager init];
//            });
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                PioerDebugConfigManager *p = [[PioerDebugConfigManager alloc] init];
//            });
        }];
    }
    return self;
}

@end
