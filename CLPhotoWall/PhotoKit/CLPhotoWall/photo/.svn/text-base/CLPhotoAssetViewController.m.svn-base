//
//  CLPhotoAssetViewController.m
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 2016/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import "CLPhotoAssetViewController.h"
#import "CLPhotoAssetCollectionViewCell.h"
#import "CLLoadPhotoAsset.h"
#import "CLLargeImageViewController.h"
#import "CLPhotoAssetConst.h"
#import "CLPhotoAssetInfo.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height
#define space 3

@interface CLPhotoAssetViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,SelectBtnClickDelegate,CLLargeImagePopViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *selectArr;
@property (nonatomic, strong) UIView *ToolBar;
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) UIButton *previewImageBtn;

@property(nonatomic,assign)BOOL  isNoFirstLayout;


@end

@implementation CLPhotoAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addRightBarBtn];
    [self toolBarLayout];
    [self setupFinishBtnLayout];
    [self setupPreviewImageBtnLayout];
    [self setupCollectionViewLayout];
    [self loadData];
}


- (void)setupPreviewImageBtnLayout {
    
    [self.ToolBar addSubview:self.previewImageBtn];
    
    [self.ToolBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_previewImageBtn]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_previewImageBtn)]];
    [self.ToolBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_previewImageBtn(50)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_previewImageBtn)]];
    
}


- (UIButton *)previewImageBtn {
    
    if (!_previewImageBtn) {
        
        _previewImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_previewImageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_previewImageBtn setTitle:@"预览" forState:UIControlStateNormal];
        _previewImageBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _previewImageBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_previewImageBtn addTarget:self action:@selector(previewImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _previewImageBtn;
}



- (void)setupFinishBtnLayout {
    
    [self.ToolBar addSubview:self.finishBtn];
    
    [self.ToolBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_finishBtn]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_finishBtn)]];
    [self.ToolBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_finishBtn(50)]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_finishBtn)]];
    
}


- (UIButton *)finishBtn {
    
    if (!_finishBtn) {
        
        _finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_finishBtn setTitleColor:[UIColor colorWithRed:26.0/255.0 green:178.0/255.0 blue:10.0/255.0 alpha:1] forState:UIControlStateNormal];
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _finishBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _finishBtn;
}


- (void)toolBarLayout {
    
    [self.view addSubview:self.ToolBar];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_ToolBar(45)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ToolBar)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_ToolBar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ToolBar)]];
    
}



- (UIView *)ToolBar {
    
    if (!_ToolBar) {
        
        _ToolBar = [[UIView alloc] init];
        _ToolBar.backgroundColor = [UIColor whiteColor];
        _ToolBar.translatesAutoresizingMaskIntoConstraints = NO;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor grayColor];
        [_ToolBar addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_ToolBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
        
        [_ToolBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
        
        
        
    }
    return _ToolBar;
    
}



- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [[NSMutableArray alloc] init];
        
    }
    
    return _dataSource;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (!self.isNoFirstLayout) {
        self.isNoFirstLayout = YES;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
        
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
    }
}


- (void)loadData {
    
    
    [CLLoadPhotoAsset  photoAssetInfoWithAssetCollection:self.assetCollection photoAssets:^(NSArray<CLPhotoAssetInfo *> *photoAssets) {
        
        [self.dataSource addObjectsFromArray:photoAssets];
        [self.collectionView reloadData];
        
    }];
    
    
    
}

- (NSMutableArray *)selectArr {
    
    if (!_selectArr) {
        
        _selectArr = [NSMutableArray array];
        
    }
    
    return _selectArr;
}



- (void)setupCollectionViewLayout {
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView][_ToolBar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView,_ToolBar)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    
}


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((width - 5*space)/4.0f, (width - 5*space)/4.0f);
        flowLayout.minimumLineSpacing = 2;
        flowLayout.minimumInteritemSpacing = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CLPhotoAssetCollectionViewCell class] forCellWithReuseIdentifier:@"collectionView"];
        [self.view addSubview:_collectionView];
    }
    
    return _collectionView;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLPhotoAssetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    CLPhotoAssetInfo *info = self.dataSource[indexPath.row];
    
    
    [CLLoadPhotoAsset nomalPhotoAssetInfoWithAssetCollection:info.asset resultHandle:^(UIImage *image) {
        
        cell.imageView.image = image;
        info.nomalImage = image;
        
    }];
    
    if (info.selected) {
        [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"sel_picker"] forState:UIControlStateNormal];
    } else {
        
        [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"def_picker"] forState:UIControlStateNormal];
        
    }
    
    cell.delegate = self;
    return cell;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(space, space, space, space);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLLargeImageViewController *largeImage = [[CLLargeImageViewController alloc] init];
    
    largeImage.didSelectCount = self.didSelectImageCount;
    largeImage.indexPath = indexPath;
    [largeImage.dataSource addObjectsFromArray:self.dataSource];
    [largeImage.selectArr addObjectsFromArray:self.selectArr];
    largeImage.delegate = self;
    [self.navigationController pushViewController:largeImage animated:YES];
    
}



#pragma mark - SelectBtnClickDelegate

- (void)selectBtnClick:(UIButton *)sender {
    
    UIView *view = sender.superview;
    while (![view isKindOfClass:[CLPhotoAssetCollectionViewCell class]]) { view = view.superview;}
    
    CLPhotoAssetCollectionViewCell *cell = (id)view;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    CLPhotoAssetInfo *info = self.dataSource[indexPath.row];

    if (info.selected) {
        
        info.selected = NO;
        [self.selectArr removeObject:info];
        
    } else {
        
        
        if (self.selectArr.count + self.didSelectImageCount >=5) {
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"你最多选择%ld张图片", 5-self.didSelectImageCount] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            
            return;
            
            
        }
        
        info.selected = YES;
        [CLLoadPhotoAsset largePhotoAssetInfoWithAssetCollection:info.asset resultHandle:^(UIImage *result) {
            info.largeImage = result;
        } progress:^(double progress) {
            
            
        }];
        [self.selectArr addObject:info];
        
    }
    
    [self.dataSource replaceObjectAtIndex:indexPath.row withObject:info];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
}


- (void)addRightBarBtn {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItem:)];
}

- (void)rightBarButtonItem:(UIBarButtonItem *)item {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)finishBtnClick {
    
    NSDictionary *dict = @{CLPhotoAssetSelectImageNotificationUserInfoKey:self.selectArr};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CLPhotoAssetSelectImageNotificationName object:nil userInfo:dict];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)previewImageBtnClick {
    
    if (self.selectArr.count > 0) {
        CLLargeImageViewController *largeImage = [[CLLargeImageViewController alloc] init];
        largeImage.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [largeImage.dataSource addObjectsFromArray:self.selectArr];
        [largeImage.selectArr addObjectsFromArray:self.selectArr];
        largeImage.delegate = self;
        [self.navigationController pushViewController:largeImage animated:YES];
    }
    
}


#pragma mark - LargeImage

- (void)largeImagePopView:(NSArray *)selectArr dataSource:(NSArray *)dataSource{
    
    [self.selectArr removeAllObjects];
    [self.selectArr addObjectsFromArray:selectArr];
    
    [dataSource enumerateObjectsUsingBlock:^(CLPhotoAssetInfo *assetInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.dataSource enumerateObjectsUsingBlock:^(CLPhotoAssetInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.asset == assetInfo.asset) {
                [self.dataSource replaceObjectAtIndex:idx withObject:assetInfo];
            }
        }];
    }];
    
    [self.collectionView reloadData];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    
}

@end
