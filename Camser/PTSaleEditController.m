//
//  PTSaleEditController.m
//  Camser
//
//  Created by iPeta on 15/1/19.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTSaleEditController.h"
#import "PTGoodsPhotoItem.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import <QBImagePickerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface PTSaleEditController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,PTGoodsPhotoItemDelegate,QBImagePickerControllerDelegate>
- (IBAction)cameraButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (strong,nonatomic) NSMutableArray *imageArray;
- (IBAction)putoutBTn:(UIButton *)sender;

@end

@implementation PTSaleEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageScrollView.contentSize = CGSizeMake(760, 93);
    
    
    UIView *leftBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_rmb1"]];
    leftView.frame = CGRectMake(10, 12, 20, 20);
    [leftBackView addSubview:leftView];
    self.priceField.leftViewMode = UITextFieldViewModeAlways;
    self.priceField.leftView = leftBackView;
    
    
    UIView *leftBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    UIImageView *leftView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location1"]];
    leftView1.frame = CGRectMake(12, 12, 16, 20);
    [leftBackView1 addSubview:leftView1];
    self.locationField.leftViewMode = UITextFieldViewModeAlways;
    self.locationField.leftView = leftBackView1;
    
    UIView *leftBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    UIImageView *leftView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone1"]];
    leftView2.tintColor = [UIColor grayColor];
    leftView2.frame = CGRectMake(10, 12, 20, 20);
    [leftBackView2 addSubview:leftView2];
    self.phoneNumField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNumField.leftView = leftBackView2;
    
}

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (IBAction)putoutBTn:(UIButton *)sender {
    
    NSLog(@"我点击了发布按钮");
    [self uploadImage];
    [self updateMessage];
}


//添加照片按钮
- (IBAction)cameraButton:(UIButton *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    [actionSheet showInView:self.view];
    
    NSLog(@"我点击了拍照按钮");
}


#pragma mark -- actionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((int)buttonIndex == 0) {
        
        [self takePhoto];
    }else
    {
        [self localPhoto];
    }
    
}

//摄像头代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *theImage = nil;
    // 判断，图片是否允许修改
    if ([picker allowsEditing]){
        //获取用户编辑之后的图像
        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        // 照片的元数据参数
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    [self.imageArray addObject:theImage];
    [self setImage];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

//调用相机
- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
    
}

//打开相册
- (void)localPhoto
{
    QBImagePickerController *imagePicker = [[QBImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsMultipleSelection = YES;
    imagePicker.minimumNumberOfSelection = 0;
    imagePicker.maximumNumberOfSelection = 6;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePicker];
    [self presentViewController:navigationController animated:YES completion:^{
        
    }];
    
    
    
}

//讲照片显示到列表中
- (void)setImage
{
    [self.imageScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat imageViewWH = 93.0f;
    for (int i = 0; i < self.imageArray.count; i ++) {
        PTGoodsPhotoItem *photoItem = [[PTGoodsPhotoItem alloc] initWithFrame:CGRectMake(imageViewWH * i, 10, imageViewWH, imageViewWH)];
        UIImage *image = [self.imageArray objectAtIndex:i];
        photoItem.index = i;
        photoItem.contentImage = image;
        photoItem.delegate = self;
        
        [self.imageScrollView addSubview:photoItem];
    }
}

//goodsPhotoItemView Delegate -- 删除列表中的照片
- (void)goodsPhotoItemView:(PTGoodsPhotoItem *)goodsPhotoItem didSelectDeleteButtonAtIndex:(NSInteger)index
{
    [self.imageArray removeObjectAtIndex:index];
    [self setImage];
}


#pragma mark -- QBImagePickerController Delegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    for (ALAsset *asset in assets) {
        CGImageRef ref = asset.defaultRepresentation.fullScreenImage;
        UIImage *image = [UIImage imageWithCGImage:ref];
        
        [self.imageArray addObject:image];
    }
    [self setImage];
    
    NSLog(@"%@",assets);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//上传照片
- (void)uploadImage
{AVObject *userPhoto = [AVObject objectWithClassName:@"GoodsList"];
    for (int i = 0; i <self.imageArray.count ; i ++) {
        UIImage *image = self.imageArray[i];
        NSData *imageData = UIImagePNGRepresentation(image);
        AVFile *imageFile = [AVFile fileWithName:@"123.png" data:imageData];
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [userPhoto addObject:imageFile forKey:@"imageArray"];
            [userPhoto save];
            NSLog(@"我成功了吗%d",succeeded);
            
            PTGoodsPhotoItem *item = self.imageScrollView.subviews[i];
            item.uploadBtn.hidden = YES;
            
        } progressBlock:^(NSInteger percentDone) {
            NSLog(@"上传进度%ld",(long)percentDone);
        }];
        
    }
    
    
}

- (void)updateMessage
{
    AVUser *current = [AVUser currentUser];
    NSString *author = [current objectForKey:@"nickName"];
    NSString *userid = current.username;
    AVObject *oneGoods = [AVObject objectWithClassName:@"GoodsList"];
    NSString *desc = self.descTextView.text;
    NSString *price = self.priceField.text;
    NSString *phoneNum = self.phoneNumField.text;
    [oneGoods setObject:desc forKey:@"goodsText"];
    [oneGoods setObject:price forKey:@"price"];
    [oneGoods setObject:phoneNum forKey:@"phone"];
    [oneGoods setObject:author forKey:@"author"];
    [oneGoods setObject:userid forKey:@"userid"];
    [oneGoods save];
    
}


- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)path
{
    //根据 NSIndexPath判定行是否可选。
    return nil;
}
@end























