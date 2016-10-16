//
//  DetailTableViewCell.m
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "DetailTableViewCell.h"

#import <UIImageView+WebCache.h>

#define kWidth  [UIScreen mainScreen].bounds.size.width

@implementation DetailTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

//添加视图
-(void)addViews{
    
    self.picture =[[UIImageView alloc]init];
    self.picture.frame =CGRectZero;
    self.picture.backgroundColor =[UIColor yellowColor];
    [self.contentView addSubview:self.picture];
    
    self.titleLabel  =[[UILabel alloc]init];
    self.titleLabel.frame =CGRectZero;
    [self.contentView addSubview:self.titleLabel];
    
    self.descriptionLabel=[[UILabel alloc]init];
    self.descriptionLabel.frame =CGRectZero;
    self.descriptionLabel.numberOfLines=0;
    [self.contentView addSubview:self.descriptionLabel];
    
}


//使用数据配制自适应cell
-(void)configureCellWithModel:(Categories *)model{

    self.titleLabel.text =model.title;
    self.titleLabel.frame =CGRectMake(kWidth * 0.4+10, 5, kWidth * 0.55-10, 30);
    self.descriptionLabel.text =model.commodityDescription;
    CGSize size =[self.descriptionLabel sizeThatFits:CGSizeMake(kWidth *0.55-10, MAXFLOAT)];
    self.descriptionLabel.frame =CGRectMake(kWidth *0.4+10, 35, kWidth *0.55-10, size.height);
    
    NSString *str =model.s_image_url;
    NSURL *url =[NSURL URLWithString:str];
    self.picture.frame =CGRectMake(kWidth*0.05, 5, kWidth *0.35, size.height+35);
    [self.picture sd_setImageWithURL:url];

    self.frame =CGRectMake(0, 0, kWidth, CGRectGetMaxY(self.picture.frame)+5);
  
}

@end
