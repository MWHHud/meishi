//
//  RegisterViewController.m
//  GourmetShare
//
//  Created by jang on 15/10/20.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
#import "LTView.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)RegisterView *rv;
@property (nonatomic,strong) UIImageView *backImage;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation RegisterViewController
// 第三方小菊花
- (void)p_setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}
-(void)loadView
{
    self.rv = [[RegisterView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _rv;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.backImage = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    _rv.backgroundColor = [UIColor whiteColor];
    
    [_rv.registButton addTarget:self action:@selector(registButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_rv.userNameText setTextFieldDelegate:self];
    [_rv.passWordText setTextFieldDelegate:self];
    [_rv.confirmText setTextFieldDelegate:self];
    [_rv.emailText setTextFieldDelegate:self];
    
    _rv.emailText.inputField .tag = 200;
}

-(void)registButtonAction:(UIButton *)sender
{
    [self p_setupProgressHud];
    RegisterModer *registUser = [[RegisterModer alloc]init];
    registUser.userNameText = [_rv.userNameText inputFieldText];
    registUser.passWordText = [_rv.passWordText inputFieldText];
    registUser.confirmText = [_rv.confirmText inputFieldText];
    registUser.emailText = [_rv.emailText inputFieldText];
    registUser.phoneNumberText = [_rv.phoneNumberText inputFieldText];
    
    //注册时，用户名和密码不能为空
    if ([registUser.userNameText isEqualToString:@""] || [registUser.passWordText  isEqualToString:@""]) {
        
        [self p_showAlertView:@"提示" message:@"用户名和密码不能为空"];
        self.hud.hidden = YES;
        return;
    }
    
    //注册时，两次输入的密码必须一致
    if (NO == [registUser.passWordText isEqualToString:registUser.confirmText]) {
        
        [self p_showAlertView:@"提示" message:@"两次输入的密码不一致"];
        self.hud.hidden = YES;
        return;
    }
    if (registUser.passWordText.length < 6) {
        
        [self p_showAlertView:@"提示" message:@"输入必须大于六位"];
        self.hud.hidden = YES;
        return;
    }
    
    //注册时，必须输入邮箱
    if ([registUser.emailText isEqualToString:@""]) {
        
        [self p_showAlertView:@"提示" message:@"为日后找回密码，请输入正确邮箱"];
        self.hud.hidden = YES;
        return;
    }
    
    NSInteger isRegister = [[RegisterDataTool shareRegisterData]podRegisterWithEmail:registUser];
    if (isRegister == 0) {
        [self p_showAlertView:@"提示" message:@"用户名已存在"];
        self.hud.hidden = YES;
        return;
    }
    if (isRegister == 1) {
        [self p_showAlertView:@"提示" message:@"请输入正确邮箱，或者此邮箱已注册，请找回密码"];
        self.hud.hidden = YES;
        return;
    }
    if(isRegister == 2) {
        [self p_showAlertView:@"提示" message:@"注册成功"];
        self.hud.hidden = YES;
    }
    //注册完成后，返回登陆页面
    [self.navigationController popViewControllerAnimated:YES];
    
}

//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 200) {
        //设置视图不能滚动
        [_rv adjustSubviewsWithKeyboardHide];
    }else{
        [_rv changeWithKeyboardHide];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    if (textField.tag == 200) {
        //设置视图可以滚动
        [_rv adjustSubviewsWithKeyboardShow];
    }else
    {
        [_rv changeWithKeyboardHide];
    }
    return YES;
}


@end
