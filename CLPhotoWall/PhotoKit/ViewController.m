//
//  ViewController.m
//  PhotoKit
//
//  Created by hezhijingwei on 2016/12/21.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "ViewController.h"
#import "CLPhotoWall.h"
#import "CollectionViewCell.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createRightItem];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"123"];
    
/*****************************************************************************/
/***************************下面是完成多选照片的方法*******************************/
/*****************************************************************************/

    // 多张选择图片需要调用的方法如下
    // 1、通过通知来获取图片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choosePhoto:) name:CLPhotoAssetSelectImageNotificationName object:nil];
    
}

//2、 实现通知方法  获取图片
- (void)choosePhoto:(NSNotification *)noti {
    
    
    // 内部存放的是CLPhotoAssetInfo的对象
    
    /*
     @property (nonatomic, strong) PHAsset *asset;
     @property (nonatomic, strong) UIImage *nomalImage;
     @property (nonatomic, strong) UIImage *largeImage;
     */
    
    NSArray *images = noti.userInfo[CLPhotoAssetSelectImageNotificationUserInfoKey];
    
    
    [self.dataSource addObjectsFromArray:images];
    
    [self.collectionView reloadData];
    
    NSLog(@"%@",images);
    
    
}

//3、 跳转到图片选择界面
- (void)selectImage {
    
    CLPhotoAlbumViewController *albumVC = [[CLPhotoAlbumViewController alloc] init];
    albumVC.maxCount = 3;
    albumVC.didSelectCount = self.dataSource.count;
    [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:albumVC] animated:YES completion:nil];
    
}


/*****************************************************************************/
/****************************上面是完成多选照片的方法******************************/
/*****************************************************************************/


- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"123" forIndexPath:indexPath];
    
    CLPhotoAssetInfo *info = self.dataSource[indexPath.row];
    
    if (info.largeImage) {
        cell.imageView.image = info.largeImage;
    } else {
        cell.imageView.image = info.nomalImage;
        
    }
    
    
    // 还可以通过这种方法获取图片
    // 其中size可以设置成 PHImageManagerMaximumSize 或者自定义尺寸建议把尺寸减小 防止过大的消耗内存
//    [CLLoadPhotoAsset photoAssetInfoWithAssetCollection:info.asset size:PHImageManagerMaximumSize resultHandle:^(UIImage *image) {
//       
//        cell.imageView.image = image;
//        
//    }];
    

    return cell;
    
}









- (void)createRightItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(selectImage)];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
