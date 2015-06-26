//
//  PhotoDetailViewController.m
//  PhotoGaler
//
//  Created by Arifin Luthfi P on 26/6/15.
//  Copyright (c) 2015 Himaci Studio. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoEditViewController.h"

@interface PhotoDetailViewController ()

@property (nonatomic, retain) UIImageView* imageView;

@end

@implementation PhotoDetailViewController

@synthesize imageView = _imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Detail";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize viewSize = self.view.bounds.size;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10+64, viewSize.width-20, viewSize.height-20-64-44)];
    _imageView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:_imageView];
    
    UIButton* editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    editButton.frame = CGRectMake(0, viewSize.height-44, viewSize.width, 44);
    [editButton addTarget:self action:@selector(editPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setTitle:@"Add Logo & Text" forState:UIControlStateNormal];
    [self.view addSubview:editButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImage:(UIImage*)image {
    _imageView.image = image;
}

- (void)editPhoto:(id)sender {
    PhotoEditViewController* editVC = [[PhotoEditViewController alloc] init];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:editVC];
    [self presentViewController:navigation animated:YES completion:^{
        [editVC setImage:_imageView.image];
        [editVC setLogoImage:[UIImage imageNamed:@"logo"]];
        [editVC setLabelText:@"Add text here!"];
    }];
}

@end
