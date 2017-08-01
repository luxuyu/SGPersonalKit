//
//  SGAlbumCollectionViewController.m
//  SGAlbumPickerViewController
//
//  Created by 拾光 on 16/4/27.
//  Copyright © 2016年 拾光. All rights reserved.
//

#import "SGAlbumCollectionViewController.h"
#import "SGAlbumPickerController.h"
#pragma mark   Album Configuration 相册照片vc的一些设置参数


static const NSInteger rowCellCount = 4;//每行放几张照片
static const CGFloat sideXSpacing = 5;//距离X轴边缘的距离
static const CGFloat sideYSpacing = 5;//距离Y轴边缘的距离
static const CGFloat cellXSpacing = 5;//照片左右的间距
static const CGFloat cellYSpacing = 5;//照片上下的间距


#define ItemSizeLength  ((ScreenSize.width - sideXSpacing*2 - cellXSpacing*(rowCellCount-1))/rowCellCount)



@interface SGAlbumCollectionViewController ()

@property (nonatomic, strong)   SGAlbumGroupModel * groupModel;

@property (nonatomic, strong)   NSMutableArray * selectedItemArray;


@end

@implementation SGAlbumCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(NSMutableArray *)selectedItemArray{
    if (_selectedItemArray == nil) {
        NSMutableArray * array = [NSMutableArray array];
        _selectedItemArray = array;
    }
    return _selectedItemArray;
}

