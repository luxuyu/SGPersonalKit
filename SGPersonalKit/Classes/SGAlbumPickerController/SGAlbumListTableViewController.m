//
//  SGAlbumListTableViewController.m
//  SGImagePickerViewController
//
//  Created by 拾光 on 16/4/27.
//  Copyright © 2016年 拾光. All rights reserved.
//

#import "SGAlbumListTableViewController.h"
#import "SGAlbumPickerController.h"
#import "SGAlbumCollectionViewController.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";


#pragma mark   AlbumList Configuration 相册列表vc的一些设置参数
static const CGFloat albumListCellHeight = 80;


@interface SGAlbumListTableViewController (){
    
    NSArray * albumGroups;
    
    UILabel * remindLabel;
    
}

@end

@implementation SGAlbumListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照片";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView:) name:kSGNotificationReloadTableView object:nil];

    NSString * name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    
    remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, ScreenSize.width - 40, 60)];
    remindLabel.text = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-照片\"选项中，\n允许%@访问你的手机相册。",name];
    remindLabel.numberOfLines = 2;
    remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:remindLabel];

    remindLabel.hidden = YES;
    
    SGAlbumPickerController *picker = (SGAlbumPickerController *)self.navigationController;

    albumGroups = [NSArray arrayWithArray:picker.albumManager.library];
    
    [self.tableView registerClass:[SGAlbumListCell class] forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed)];
    self.navigationItem.rightBarButtonItem = right;
    
}

-(void)reloadTableView:(NSNotification*)noti{
    if ([noti.object boolValue] == YES) {
        self.tableView.scrollEnabled = YES;
        remindLabel.hidden = YES;

        SGAlbumPickerController *picker = (SGAlbumPickerController *)self.navigationController;
        albumGroups = [NSArray arrayWithArray:picker.albumManager.library];
        
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

    }
    else{
        self.tableView.scrollEnabled = NO;
        remindLabel.hidden = NO;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelButtonPressed{
    SGAlbumPickerController *picker = (SGAlbumPickerController *)self.navigationController;
    if (picker.delegate && [picker.delegate respondsToSelector:@selector(albumPickerControllerDidCancel:)]) {
        [picker.delegate albumPickerControllerDidCancel:picker];
    }
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return albumGroups.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return albumListCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SGAlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    SGAlbumGroupModel * group = [albumGroups objectAtIndex:indexPath.row];
    cell.groupModel = group;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SGAlbumGroupModel * group = [albumGroups objectAtIndex:indexPath.row];

    SGAlbumCollectionViewController * collection = [[SGAlbumCollectionViewController alloc] initWithGroupModel:group];
    
    [self.navigationController pushViewController:collection animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@interface SGAlbumListCell ()


@property (nonatomic, weak) UIImageView * coverImageView;
@property (nonatomic, weak) UILabel *  albumTitleLabel;

@end


@implementation SGAlbumListCell

-(UIImageView *)coverImageView{
    if (_coverImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 5 , 5, albumListCellHeight -10, albumListCellHeight - 10)];
        [self addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;

        imageView.clipsToBounds = YES;
        _coverImageView = imageView;
        
        [self refreshLabelFrame];
    }
    

    return _coverImageView;
}

-(UILabel *)albumTitleLabel{
    if (_albumTitleLabel == nil) {
        
        UILabel * label = [[UILabel alloc] init];
        label.textColor= [UIColor blackColor];
        label.numberOfLines = 0;
        [self addSubview:label];
        
        _albumTitleLabel = label;
        [self refreshLabelFrame];

    }
    
    return _albumTitleLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = 1;
    }
    return self;
}

-(void)setGroupModel:(SGAlbumGroupModel *)groupModel{
    _groupModel = groupModel;
    if (groupModel.numberOfObjects >0) {
        self.coverImageView.image =  [groupModel coverImageWithSize:self.coverImageView.frame.size];
    }
    else{
        [_coverImageView removeFromSuperview];
        _coverImageView = nil;
        [self refreshLabelFrame];

    }
    self.albumTitleLabel.text = [NSString stringWithFormat:@"%@\n(%ld)",groupModel.albumName,(long)groupModel.numberOfObjects];
}

-(void)refreshLabelFrame{
    CGFloat X = CGRectGetWidth(_coverImageView.frame) == 0? 5 : CGRectGetMaxX(_coverImageView.frame) + 5;
    _albumTitleLabel.frame = CGRectMake(X, CGRectGetMinY(_coverImageView.frame), 200, albumListCellHeight - 10);
}

@end

