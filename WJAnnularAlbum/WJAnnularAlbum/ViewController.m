//
//  ViewController.m
//  WJAnnularAlbum
//
//  Created by Kevin on 15/3/20.
//  Copyright (c) 2015年 Kevin. All rights reserved.
//

#import "ViewController.h"
#import "WJImageCell.h"
#import "WJStackLayout.h"
#import "WJCircleLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

/** 所有的图片名 */
@property (strong, nonatomic) NSMutableArray *images;
/** 九宫格 */
@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController

static NSString *const ID = @"image";

/**
 *  懒加载
 *
 *  @return 所有图片名
 */
- (NSMutableArray *)images {
    if (_images == nil) {
        self.images = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%i", i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建布局
    WJCircleLayout *layout = [[WJCircleLayout alloc] init];
    // 创建 collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 4, self.view.frame.size.width, self.view.frame.size.height * 0.5) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"WJImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

/**
 *  监听单击手势
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.collectionView.collectionViewLayout isKindOfClass:[WJCircleLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[WJStackLayout alloc] init] animated:YES];
    } else {
        [self.collectionView setCollectionViewLayout:[[WJCircleLayout alloc] init] animated:YES];
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WJImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.image = self.images[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 删除图片名
    [self.images removeObjectAtIndex:indexPath.item];
    [UIView animateWithDuration:0.5 animations:^{
        // 动画删除被点击的item
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    }];
}

@end
