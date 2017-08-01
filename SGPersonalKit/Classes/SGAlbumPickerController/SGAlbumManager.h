//
//  SGAlbumPickerConfiguration.h
//  SGAlbumPickerViewController
//
//  Created by 拾光 on 16/4/27.
//  Copyright © 2016年 拾光. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSInteger,SGPhotoObjectType) {
    SGPhotoObjectTypePhoto  =0,
    SGPhotoObjectTypeVideo ,
    
};

#define kSGNotificationReloadTableView    @"kSGNotificationReloadTableView"

#define ScreenSize  [UIScreen mainScreen].bounds.size


@interface SGAlbumManager : NSObject

/**
 *  相册的列表 数据以 SGAlbumGroupModel 模型存储
 */
@property (nonatomic, strong, readonly) NSMutableArray *  library;

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

/**
 *  有相册的权限
 */
@property (nonatomic, assign)   BOOL havePhotosPermissions;

@end



/**
 *  相册的model
 */
@interface SGAlbumGroupModel : NSObject

/**
 *  相册名称
 */
@property (nonatomic, copy)   NSString * albumName;

/**
 *  相册中所有对象的数量 包括照片和视频
 */
@property (nonatomic, assign) NSInteger numberOfObjects;

/**
 *  相册中照片的数量
 */
@property (nonatomic, assign) NSInteger numberOfPhotos;

/**
 *  相册中所有照片的数量 包括照片和视频
 */
@property (nonatomic, assign) NSInteger numberOfVideos;

/**
 *  相册中所有对象的列表 以SGAlbumModel 模型存储
 */
@property (nonatomic, strong) NSMutableArray * objects;

/**
 *  相册封面
 */
-(UIImage*)coverImageWithSize:(CGSize)size;



@end



@interface SGPhotoModel : NSObject

/**
 *  原数据模型
 */
@property (nonatomic, strong) id  data;
/**
 *  数据类型  照片或者视频
 */
@property (nonatomic, assign) SGPhotoObjectType type;
/**
 *   小图 展示用
 *
 *  @param size 需要的尺寸
 *
 *  @return <#return value description#>
 */
-(UIImage * )displayImageWithSize:(CGSize)size;
/**
 *  根据屏幕比例返回一个等比缩放的图片
 */
@property (nonatomic, strong) UIImage* fullScreenImage;
/**
 *  原图片
 */
@property (nonatomic, strong) UIImage* fullResolutionImage;
/**
 *  视频时长
 */
@property (nonatomic, assign) double videoDuration;
/**
 *  原文件名称
 */
@property (nonatomic, strong) NSString * fileName;
/**
 *  原文件url
 */
@property (nonatomic, strong) NSURL * url;
/**
 *  原文件大小
 */
@property (nonatomic, assign) int64_t fileSize;




@end
