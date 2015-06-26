//
//  PhotoEditViewController.m
//  PhotoGaler
//
//  Created by Arifin Luthfi P on 26/6/15.
//  Copyright (c) 2015 Himaci Studio. All rights reserved.
//

#import "PhotoEditViewController.h"
#import <Social/Social.h>

@interface PhotoEditViewController () <UIActionSheetDelegate, UITextFieldDelegate>

@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, retain) UIImageView* logo;
@property (nonatomic, retain) UITextField* label;

@end

@implementation PhotoEditViewController

@synthesize imageView = _imageView;
@synthesize logo = _logo;
@synthesize label = _label;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Edit";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize viewSize = self.view.bounds.size;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10+64, viewSize.width-20, viewSize.height-20-64-44)];
    _imageView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    _logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 128, 128)];
    [_imageView addSubview:_logo];
    
    _label = [[UITextField alloc] initWithFrame:CGRectMake(0, _imageView.bounds.size.height-40, _imageView.bounds.size.width, 40)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [_label.font fontWithSize:32];
    _label.textColor = [UIColor whiteColor];
    _label.delegate = self;
    [_imageView addSubview:_label];
    
    UIButton* actionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    actionButton.frame = CGRectMake(0, viewSize.height-44, viewSize.width, 44);
    [actionButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton setTitle:@"Action" forState:UIControlStateNormal];
    [self.view addSubview:actionButton];
    
    // For showing keyboard
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImage:(UIImage*)image {
    _imageView.image = image;
}

- (void)setLogoImage:(UIImage*)logoImage {
    _logo.image = logoImage;
}

- (void)setLabelText:(NSString*)labelText {
    _label.text = labelText;
}

- (void)shareAction:(id)sender {
    // Avoid keyboard
    [_label resignFirstResponder];
    
    // Show action sheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save", @"Share to Facebook", @"Share to Twitter", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // Save
        [self saveToDisk:[self captureView]];
    } else if (buttonIndex == 1) {
        // Facebook
        [self shareToFacebook:[self captureView]];
    } else if (buttonIndex == 2) {
        // Twitter
        [self shareToTwitter:[self captureView]];
    }
}

- (UIImage *)captureView {
    UIGraphicsBeginImageContext(_imageView.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_imageView.layer renderInContext:context];
    UIImage* editedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return editedImage;
}

- (void)saveToDisk:(UIImage*)image {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    // Anggap saja sukses, gausah pake listener lah, error, kapan2 aja
    [self saveSucceded:nil];
}

- (void)saveSucceded:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"Photo saved successfuly!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)shareToFacebook:(UIImage*)image {
    NSString* text = [NSString stringWithFormat:@"Wow! PhotoGaler!!!"];
    NSString* url = @"http://primbon.com";
    
    SLComposeViewController* faceBookPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [faceBookPost setInitialText:text];
    [faceBookPost addURL:[NSURL URLWithString:url]];
    [faceBookPost addImage:image];
    
    [self presentViewController:faceBookPost animated:YES completion:nil];
}

- (void)shareToTwitter:(UIImage*)image {
    NSString* text = [NSString stringWithFormat:@"Wow! PhotoGaler!!!"];
    NSString* url = @"http://primbon.com";
    
    SLComposeViewController* twitterPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [twitterPost setInitialText:text];
    [twitterPost addURL:[NSURL URLWithString:url]];
    [twitterPost addImage:image];
    
    [self presentViewController:twitterPost animated:YES completion:nil];
}

#pragma mark Keyboard Notifications

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWillShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.view.frame;
                         frame.origin.y -= kbSize.height;
                         self.view.frame = frame;
                     } 
                     completion:^(BOOL finished){
                         // ...
                     }];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.view.frame;
                         frame.origin.y += kbSize.height;
                         self.view.frame = frame;
                     }
                     completion:^(BOOL finished){
                         // ...
                     }];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
