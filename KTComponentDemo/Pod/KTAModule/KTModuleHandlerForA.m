//
//  ModuleAHandler.m
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "KTModuleHandlerForA.h"
#import "KTAModuleUserViewController.h"

@implementation KTModuleHandlerForA

/**
 在load中向组件管理器注册
 
 这里其实如果引入KTComponentManager会方便很多
 但是会依赖管理中心、所以算了
 
 */
+ (void)load {

    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"

    Class KTComponentManagerClass = NSClassFromString(@"KTComponentManager");
    SEL sharedInstance = NSSelectorFromString(@"sharedInstance");
    id KTComponentManager = [KTComponentManagerClass performSelector:sharedInstance];
    SEL addHandleTargetWithInfo = NSSelectorFromString(@"addHandleTargetWithInfo:");
    
    NSMutableSet * actionSet = [[NSMutableSet alloc]initWithArray:@[@"getUserViewController"]];
    
    NSDictionary * targetInfo = @{
                                  @"targetName":@"KTModuleHandlerForA",
                                  @"actionSet":actionSet
                                  };
    
    [KTComponentManager performSelector:addHandleTargetWithInfo withObject:targetInfo];

    #pragma clang diagnostic pop

}




/**
 相当于每个模块维护自己的注册表
 */
+ (id)handleAction:(NSString *)action params:(NSDictionary *)params {
    id returnValue = nil;
    if ([action isEqualToString:@"getUserViewController"]) {
        
        returnValue = [[KTAModuleUserViewController alloc]initWithUserName:params[@"userName"] age:[params[@"age"] intValue]];
    }
    return returnValue;
}
@end
