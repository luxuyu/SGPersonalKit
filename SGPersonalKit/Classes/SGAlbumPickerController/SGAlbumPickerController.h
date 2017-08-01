//
//  SGAlbumPickerViewController.h
//  SGAlbumPickerViewController
//
//  Created by 拾光 on 16/4/27.
//  Copyright © 2016年 拾光. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SGAlbumManager.h"
@class SGAlbumPickerController;
@protocol SGAlbumPickerControllerDelegate <NSObject>

-(void)albumPickerController:(SGAlbumPickerController *)picker didFinishPickingPhotos:(NSArray *)photos;

@optional

-(void)albumPickerControllerDidCancel:(SGAlbumPickerController *)picker;

-(void)albumPickerController:(SGAlbumPickerController *)picker didSelectPhoto:(SGPhotoModel*)photo;

-(void)albumPickerController:(SGAlbumPickerController *)picker didDeselectPhoto:(SGPhotoModel*)photo;

-(void)albumPickerControllerDidMaximum:(SGAlbumPickerController *)picker;

@end


@interface SGAlbumPickerController : UINavigationController

@property (nonatomic, weak) id <UINavigationControllerDelegate, SGAlbumPickerControllerDelegate> delegate;

@property (nonatomic, strong) SGAlbumManager * albumManager;

/**
 *  是否显示空的相册
 */
@property (nonatomic, assign) BOOL showEmptyAlbum;
/**
 *  是否显示视频
 */
@property (nonatomic, assign) BOOL showVideo;

/**
 *  是否显示照片
 */
@property (nonatomic, assign) BOOL showPhoto;

/**
 *  新的照片显示在最前面
 */
@property (nonatomic, assign) BOOL showNewPhotoInFront;

@property (nonatomic, assign) NSInteger maximumNumberOfSelection;
@property (nonatomic, assign) NSInteger minimumNumberOfSelection;

/**
 *  有相册的权限
 */
@property (nonatomic, assign)   BOOL havePhotosPermissions;


@end
