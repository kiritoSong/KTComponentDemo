//
//  KTComponentManager+ModuleA.m
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "KTComponentManager+AModule.h"



@implementation KTComponentManager (AModule)

- (UIViewController *)ModuleA_getUserViewControllerWithUserName:(NSString *)userName age:(int)age {
    
    return [self openUrl:[NSString stringWithFormat:@"https://www.bilibili.com/KTModuleHandlerForA/getUserViewController?userName=%@&age=%d",userName,age]];

    
}

@end
