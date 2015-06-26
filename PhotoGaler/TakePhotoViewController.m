//
//  TakePhotoViewController.m
//  PhotoGaler
//
//  Created by Arifin Luthfi P on 26/6/15.
//  Copyright (c) 2015 Himaci Studio. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "PhotoDetailViewController.h"

@interface TakePhotoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) UIImageView* imageView;

@end

@implementation TakePhotoViewController

@synthesize imageView = _imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Take Photo";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Take Photo" image:[UIImage imageNamed:@"camera.png"] tag:0];
    
    UILabel* tapToTake = [[UILabel alloc] initWithFrame:self.view.frame];
    tapToTake.text = @"Tap to take a photo!";
    tapToTake.textAlignment = NSTextAlignmentCenter;
    tapToTake.textColor = [UIColor grayColor];
    [self.view addSubview:tapToTake];
    
    CGSize viewSize = self.view.bounds.size;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10+64, viewSize.width-20, viewSize.height-20-64-49)];
    _imageView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:_imageView];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [_imageView addGestureRecognizer:singleTap];
    _imageView.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imageTapped:(UITapGestureRecognizer *)recognizer {
    if (!_imageView.image) {
        // Take picture
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        // Show details
        UIImageView* sender = (UIImageView*)recognizer.view;
        
        PhotoDetailViewController* detailVC = [[PhotoDetailViewController alloc] init];
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:detailVC];
        [self presentViewController:navigation animated:YES completion:^{
            [detailVC setImage:sender.image];
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* image = [info valueForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
