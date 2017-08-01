//
//  SGImageManager.m
//  SGImagePickerViewController
//
//  Created by 拾光 on 16/4/27.
//  Copyright © 2016年 拾光. All rights reserved.
//

#import "SGAlbumManager.h"
#import "SGAlbumPickerController.h"

#define Version_Arrowed  __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
//#define Version_Arrowed  1 > 0

@interface SGAlbumManager ()

@property (nonatomic, strong) NSMutableArray * library;

@end


@implementation SGAlbumManager

-(NSMutableArray *)library{
    if (_library == nil) {
        _library = [[NSMutableArray alloc] init];
        [self setupLibrary];
    }
    return _library;
}

-(instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

-(void)setShowEmptyAlbum:(BOOL)showEmptyAlbum{
    if (_showEmptyAlbum == showEmptyAlbum) {
        return;
    }
    _showEmptyAlbum = showEmptyAlbum;
    if (_library != nil) {
        [self setupLibrary];
    }
}

-(void)setShowVideo:(BOOL)showVideo{
    if (_showVideo == showVideo) {
        return;
    }
    _showVideo = showVideo;
    if (_library != nil) {
        [self setupLibrary];
    }
}

-(void)setShowPhoto:(BOOL)showPhoto{
    if (_showPhoto == showPhoto) {
        return;
    }
    _showPhoto = showPhoto;
    if (_library != nil) {
        [self setupLibrary];
    }
}

-(void)setupLibrary{
    [self.library removeAllObjects];
    

#if Version_Arrowed
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authStatus == ALAuthorizationStatusNotDetermined) {
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (*stop) {
                [self libraryFromAssetsLibrary];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:kSGNotificationReloadTableView object:[NSNumber numberWithBool:NO]];
            }
            *stop = TRUE;//不能省略
        } failureBlock:^(NSError *error) {
            NSLog(@"error==%@",error);
        }];
    }
    else if (authStatus == ALAuthorizationStatusAuthorized){
        [self libraryFromAssetsLibrary];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kSGNotificationReloadTableView object:[NSNumber numberWithBool:NO]];
    }
#else
    
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if(authStatus == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self libraryFromPhotoLibrary];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:kSGNotificationReloadTableView object:[NSNumber numberWithBool:NO]];
            }
        }];
    }
    else if (authStatus == PHAuthorizationStatusAuthorized){
        [self libraryFromPhotoLibrary];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kSGNotificationReloadTableView object:[NSNumber numberWithBool:NO]];
    }

#endif
}
#if Version_Arrowed
/**
 *  使用AssetsLibrary 获取相册 iOS8之前使用
 */
- (void)libraryFromAssetsLibrary{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *assets = nil;
    dispatch_once(&pred, ^{
        assets = [[ALAssetsLibrary alloc] init];
    });

    __block NSMutableArray * tmpArray = [NSMutableArray array];
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group)
        {
            [group setAssetsFilter:[ALAssetsFilter allAssets]];
            /**
             *  若group不是空相册  或者 显示空相册
             */
            if (group.numberOfAssets > 0 || self.showEmptyAlbum){
                
                SGAlbumGroupModel * model = [self albumGroupModelWithAssetsGroup:group];
                
                if (model.numberOfObjects > 0 ) {
                    [tmpArray addObject:model];
                }
                else if (self.showEmptyAlbum == YES){
                    [tmpArray addObject:model];
                }
            }
        }
        else{
            NSLog(@"%@",tmpArray) ;
            self.library = [[NSMutableArray alloc] initWithArray:tmpArray];
            [[NSNotificationCenter defaultCenter] postNotificationName:kSGNotificationReloadTableView object:[NSNumber numberWithBool:YES]];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        NSLog(@"---error----%@",error);
    };
    
    [assets enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                          usingBlock:resultsBlock
                        failureBlock:failureBlock];
    
    NSUInteger types = ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces | ALAssetsGroupPhotoStream;
    
    [assets enumerateGroupsWithTypes:types
                          usingBlock:resultsBlock
                        failureBlock:failureBlock];
}
/**
 *  将ALAssetsGroup转换成SGImageGroupModel 目的是为了与<Photos/Photos.h>库统一模型 方便使用
 *
 */
