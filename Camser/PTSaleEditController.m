//
//  PTSaleEditController.m
//  Camser
//
//  Created by iPeta on 15/1/19.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTSaleEditController.h"
#import "PTGoodsPhotoItem.h"
#import "PTGoodsList.h"
#import "MBProgressHUD+PT.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import <QBImagePickerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface PTSaleEditController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,PTGoodsPhotoItemDelegate,QBImagePickerControllerDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>
- (IBAction)cameraButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *goodsTypeSg;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (strong,nonatomic) NSMutableArray *imageArray;
@property (strong,nonatomic) NSMutableArray *itemArray;
@property (strong,nonatomic) NSMutableArray *imageFile;
@property (strong,nonatomic) AVObject *oneGoods;
@property (assign,nonatomic) BOOL isUploading;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)putoutBTn:(UIButton *)sender;
- (IBAction)backButton:(UIBarButtonItem *)sender;

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
    
    _oneGoods = [AVObject objectWithClassName:@"GoodsList"];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建CLLocationManager对象
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
    [self.locationManager requestWhenInUseAuthorization];
    //设置代理为自己
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];

    
}

- (NSMutableArray *)imageFile
{
    if (_imageFile == nil) {
        _imageFile = [NSMutableArray array];
    }
    return _imageFile;
}

- (NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (IBAction)putoutBTn:(UIButton *)sender {
    if ([self inputCheck]) {
        NSLog(@"我点击了发布按钮");
        if ([self checkUploadState]) {
            [MBProgressHUD showError:@"图片正在上传请稍后"];
            return;
        }
        [self updateMessage];
    }
    
    
}

- (IBAction)backButton:(UIBarButtonItem *)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定要退出？" message:@"退出后数据将丢失" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    
    [alert show];
    
}



//添加照片按钮
- (IBAction)cameraButton:(UIButton *)sender {
    
    if ([self checkUploadState]) {
        [MBProgressHUD showError:@"图片正在上传"];
        
    }else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        [actionSheet showInView:self.view];
        
        NSLog(@"我点击了拍照按钮");
    }
    
}


#pragma mark -- actionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((int)buttonIndex == 0) {
        [self takePhoto];
    }else if((int)buttonIndex == 1)
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
        [self uploadImage];
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
    [self presentViewController:navigationController animated:YES completion:nil];
}

//讲照片显示到列表中
- (void)setImage
{
    NSInteger subCount = self.imageScrollView.subviews.count;
    [self.imageScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat imageViewWH = 93.0f;
    for (int i = 0; i < self.imageArray.count; i ++) {
        PTGoodsPhotoItem *photoItem = [[PTGoodsPhotoItem alloc] initWithFrame:CGRectMake(imageViewWH * i, 10, imageViewWH, imageViewWH)];
        if (i < subCount) {
            photoItem.isUpload = YES;
        }
        UIImage *image = [self.imageArray objectAtIndex:i];
        photoItem.index = i;
        photoItem.contentImage = image;
        photoItem.delegate = self;
        [self.itemArray addObject:photoItem];
        [self.imageScrollView addSubview:photoItem];
    }
    
    
}

//goodsPhotoItemView Delegate -- 删除列表中的照片
- (void)goodsPhotoItemView:(PTGoodsPhotoItem *)goodsPhotoItem didSelectDeleteButtonAtIndex:(NSInteger)index
{
    if ([self checkUploadState]) {
        [MBProgressHUD showError:@"正在上传，不能删除"];
    }else
    {
        AVFile *delFile = self.imageFile[index];
        [self.oneGoods removeObject:delFile forKey:@"imageArray"];
        [self.imageFile removeObjectAtIndex:index];
        [self.imageArray removeObjectAtIndex:index];
        [self.itemArray removeObjectAtIndex:index];
        [self setImage];
    }
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
    [self dismissViewControllerAnimated:YES completion:^{
       [self uploadImage];
    }];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//上传照片
- (void)uploadImage
{
    for (PTGoodsPhotoItem *photoItem  in self.imageScrollView.subviews) {
        if (!photoItem.isUpload) {
            UIImage *image = photoItem.contentImage;
            NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
            AVFile *imageFile = [AVFile fileWithName:@"123.png" data:imageData];
            [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [_oneGoods addObject:imageFile forKey:@"imageArray"];
                    [_oneGoods save];
                    [self.imageFile addObject:imageFile];
                    NSLog(@"我成功了吗%d",succeeded);
                    photoItem.uploadBtn.hidden = YES;
                    photoItem.isUpload = YES;
                }else
                {
                    NSLog(@"图片上传错误：%@",error);
                }
            } progressBlock:^(NSInteger percentDone) {
                NSLog(@"上传进度%ld",(long)percentDone);
            }];
            
        }
    }
}


- (BOOL)checkUploadState
{
    if (self.imageScrollView.subviews.count == 0) {
        return NO;
    }else
    {
        for (PTGoodsPhotoItem *item in self.imageScrollView.subviews) {
            if (item.uploadBtn) {
                if(item.uploadBtn.hidden == NO){
                    return YES;
                }
            }
            
        }
    }
    return NO;
}

- (void)updateMessage
{
    AVUser *current = [AVUser currentUser];
    AVRelation *reltaion = [current relationforKey:@"myGoods"];
    NSString *desc = self.descTextView.text;
    NSString *price = self.priceField.text;
    NSString *phoneNum = self.phoneNumField.text;
    NSString *locationString = self.locationField.text;
    NSInteger goodsType = self.goodsTypeSg.selectedSegmentIndex;
    [_oneGoods setObject:desc forKey:@"goodsText"];
    [_oneGoods setObject:price forKey:@"price"];
    [_oneGoods setObject:phoneNum forKey:@"phone"];
    [_oneGoods setObject:current forKey:@"author"];
    [_oneGoods setObject:@(goodsType) forKey:@"goodsType"];
    [_oneGoods setObject:locationString forKey:@"locationString"];
    [_oneGoods save];
    [reltaion addObject:_oneGoods];
    [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            self.oneGoods = nil;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)path
{
    //根据 NSIndexPath判定行是否可选。
    return nil;
}


- (BOOL)inputCheck
{
    NSLog(@">>>>>%@",self.descTextView.text);
    if (self.imageArray.count == 0) {
        [MBProgressHUD showError:@"请给你的宝贝拍个照吧"];
        return NO;
    }else if(self.descTextView.text.length == 0){
        [MBProgressHUD showError:@"请给你的宝贝一个描述"];
        return NO;
    }else if(self.priceField.text.length == 0)
    {
        [MBProgressHUD showError:@"你是要卖无价之宝吗？"];
        return NO;
    }else if(self.phoneNumField.text.length == 0)
    {
        [MBProgressHUD showError:@"给个联系方式吧！"];
        return NO;
    }else
    {
        return YES;
        
    }
    
    
}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [_oneGoods delete];
        [_locationManager stopUpdatingLocation];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    NSLog(@"longitude = %f", ((CLLocation *)[locations lastObject]).coordinate.longitude);
    NSLog(@"latitude = %f", ((CLLocation *)[locations lastObject]).coordinate.latitude);
    CLLocation *newLocation = (CLLocation *)[locations lastObject];
    
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             //将获得的所有信息显示到label上

             //获取城市
             NSString  *city = placemark.locality;
                          if (!city) {
                              //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                              city = placemark.administrativeArea;
                          }
             self.locationField.text = city;

             NSLog(@"city = %@", city);
             
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    
    
    
    [manager stopUpdatingHeading];
    [manager stopUpdatingLocation];
}

@end























