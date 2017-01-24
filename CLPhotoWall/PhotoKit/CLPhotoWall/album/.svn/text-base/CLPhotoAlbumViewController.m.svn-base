//
//  CLPhotoAlbumViewController.m
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 2016/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import "CLPhotoAlbumViewController.h"
#import "CLPhotoAssetViewController.h"
#import "CLLoadPhotoAsset.h"
#import "CLAlbumTableViewCell.h"
#import "CLPhotoAssetAlbumInfo.h"


@interface CLPhotoAlbumViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
/** 计时器 */
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CLPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相册";
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self loadData];
    [self addRightBarBtn];
    [self setupTableViewLayout];
    [self authorizationState];
    
    //计时，每隔0.2s判断一次改程序是否被允许访问相册，当允许访问相册的时候，计时器停止工作
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(authorizationStateChange) userInfo:nil repeats:YES];
    
}

- (void)authorizationState {
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法使用相册" message:@"请在iPhone的\"设置-隐私-相册\"中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
            
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
        
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
}



/**
 计时器的方法，来监测改程序是否被授权访问相册，如果授权访问相册了，那么计时器停止工作
 */
- (void)authorizationStateChange
{
    if ([self authorizationStateAuthorized]) {//允许访问相册，计时器停止工作
        [self.timer invalidate];
        self.timer = nil;
        
        if (self.dataSource.count == 0) {
            /**
             计时器停止工作的时候，重新获取以下相册中的数据，
             这段代码，只有当程序第一次访问相册的时候，或者在viewDidLoad中获取相册数据失败的时候，才会执行
             
             */
            [self loadData];
        }
        //刷新数据
        [self.tableView reloadData];
    }
}

/**
 判断是否授权，yes授权成功，no没有授权
 */
- (BOOL)authorizationStateAuthorized {
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) return YES;
    
    return NO;
}





- (void)loadData {
    
    [[CLLoadPhotoAsset defaultManager] loadPhotoAsset:^(NSMutableArray<PHAssetCollection *> *photoList) {
        
        self.dataSource = photoList;
        [self pushAllPhotos];
        
        [self.tableView reloadData];
    } videoAsset:nil failture:^(CLPhotoAssetFailtureReason failtureReason) {
        
    }];
    
}



- (void)setupTableViewLayout {
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 44;
        [_tableView registerClass:[CLAlbumTableViewCell class] forCellReuseIdentifier:@"tableView"];
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


- (void)addRightBarBtn {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItem:)];
}

- (void)rightBarButtonItem:(UIBarButtonItem *)item {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    
    PHAssetCollection *collection = self.dataSource[indexPath.row];
    
    CLPhotoAssetAlbumInfo *info = [CLLoadPhotoAsset  photoAssetAlbumInfoWithAssetCollection:collection];
    
    cell.albumInfo = info;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PHAssetCollection *collection = self.dataSource[indexPath.row];
    
    [self pushDetailVC:collection];
    
    
}

- (void)pushDetailVC:(PHAssetCollection *)assetCollection {
    
    CLPhotoAssetViewController *vc = [[CLPhotoAssetViewController alloc] init];
    vc.assetCollection = assetCollection;
    CLPhotoAssetAlbumInfo *info = [CLLoadPhotoAsset  photoAssetAlbumInfoWithAssetCollection:assetCollection];
    vc.title = info.AlbumName;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)pushAllPhotos {
    
    if (self.dataSource.count > 0) {
        
        PHAssetCollection *collection = self.dataSource[0];
        CLPhotoAssetViewController *vc = [[CLPhotoAssetViewController alloc] init];
        vc.didSelectImageCount = self.didSelectCount;
        vc.assetCollection = collection;
        CLPhotoAssetAlbumInfo *info = [CLLoadPhotoAsset photoAssetAlbumInfoWithAssetCollection:collection];
        vc.title = info.AlbumName;
        [self.navigationController pushViewController:vc animated:NO];
        
    }
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