-(SGAlbumGroupModel*)albumGroupModelWithAssetsGroup:(ALAssetsGroup*)group{
    SGAlbumGroupModel * albumGroupModel = [[SGAlbumGroupModel alloc] init];
    
    albumGroupModel.albumName =[group valueForProperty:ALAssetsGroupPropertyName];
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        
        if (asset)
        {

            NSString *type = [asset valueForProperty:ALAssetPropertyType];

            if ([type isEqual:ALAssetTypePhoto]) {
                if (_showPhoto) {
                    
                    albumGroupModel.numberOfObjects ++;
                    albumGroupModel.numberOfPhotos ++;
                    
                    SGPhotoModel * albumModel = [[SGPhotoModel alloc] init];
                    albumModel.data = asset;
                    albumModel.type = SGPhotoObjectTypePhoto;
                    [albumGroupModel.objects addObject:albumModel];
                }
            }
            else if ([type isEqual:ALAssetTypeVideo]){
                if (_showVideo) {
                    
                    albumGroupModel.numberOfObjects ++;
                    albumGroupModel.numberOfVideos ++;
                    
                    SGPhotoModel * albumModel = [[SGPhotoModel alloc] init];
                    albumModel.data = asset;
                    albumModel.type = SGPhotoObjectTypeVideo;
                    [albumGroupModel.objects addObject:albumModel];
                }
            }
        }
    };
    
    [group enumerateAssetsUsingBlock:resultsBlock];
    return albumGroupModel;
}

#else
- (void)libraryFromPhotoLibrary{
    
    /*
     PHAssetCollectionSubtypeAlbumRegular   所有的
     PHAssetCollectionSubtypeAlbumSyncedEvent
     PHAssetCollectionSubtypeAlbumSyncedFaces 
     PHAssetCollectionSubtypeAlbumSyncedAlbum
     PHAssetCollectionSubtypeAlbumImported
     
     PHAssetCollectionSubtypeAlbumMyPhotoStream
     PHAssetCollectionSubtypeAlbumCloudShared
     
     PHAssetCollectionSubtypeSmartAlbumGeneric
     PHAssetCollectionSubtypeSmartAlbumPanoramas        全景
     PHAssetCollectionSubtypeSmartAlbumVideos           视频
     PHAssetCollectionSubtypeSmartAlbumFavorites
     PHAssetCollectionSubtypeSmartAlbumTimelapses       延时摄影
     PHAssetCollectionSubtypeSmartAlbumAllHidden        已隐藏
     PHAssetCollectionSubtypeSmartAlbumRecentlyAdded    最近添加
     PHAssetCollectionSubtypeSmartAlbumBursts           连拍快照
     PHAssetCollectionSubtypeSmartAlbumSlomoVideos      慢动作
     PHAssetCollectionSubtypeSmartAlbumUserLibrary      相机胶卷
     PHAssetCollectionSubtypeSmartAlbumSelfPortraits
     PHAssetCollectionSubtypeSmartAlbumScreenshots
     */
    
    
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    __block NSMutableArray * tmpArray = [NSMutableArray array];
//    // 列出所有智能相册 若只需要相机胶卷 subtype传PHAssetCollectionSubtypeSmartAlbumUserLibrary
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in smartAlbums) {
        // 获取一个相册（PHAssetCollection）
        PHAssetCollectionSubtype subType = collection.assetCollectionSubtype;
        //筛选出智能相册中 需要的相册
        if (subType == PHAssetCollectionSubtypeSmartAlbumUserLibrary
            || subType == PHAssetCollectionSubtypeSmartAlbumRecentlyAdded
            || subType == PHAssetCollectionSubtypeSmartAlbumSelfPortraits
            || subType == PHAssetCollectionSubtypeSmartAlbumScreenshots) {
            
            PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
            if (result.count > 0 || self.showEmptyAlbum == YES ) {
                SGAlbumGroupModel * albumGroupModel = [self albumGroupModelWithFetchResult:result];
                albumGroupModel.albumName =collection.localizedTitle;

                if (albumGroupModel.numberOfObjects > 0 ) {
                    [tmpArray addObject:albumGroupModel];
                }
                else if (self.showEmptyAlbum == YES){
                    [tmpArray addObject:albumGroupModel];
                }
            }
        }
    }

    PHFetchResult *albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in albums) {

        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
        if (result.count > 0 || self.showEmptyAlbum == YES ) {
            SGAlbumGroupModel * albumGroupModel = [self albumGroupModelWithFetchResult:result];
            albumGroupModel.albumName =collection.localizedTitle;

            if (albumGroupModel.numberOfObjects > 0 ) {
                [tmpArray addObject:albumGroupModel];
            }
            else if (self.showEmptyAlbum == YES){
                [tmpArray addObject:albumGroupModel];
            }
        }
    }
    NSLog(@"%@",tmpArray) ;
    self.library = [[NSMutableArray alloc] initWithArray:tmpArray];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSGNotificationReloadTableView object:[NSNumber numberWithBool:YES]];
}

