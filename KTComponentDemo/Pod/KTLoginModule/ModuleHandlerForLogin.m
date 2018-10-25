//
//  ModuleHandlerForLogin.m
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "ModuleHandlerForLogin.h"
#import "KTLoginManager.h"
#import "KTComponentManager+LoginModule.h"

@implementation ModuleHandlerForLogin

/**
 相当于每个模块维护自己的注册表
 */
+ (id)handleAction:(NSString *)action params:(NSDictionary *)params {
    id returnValue = nil;
    
    //这里代理懒得在往下传了
    id<KTLoginViewControllerDelegate> delegate = params[@"delegate"];
    
    if ([action isEqualToString:@"isLogin"]) {
        
        returnValue = @([[KTLoginManager sharedInstance] isLogin]);
    }
    if ([action isEqualToString:@"loginIfNeed"]) {
        
        returnValue = @([[KTLoginManager sharedInstance] loginIfNeed]);
        if ([delegate respondsToSelector:@selector(didLoginIn)]) {
            [delegate didLoginIn];
        }
        
    }
    
    if ([action isEqualToString:@"loginOut"]) {
        
        [[KTLoginManager sharedInstance] loginOut];
        if ([delegate respondsToSelector:@selector(didLoginOut)]) {
            [delegate didLoginOut];
        }
        
    }
    return returnValue;
}

@end
