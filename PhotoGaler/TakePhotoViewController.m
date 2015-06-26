//
//  TakePhotoViewController.m
//  PhotoGaler
//
//  Created by Arifin Luthfi P on 26/6/15.
//  Copyright (c) 2015 Himaci Studio. All rights reserved.
//

#import "TakePhotoViewController.h"

@interface TakePhotoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) UIImageView* imageView;

@end

@implementation TakePhotoViewController

@synthesize imageView = _imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Take Photo";
    
    UILabel* tapToTake = [[UILabel alloc] initWithFrame:self.view.frame];
    tapToTake.text = @"Tap disini\nuntuk mengambil gambar!";
    tapToTake.textAlignment = NSTextAlignmentCenter;
    tapToTake.numberOfLines = 0;
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
        NSLog(@"show details");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* image = [info valueForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
