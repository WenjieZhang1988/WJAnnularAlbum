//
//  WJImageCell.m
//  WJAnnularAlbum
//
//  Created by Kevin on 15/3/21.
//  Copyright (c) 2015年 Kevin. All rights reserved.
//

#import "WJImageCell.h"

@interface WJImageCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WJImageCell

/**
 *  设置xib信息
 */
- (void)awakeFromNib {
    // 边框宽度
    self.imageView.layer.borderWidth = 5;
    // 边框颜色
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    // 圆角角度
    self.imageView.layer.cornerRadius = 5;
    // 切除超出图片部分
    self.imageView.clipsToBounds = YES;
}

- (void)setImage:(NSString *)image {
    _image = [image copy];
    
    self.imageView.image = [UIImage imageNamed:image];
}

@end
