//
//  SGAlbumPickerViewController.m
//  SGAlbumPickerViewController
//
//  Created by 拾光 on 16/4/27.
//  Copyright © 2016年 拾光. All rights reserved.
//

#import "SGAlbumPickerController.h"
#import "SGAlbumManager.h"
#import "SGAlbumListTableViewController.h"


@interface SGAlbumPickerController ()


@end

@implementation SGAlbumPickerController

@dynamic delegate;

-(instancetype)init{
    SGAlbumListTableViewController * albumList = [[SGAlbumListTableViewController alloc] init];
    
    if (self = [super initWithRootViewController:albumList]) {
        _albumManager = [[SGAlbumManager alloc] init];

        self.showEmptyAlbum = NO;
        self.showPhoto = YES;
        self.showVideo = NO;
        self.showNewPhotoInFront = NO;

        _maximumNumberOfSelection = 1;
        _minimumNumberOfSelection = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setShowEmptyAlbum:(BOOL)showEmptyAlbum{
    _showEmptyAlbum = showEmptyAlbum;
    _albumManager.showEmptyAlbum = showEmptyAlbum;
}

-(void)setShowVideo:(BOOL)showVideo{
    _showVideo = showVideo;
    _albumManager.showVideo = showVideo;
}

-(void)setShowPhoto:(BOOL)showPhoto{
    _showPhoto = showPhoto;
    _albumManager.showPhoto = showPhoto;
}


-(void)setShowNewPhotoInFront:(BOOL)showNewPhotoInFront{
    _showNewPhotoInFront = showNewPhotoInFront;
    _albumManager.showNewPhotoInFront = showNewPhotoInFront;

}

-(void)setMaximumNumberOfSelection:(NSInteger)maximumNumberOfSelection{
    if (maximumNumberOfSelection <=0) {//最大数量不能小于等于0
        return;
    }
    _maximumNumberOfSelection = maximumNumberOfSelection;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)havePhotosPermissions{

    return _albumManager.havePhotosPermissions;
}

@end
