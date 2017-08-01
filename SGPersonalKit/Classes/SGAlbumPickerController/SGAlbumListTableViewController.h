//
//  SGAlbumListTableViewController.h
//  SGImagePickerViewController
//
//  Created by 拾光 on 16/4/27.
//  Copyright © 2016年 拾光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGAlbumManager.h"
@interface SGAlbumListTableViewController : UITableViewController

@end




@interface SGAlbumListCell : UITableViewCell


@property (nonatomic, strong) SGAlbumGroupModel * groupModel;

@end
