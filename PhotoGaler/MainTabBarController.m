//
//  MainTabBarController.m
//  PhotoGaler
//
//  Created by Arifin Luthfi P on 26/6/15.
//  Copyright (c) 2015 Himaci Studio. All rights reserved.
//

#import "MainTabBarController.h"
#import "GalleryViewController.h"
#import "TakePhotoViewController.h"

@interface MainTabBarController ()

@property (nonatomic, retain) GalleryViewController* gallery;
@property (nonatomic, retain) TakePhotoViewController* takePhoto;

@end

@implementation MainTabBarController

@synthesize gallery = _gallery;
@synthesize takePhoto = _takePhoto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UINavigationController* tab1 = [[UINavigationController alloc] init];
        _gallery = [[GalleryViewController alloc] init];
        tab1.viewControllers = @[_gallery];
        
        UINavigationController* tab2 = [[UINavigationController alloc] init];
        _takePhoto = [[TakePhotoViewController alloc] init];
        tab2.viewControllers = @[_takePhoto];
        
        self.viewControllers = @[tab1, tab2];
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self.viewControllers makeObjectsPerformSelector:@selector(view)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
