//
//  SGAlbumCollectionViewController.h
//  SGImagePickerViewController
//
//  Created by 拾光 on 16/4/27.
//  Copyright © 2016年 拾光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGAlbumManager.h"
@interface SGAlbumCollectionViewController : UICollectionViewController

-(instancetype)initWithGroupModel:(SGAlbumGroupModel *)groupModel;


@end



@interface SGAlbomCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView * selectedImageView;

@property (nonatomic, strong)   SGPhotoModel * photoModel;

@property (nonatomic, assign)   BOOL isSelected;

@end