-(SGAlbumGroupModel*)albumGroupModelWithFetchResult:(PHFetchResult*)result{
    SGAlbumGroupModel * albumGroupModel = [[SGAlbumGroupModel alloc] init];
    
    for (PHAsset * asset in result) {
        if (asset) {
            if (asset.mediaType == PHAssetMediaTypeImage) {
                if (_showPhoto) {
                    
                    albumGroupModel.numberOfObjects ++;
                    albumGroupModel.numberOfPhotos ++;
                    
                    SGPhotoModel * albumModel = [[SGPhotoModel alloc] init];
                    albumModel.data = asset;
                    albumModel.type = SGPhotoObjectTypePhoto;
                    [albumGroupModel.objects addObject:albumModel];
                }
            }
            else if (asset.mediaType == PHAssetMediaTypeVideo){
                if (_showVideo) {
                    
                    albumGroupModel.numberOfObjects ++;
                    albumGroupModel.numberOfVideos ++;
                    
                    SGPhotoModel * albumModel = [[SGPhotoModel alloc] init];
                    albumModel.data = asset;
                    albumModel.type = SGPhotoObjectTypeVideo;
                    [albumGroupModel.objects addObject:albumModel];
                }
            }
        }
    }
    return albumGroupModel;
}

#endif


-(BOOL)havePhotosPermissions{
    
#if Version_Arrowed
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authStatus == ALAuthorizationStatusDenied || authStatus == ALAuthorizationStatusRestricted) {
        return NO;
    }
#else
    
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if(authStatus == PHAuthorizationStatusDenied || authStatus == PHAuthorizationStatusRestricted){
        return NO;
    }
    
#endif
    return YES;
}


@end

@implementation SGAlbumGroupModel

-(instancetype)init{
    
    if (self = [super init]) {
        self.objects = [[NSMutableArray alloc] init];

        self.numberOfObjects = 0;
        self.numberOfPhotos = 0;
        self.numberOfVideos = 0;
    }
    return self;
}

-(UIImage*)coverImageWithSize:(CGSize)size{
    SGPhotoModel * photo = [self.objects lastObject];
    return [photo displayImageWithSize:size];
    
}

@end


@interface SGPhotoModel ()


@end


@implementation SGPhotoModel

static PHImageManager * imageManager;

static PHCachingImageManager * cacheImageManager;

- (PHCachingImageManager*)imageManagerSingleton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (cacheImageManager == nil) {
            cacheImageManager = [[PHCachingImageManager alloc] init];
        }
    });
    return cacheImageManager;
}

