//
//  GridPictureView.m
//  PhotoGaler
//
//  Created by Arifin Luthfi P on 26/6/15.
//  Copyright (c) 2015 Himaci Studio. All rights reserved.
//

#import "GridPictureView.h"

@implementation GridPictureView

@synthesize name = _name;
@synthesize totalVotes = _totalVotes;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.userInteractionEnabled = YES;
        
        UIView* bottomFrame = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height*2/3, frame.size.width, frame.size.height*1/3)];
        bottomFrame.backgroundColor = [UIColor whiteColor];
        bottomFrame.alpha = 0.85;
        [self addSubview:bottomFrame];
        
        // Label1
        _name = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, bottomFrame.bounds.size.width-10, bottomFrame.bounds.size.height*2/3-5)];
        _name.numberOfLines = 2;
        _name.lineBreakMode = NSLineBreakByWordWrapping;
        _name.font = [_name.font fontWithSize:10];
        [bottomFrame addSubview:_name];
        
        // Label2
        _totalVotes = [[UILabel alloc] initWithFrame:CGRectMake(5, bottomFrame.bounds.size.height*2/3, bottomFrame.bounds.size.width-10, bottomFrame.bounds.size.height*1/3-5)];
        _totalVotes.textAlignment = NSTextAlignmentRight;
        _totalVotes.font = [_totalVotes.font fontWithSize:10];
        [bottomFrame addSubview:_totalVotes];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
