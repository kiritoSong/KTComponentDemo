//
//  KTComponentManager+ModuleLogin.m
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "KTComponentManager+LoginModule.h"

@implementation KTComponentManager (LoginModule)

- (BOOL)isLogin {
    
    NSNumber *value = [self openUrl:@"ModuleHandlerForLogin/isLogin" params:nil];
    return [value boolValue];
}


- (BOOL)loginIfNeedWithDelegate:(id<KTLoginViewControllerDelegate>)delegate {
    
    NSNumber *value = [self openUrl:@"ModuleHandlerForLogin/loginIfNeed" params:@{@"delegate":delegate}];
    return [value boolValue];
}

- (void)loginOutWithDelegate:(id<KTLoginViewControllerDelegate>)delegate {
    
    [self openUrl:@"ModuleHandlerForLogin/loginOut" params:@{@"delegate":delegate}];
}


@end
