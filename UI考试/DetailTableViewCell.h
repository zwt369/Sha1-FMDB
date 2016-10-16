//
//  DetailTableViewCell.h
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categories.h"



@interface DetailTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *picture;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *descriptionLabel;
@property(nonatomic,strong)Categories *category;

-(void)configureCellWithModel:(Categories *)model;


@end
