//
//  MyMedalView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "MyMedalView.h"

@interface MyMedalView ()

@property (nonatomic,strong) NSString *title;

@end

@implementation MyMedalView

- (instancetype)initWithInfo:(NSArray *)info title:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
        [self createUIWithInfo:info title:title];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectToPushDetail)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)createUIWithInfo:(NSArray *)info title:(NSString *)title
{
    self.backgroundColor = [UIColor whiteColor];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 15)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = COLOR_RGB_255(51, 51, 51);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];

    NSArray *kinds = @[@"冠军",@"亚军",@"季军"];
    for (int i=0; i <3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25 + ((SCREEN_WIDTH - 50 -240)/2 + 80) * i, 54, 80, 80)];
        imageView.layer.cornerRadius = 40;
        imageView.layer.masksToBounds = YES;
        imageView.backgroundColor = [UIColor redColor];
        [self addSubview:imageView];

        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 + ((SCREEN_WIDTH - 50 -240)/2 + 80) * i, 54+60, 80, 12)];
        countLabel.text = [NSString stringWithFormat:@"X%@",info[i]] ;
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.textColor = COLOR_RGB_255(51, 51, 51);
        countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:countLabel];

        UILabel *kindLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 + ((SCREEN_WIDTH - 50 -240)/2 + 80) * i, 145, 80, 12)];
        kindLabel.text = kinds[i];
        kindLabel.font = [UIFont systemFontOfSize:12];
        kindLabel.textColor = COLOR_RGB_255(51, 51, 51);
        kindLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:kindLabel];

    }

}

- (void)didSelectToPushDetail
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyMedalViewDidSelectToDetail:)]) {
        [self.delegate MyMedalViewDidSelectToDetail:self.title];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
