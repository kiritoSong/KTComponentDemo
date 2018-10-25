//
//  ViewController.m
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "ViewController.h"
#import "KTComponentManager+AModule.h"
#import "KTComponentManager+LoginModule.h"


@interface ViewController ()<KTLoginViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (IBAction)pushToModuleAUserVC:(UIButton *)sender {
    
    if (![[KTComponentManager sharedInstance] loginIfNeedWithDelegate:self]) {
        return;
    }
    
    UIViewController * vc = [[KTComponentManager sharedInstance] ModuleA_getUserViewControllerWithUserName:@"kirito" age:18];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)LoginBtnClick:(UIButton *)sender {
    
    if ([[KTComponentManager sharedInstance] loginIfNeedWithDelegate:self]) {
        [[KTComponentManager sharedInstance] loginOutWithDelegate:self];
    }
    
}

- (IBAction)openWebUrl:(id)sender {
    [[KTComponentManager sharedInstance] openUrl:[NSString stringWithFormat:@"https://www.bilibili.com/video/av25305807"]];
}

//这里应该用通知获取的
- (void)didLoginIn {
    [self.loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
}

- (void)didLoginOut {
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
}

@end
