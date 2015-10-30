//
//  MySelfViewController.m
//  GourmetShare
//
//  Created by jang on 15/10/24.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MySelfViewController.h"
#import "MySelfView.h"
#import "LTView.h"
#import "UserInfoModle.h"
#import "RegisterDataTool.h"
@interface MySelfViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)MySelfView *mv;
@property (nonatomic,strong)UserInfoModle *userInfo;
@property (nonatomic,assign)BOOL isFullScreen;
@property (nonatomic,strong)MBProgressHUD *hud;
@property (nonatomic,strong)UIImage *tempImage;
@property (nonatomic,assign)BOOL isChangHead;
@end

@implementation MySelfViewController

-(void)loadView
{
    self.mv = [[MySelfView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _mv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *changInfo = [[UIBarButtonItem alloc]initWithTitle:@"修改资料" style:UIBarButtonItemStylePlain target:self action:@selector(changInfo:)];
    self.navigationItem.rightBarButtonItem = changInfo;
    if ([RegisterDataTool shareRegisterData].LoginName != nil) {
        self.userInfo = [[UserInfoModle alloc]init];
        _userInfo = [RegisterDataTool shareRegisterData].userInfo;
        [self p_setupView];
    }else
    {
        _mv.headImage.image = [UIImage imageNamed:@"user.png"];
    }
    _mv.headImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosepictureAction)];
    [_mv.headImage addGestureRecognizer:singleTap1];
    _isChangHead = NO;
    
}
-(void)p_setupView
{
    [_mv.nicknameFiled outputFileText:_userInfo.nickname];
    [_mv.emailFiled outputFileText:_userInfo.email];
    [_mv.genderFiled outputFileText:_userInfo.gender];
    [_mv.hobbyFiled outputFileText:_userInfo.hobby];
    [_mv.likeFoodFiled outputFileText:_userInfo.likeFood];
    [_mv.skillFiled outputFileText:_userInfo.skill];
    
    [_mv.nicknameFiled setTextFieldDelegate:self];
    [_mv.emailFiled setTextFieldDelegate:self];
    [_mv.genderFiled setTextFieldDelegate:self];
    [_mv.hobbyFiled setTextFieldDelegate:self];
    [_mv.likeFoodFiled setTextFieldDelegate:self];
    [_mv.skillFiled setTextFieldDelegate:self];
    _mv.hobbyFiled.inputField.tag = 200;
    _mv.likeFoodFiled.inputField.tag = 201;
    _mv.skillFiled.inputField.tag = 202;
    
    //是否有本地头像
    NSString *uniquePath = [[RegisterDataTool shareRegisterData] imageFilePath:[RegisterDataTool shareRegisterData].LoginName];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        if (_userInfo.headImage != nil) {
            [_mv.headImage sd_setImageWithURL:[NSURL URLWithString:_userInfo.headImage]];
        }
    }else {
        _mv.headImage.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:uniquePath]];
    }
}

//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(void)changInfo:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"修改资料"]) {
        if ([RegisterDataTool shareRegisterData].LoginName != nil) {
            sender.title = @"保存资料";
            _isChangHead = YES;
            _mv.nicknameFiled.inputField.userInteractionEnabled = YES;
            _mv.emailFiled.inputField.userInteractionEnabled = YES;
            _mv.genderFiled.inputField.userInteractionEnabled = YES;
            _mv.hobbyFiled.inputField.userInteractionEnabled = YES;
            _mv.likeFoodFiled.inputField.userInteractionEnabled = YES;
            _mv.skillFiled.inputField.userInteractionEnabled = YES;
        }
        else
        {
            [self p_showAlertView:@"提示" message:@"未登录"];
        }
    }else if([sender.title isEqualToString:@"保存资料"])
    {
        UserInfoModle *tempInfo = [[UserInfoModle alloc]init];
        tempInfo.nickname = [_mv.nicknameFiled inputFieldText];
        tempInfo.email = [_mv.emailFiled inputFieldText];
        tempInfo.gender = [_mv.genderFiled inputFieldText];
        tempInfo.hobby = [_mv.hobbyFiled inputFieldText];
        tempInfo.likeFood = [_mv.likeFoodFiled inputFieldText];
        tempInfo.skill = [_mv.skillFiled inputFieldText];
        
        if ([[RegisterDataTool shareRegisterData]ChangeUserInfoWith:tempInfo]) {
            sender.title = @"修改资料";
            _mv.nicknameFiled.inputField.userInteractionEnabled = NO;
            _mv.emailFiled.inputField.userInteractionEnabled = NO;
            _mv.genderFiled.inputField.userInteractionEnabled = NO;
            _mv.hobbyFiled.inputField.userInteractionEnabled = NO;
            _mv.likeFoodFiled.inputField.userInteractionEnabled = NO;
            _mv.skillFiled.inputField.userInteractionEnabled = NO;
            _userInfo = tempInfo;
        }
    }else if ([sender.title isEqualToString:@"保存头像"])
    {
        UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"确认保存？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [customAlertView show];
    }
}

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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        if ([[RegisterDataTool shareRegisterData]ChangeUserHeadImage:_mv.headImage.image]) {
            [self p_showAlertView:@"提示" message:@"修改成功"];
        }
        else
        {
            [self p_showAlertView:@"提示" message:@"修改失败"];
        }
        if (!_isChangHead) {
            self.navigationItem.rightBarButtonItem.title = @"修改资料";
        }else
        {
            self.navigationItem.rightBarButtonItem.title = @"保存资料";
        }
        
    }else
    {
        [_mv.headImage setImage:_tempImage];
        if (!_isChangHead) {
            self.navigationItem.rightBarButtonItem.title = @"修改资料";
        }else
        {
            self.navigationItem.rightBarButtonItem.title = @"保存资料";
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 选择图片
-(void)choosepictureAction
{
    if ([RegisterDataTool shareRegisterData].LoginName != nil) {
        _tempImage = _mv.headImage.image;
        self.navigationItem.rightBarButtonItem.title = @"保存头像";
        UIActionSheet *sheet;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        }
        
        else {
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        }
        sheet.tag = 255;
        [sheet showInView:self.view];
    }
    else{
        [self p_showAlertView:@"提示" message:@"未登录"];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *fullPath = [cachesPath stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    _isFullScreen = NO;
    
    [self.mv.headImage setImage:savedImage];
    
    self.mv.headImage.tag = 100;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

NSData * UIImageJPEGRepresentation ( UIImage *image, CGFloat compressionQuality);

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *fullPath = [cachesPath stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    _isFullScreen = !_isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.mv.headImage.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.mv.headImage.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.mv.headImage.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (_isFullScreen) {
            // 放大尺寸
            
            self.mv.headImage.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // 缩小尺寸
            self.mv.headImage.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit动画
        [UIView commitAnimations];
        
    }
    
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 200 ||textField.tag == 201 ||textField.tag == 202) {
        //设置视图不能滚动
        [_mv adjustSubviewsWithKeyboardHide];
    }else{
        [_mv changeWithKeyboardHide];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField.tag == 200 ||textField.tag == 201 ||textField.tag == 202) {
        //设置视图可以滚动
        [_mv adjustSubviewsWithKeyboardShow];
    }else
    {
        [_mv changeWithKeyboardHide];
    }
    return YES;
}


@end