-(UIImage *)displayImageWithSize:(CGSize)size{
#if Version_Arrowed
    
    ALAsset* asset = (ALAsset*)_data;
    return [UIImage imageWithCGImage:asset.thumbnail];
//    return [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
#else
    PHAsset* asset = (PHAsset*)_data;
    
    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
    phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    CGFloat screenScale = [UIScreen mainScreen].scale;
    // 在 PHImageManager 中，targetSize 等 size 都是使用 px 作为单位，因此需要对targetSize 中对传入的 Size 进行处理，宽高各自乘以 ScreenScale，从而得到正确的图片
    __block UIImage * resultImage = nil;
    [self.imageManagerSingleton requestImageForAsset:asset targetSize:CGSizeMake(size.width * screenScale, size.height * screenScale) contentMode:PHImageContentModeAspectFit options:phImageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        resultImage = result;

    }];

    return resultImage;
#endif
}


-(UIImage*)fullScreenImage{
    
    if (_fullScreenImage) {
        return _fullScreenImage;
    }
#if Version_Arrowed
        ALAsset* asset = (ALAsset*)_data;
        return _fullScreenImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
#else
    PHAsset* asset = (PHAsset*)_data;
    
    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
    phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeNone;
    phImageRequestOptions.synchronous = YES;
    // 在 PHImageManager 中，targetSize 等 size 都是使用 px 作为单位，因此需要对targetSize 中对传入的 Size 进行处理，宽高各自乘以 ScreenScale，从而得到正确的图片
    __block UIImage * resultImage = nil;
    [self.imageManagerSingleton requestImageForAsset:asset targetSize:CGSizeMake(ScreenSize.width*2, ScreenSize.height*2) contentMode:PHImageContentModeAspectFit options:phImageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        resultImage = result;
    }];
    
    return _fullScreenImage = resultImage;
#endif

}

-(UIImage*)fullResolutionImage{
    if (_type == SGPhotoObjectTypeVideo) {
        return nil;
    }

    if (_fullResolutionImage) {
        return _fullResolutionImage;
    }
    
#if Version_Arrowed
    ALAsset* asset = (ALAsset*)_data;
    return _fullResolutionImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
#else
    PHAsset* asset = (PHAsset*)_data;
    
    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
    phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    phImageRequestOptions.synchronous = YES;
    //option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;//控制照片质量
    /**
     resizeMode：对请求的图像怎样缩放。有三种选择：None，默认加载方式；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
     deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。
     这个属性只有在 synchronous 为 true 时有效。
     */
    // 在 PHImageManager 中，targetSize 等 size 都是使用 px 作为单位，因此需要对targetSize 中对传入的 Size 进行处理，宽高各自乘以 ScreenScale，从而得到正确的图片
    CGSize size = PHImageManagerMaximumSize;
    
    __block UIImage * resultImage = nil;
    [self.imageManagerSingleton requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:phImageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        resultImage = result;
    }];

    return _fullResolutionImage = resultImage;
#endif
    
}

-(double)videoDuration{
    if (_type == SGPhotoObjectTypePhoto){
        return 0;
    }
#if Version_Arrowed
    ALAsset* asset = (ALAsset*)_data;
    return [[asset valueForProperty:ALAssetPropertyDuration] doubleValue];
    
#else
    
    PHAsset* asset = (PHAsset*)_data;
    return asset.duration;

#endif
}

-(NSString *)fileName{
#if Version_Arrowed
    ALAsset* asset = (ALAsset*)_data;
    return [[asset defaultRepresentation] filename];
#else
    
    
    return nil;
#endif
}

-(NSURL *)url{
#if Version_Arrowed
    ALAsset* asset = (ALAsset*)_data;
    return [[asset defaultRepresentation] url];
#else
    return nil;
#endif
}

-(int64_t)fileSize{
#if Version_Arrowed
    ALAsset* asset = (ALAsset*)_data;
    return [[asset defaultRepresentation] size];
#else
    return 0;
#endif
}

@end

