//
//  GalleryViewController.m
//  PhotoGaler
//
//  Created by Arifin Luthfi P on 26/6/15.
//  Copyright (c) 2015 Himaci Studio. All rights reserved.
//

#import "GalleryViewController.h"
#import "AFNetworking.h"
#import "MemeData.h"
#import "GridPictureView.h"

@interface GalleryViewController ()

@property (nonatomic, retain) NSDictionary* fetchResult;
@property (nonatomic, retain) NSMutableArray* listOfMeme;
@property (nonatomic, retain) UIScrollView* scrollView;

@end

@implementation GalleryViewController

@synthesize fetchResult = _fetchResult;
@synthesize listOfMeme = _listOfMeme;
@synthesize scrollView = _scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Gallery";
    
    // Create scrollview
    CGSize viewSize = self.view.bounds.size;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height)];
    [self.view addSubview:_scrollView];
    
    // Init and fetch data
    _listOfMeme = [[NSMutableArray alloc] init];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchData {
    NSString *baseURL = @"http://version1.api.memegenerator.net";
    NSString *methodURL = @"Instances_Select_ByPopular";
    NSString *path = [NSString stringWithFormat:@"%@/%@", baseURL, methodURL];
    NSDictionary *parameters = @{};
    
    // Create and send request
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:path
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             // Save to fetch result
             _fetchResult = responseObject;
             // Save to array
             [_listOfMeme removeAllObjects];
             NSArray* result = [_fetchResult objectForKey:@"result"];
             for (int i=0; i<result.count; ++i) {
                 MemeData* newMeme = [[MemeData alloc] initWithData:[result objectAtIndex:i]];
                 [_listOfMeme addObject:newMeme];
             }
             // Load the images
             [self loadImages];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // ...
         }];
}

- (void)loadImages {
    NSInteger memeCount = [_listOfMeme count];
    CGFloat gapSize = 10;
    CGFloat imageSize = (_scrollView.bounds.size.width-(3*gapSize))/2;
    // Create the view
    for (int i=0; i<memeCount; ++i) {
        MemeData* meme = [_listOfMeme objectAtIndex:i];
        // Init image view
        GridPictureView* imageView = [[GridPictureView alloc] initWithFrame:CGRectMake(gapSize+(i%2)*gapSize+(i%2)*imageSize, gapSize+(i/2)*gapSize+(i/2)*imageSize, imageSize, imageSize)];
        [_scrollView addSubview:imageView];
        // Load the image
        [self loadImage:meme.imageUrl toView:imageView];
        imageView.name.text = meme.displayName;
        [imageView.name sizeToFit];
        imageView.totalVotes.text = [NSString stringWithFormat:@"Score : %d", meme.totalVotesScore];
        // Add tap gesture
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        [imageView addGestureRecognizer:singleTap];
        imageView.tag = i;
    }
    // Change scrollView content size
    _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, gapSize+(memeCount/2)*gapSize+(memeCount/2)*imageSize);
    if (memeCount%2) _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, _scrollView.contentSize.height+gapSize+imageSize);
}

- (void)loadImage:(NSURL*)url toView:(UIImageView*)view {
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Change image
        view.image = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // ...
    }];
    [requestOperation start];
}

- (void)imageTapped:(UITapGestureRecognizer *)recognizer {
    // Show details
    NSLog(@"show details %d", recognizer.view.tag);
}

@end