-(instancetype)initWithGroupModel:(SGAlbumGroupModel *)groupModel{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize =  CGSizeMake(ItemSizeLength, ItemSizeLength);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(sideYSpacing, sideXSpacing, sideYSpacing, sideXSpacing);
    layout.minimumInteritemSpacing = cellYSpacing;
    layout.minimumLineSpacing = cellXSpacing;
    
    self =  [super initWithCollectionViewLayout:layout];
    if (self){
        self.groupModel = groupModel;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = _groupModel.albumName;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    CGFloat Y = 64;
    if (self.navigationController.navigationBar.translucent == NO) {
        Y = 0;
    }
    self.collectionView.frame = CGRectMake(0, Y , ScreenSize.width, ScreenSize.height - Y );
    
    [self setRightBarButtonItem];
    
    [self.collectionView registerClass:[SGAlbomCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    SGAlbumPickerController *picker = (SGAlbumPickerController *)self.navigationController;

    if (picker.showNewPhotoInFront == NO) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_groupModel.numberOfObjects -1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRightBarButtonItem{
    SGAlbumPickerController *picker = (SGAlbumPickerController *)self.navigationController;

    if (picker.maximumNumberOfSelection == 1) {
        return;
    }
    NSString * title = @"取消";
    if (self.selectedItemArray.count >= picker.minimumNumberOfSelection ) {
        title = @"完成";
    }
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];
    self.navigationItem.rightBarButtonItem = right;
}

-(void)doneButtonPressed{
    SGAlbumPickerController *picker = (SGAlbumPickerController *)self.navigationController;

    if (self.selectedItemArray.count >= picker.minimumNumberOfSelection || picker.maximumNumberOfSelection == 1) {
        if (picker.delegate && [picker.delegate respondsToSelector:@selector(albumPickerController:didFinishPickingPhotos:)]) {
            [picker.delegate albumPickerController:picker didFinishPickingPhotos:self.selectedItemArray];
            return;

        }
    }
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return _groupModel.numberOfObjects;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SGAlbomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    SGPhotoModel * photoModel = [self getPhotoModelInGroupAtIndexPath:indexPath];
    SGAlbomCollectionViewCell* photoCell= (SGAlbomCollectionViewCell *)cell;
    photoCell.photoModel = photoModel;
    
    photoCell.isSelected = [self.selectedItemArray containsObject:photoModel];
    
    SGAlbumPickerController *picker = (SGAlbumPickerController *)self.navigationController;
    if (picker.maximumNumberOfSelection == 1) {
        photoCell.selectedImageView.hidden = YES;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SGAlbumPickerController *picker = (SGAlbumPickerController *)self.navigationController;
    SGAlbomCollectionViewCell * cell = (SGAlbomCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (self.selectedItemArray.count >= picker.maximumNumberOfSelection && cell.isSelected == NO) {
        if (picker.delegate && [picker.delegate respondsToSelector:@selector(albumPickerControllerDidMaximum:)]) {
            [picker.delegate albumPickerControllerDidMaximum:picker];
        }
    }
    else{
        
        cell.isSelected = !cell.isSelected;
        
        if (cell.isSelected == YES) {
            [self.selectedItemArray addObject:cell.photoModel];
            
            if (picker.delegate && [picker.delegate respondsToSelector:@selector(albumPickerController:didSelectPhoto:)]) {
                [picker.delegate albumPickerController:picker didSelectPhoto:cell.photoModel];
            }
            if (picker.maximumNumberOfSelection == 1) {
                [self doneButtonPressed];
                return;
            }
            
        }
        else{
            if ([self.selectedItemArray containsObject:cell.photoModel]) {
                [self.selectedItemArray removeObject:cell.photoModel];
            }
            
            if (picker.delegate && [picker.delegate respondsToSelector:@selector(albumPickerController:didDeselectPhoto:)]) {
                [picker.delegate albumPickerController:picker didDeselectPhoto:cell.photoModel];
            }
        }
    }
    
    [self setRightBarButtonItem];

}

-(SGPhotoModel*)getPhotoModelInGroupAtIndexPath:(NSIndexPath *)indexPath{
    
    SGAlbumPickerController *picker = (SGAlbumPickerController *)self.navigationController;

    NSInteger index = picker.showNewPhotoInFront == YES?_groupModel.numberOfObjects - indexPath.row -1:indexPath.row;
    SGPhotoModel * photoModel = [_groupModel.objects objectAtIndex:index];
    return photoModel;

}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end


static const CGFloat selectedImageSizeLength = 20;
static const CGFloat videoImageWidth = 15;
static const CGFloat videoImageHeight = 15;
static const CGFloat videoLabelWidth = 80;
static const CGFloat videoLabelHeight = 15;

@interface SGAlbomCollectionViewCell ()

@property (nonatomic, weak) UIImageView * displayImageView;


@property (nonatomic, weak) UIImageView * videoImageView;

@property (nonatomic, weak) UILabel * videoDurationLabel;

@end

@implementation SGAlbomCollectionViewCell

-(UIImageView *)displayImageView{
    if (_displayImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ItemSizeLength, ItemSizeLength)];
        [self addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        _displayImageView = imageView;
    }
    return _displayImageView;
}

-(UIImageView *)selectedImageView{
    if (_selectedImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ItemSizeLength - selectedImageSizeLength, 0, selectedImageSizeLength, selectedImageSizeLength)];
        [self addSubview:imageView];
        
        _selectedImageView = imageView;
    }
    return _selectedImageView;
}

-(UIImageView *)videoImageView{
    if (_videoImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, ItemSizeLength - videoImageHeight, videoImageWidth, videoImageHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:imageView];
        
        UIImage * video = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SGAlbumPicker.bundle/Images/icon_image_video"]];

        imageView.image = video;
        
        _videoImageView = imageView;
    }
    return _videoImageView;
}

-(UILabel *)videoDurationLabel{
    if (_videoDurationLabel == nil) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(ItemSizeLength - videoLabelWidth - 3, ItemSizeLength - videoLabelHeight, videoLabelWidth, videoLabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        _videoDurationLabel = label;
    }
    return _videoDurationLabel;
}

-(void)setPhotoModel:(SGPhotoModel *)photoModel{
    _photoModel = photoModel;
    
    self.displayImageView.image = [photoModel displayImageWithSize:self.displayImageView.frame.size];
    self.isSelected = NO;
    self.videoImageView.hidden = photoModel.type != SGPhotoObjectTypeVideo;
    self.videoDurationLabel.hidden = photoModel.type != SGPhotoObjectTypeVideo;
    if ( photoModel.type == SGPhotoObjectTypeVideo) {
        NSTimeInterval timeInterval = photoModel.videoDuration;
        
        NSInteger hour      = 0;
        NSInteger min       = 0;
        NSInteger second    = 0;
        min = timeInterval/60;
        second = (NSInteger)timeInterval%60;
        
        if (min > 60) {
            hour = timeInterval/60;
        }
        
        if (hour > 0) {
            self.videoDurationLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)min,(long)second];
        }
        else{
            self.videoDurationLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)min,(long)second];
        }
        NSLog(@"%lf",photoModel.videoDuration);
    }
    
    
}

-(void)setIsSelected:(BOOL)isSelected{

    _isSelected = isSelected;
    
    UIImage * selectedImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SGAlbumPicker.bundle/Images/icon_image_selected"]];
    
    UIImage * unselectedImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SGAlbumPicker.bundle/Images/icon_image_unselected"]];
    self.selectedImageView.image = isSelected == YES?selectedImage:unselectedImage;
}

@end
