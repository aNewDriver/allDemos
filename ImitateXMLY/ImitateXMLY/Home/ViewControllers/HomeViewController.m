//
//  HomeViewController.m
//  ImitateXMLY
//
//  Created by Ke Wang on 2019/3/5.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "HomeViewController.h"
#import "WKCustomCollectionViewCell.h"



@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource> {
    NSArray *_viewControllerNames;
}

@property (nonatomic, strong) UICollectionView *mainCollectionView;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewControllerNames = @[@"TuiJianViewController", @"VIPViewController", @"XiaoShuoViewController"];
    [self baseConfigure];
    
}

- (void)baseConfigure {
    [self.view addSubview:self.mainCollectionView];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewControllerNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WKCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WKCustomCollectionViewCell" forIndexPath:indexPath];
    
    [cell configureUIWithClassName:_viewControllerNames[indexPath.row]];
    
    return cell;  
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.mainCollectionView) {
        NSUInteger currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
        NSLog(@"scrollView.contentOffset.x = %f", scrollView.contentOffset.x);
        NSLog(@"%lu", (unsigned long)currentIndex);
    }
}




#pragma mark - get

- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.alwaysBounceHorizontal = YES;
        _mainCollectionView.alwaysBounceVertical = NO;
        _mainCollectionView.pagingEnabled = YES;
        _mainCollectionView.backgroundColor = BACKGROUND_COLOR;
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.contentSize = CGSizeMake(SCREEN_WIDTH * _viewControllerNames.count, 0);
        [_mainCollectionView registerClass:[WKCustomCollectionViewCell class] forCellWithReuseIdentifier:@"WKCustomCollectionViewCell"];
    }
    return _mainCollectionView;
}


@end
