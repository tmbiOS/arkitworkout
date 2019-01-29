//
//  SharingViewController.m
//  RealFitness
//  Copyright © 2017 Satori Worldwide, Inc. All rights reserved.
//

#import "SharingViewController.h"
#import "User.h"
#import "SatoriConnectionManager.h"
#import "Constants.h"
#import "RealFitness-Swift.h"
#import "UserTableViewCell.h"
#import "UserActivityViewController.h"
#import "UIImageView+Letters.h"

@interface SharingViewController () {
    dispatch_queue_t _messageQueue;
}
@property (nonatomic, strong) NSArray<User *> *users;
@property (nonatomic, strong) SatoriConnectionManager *connMgr;
@property (nonatomic, strong) SubscriptionDataHandler messageHandler;
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSNumber*> *userDict;
@property (nonatomic, strong) NSMutableDictionary<NSString*, UIImage*> *userAvatar;
@end

@implementation SharingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
    self.connMgr = [SatoriConnectionManager sharedManager];
    _messageQueue = dispatch_queue_create("usersubscriptionqueue", DISPATCH_QUEUE_CONCURRENT);
    self.users = [NSMutableArray<User *> new];
    self.userDict = [NSMutableDictionary<NSString*, NSNumber*> new];
    self.userAvatar = [NSMutableDictionary<NSString*, UIImage*> new];
    

   __weak SharingViewController *weakSelf = self;
  [DBManager observeUsersWithCompletion:^(NSArray<User *>* dbUsers) {
    self.users = dbUsers;

    dispatch_async(dispatch_get_main_queue(), ^{
      [weakSelf.tableView reloadData];
    });
  }];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (UserTableViewCell *cell in self.tableView.visibleCells) {
        [cell animateHeart];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    User *user = [self.users objectAtIndex:indexPath.row];
    if ([self.userAvatar objectForKey:user.userid] != nil) {
        [cell.avatarImageView setImage:[self.userAvatar objectForKey:user.userid]];
    }
    else {
       [cell.avatarImageView setImageWithString:user.username];
        [self.userAvatar setObject:cell.avatarImageView.image forKey:user.userid];
    }
    cell.user = user;
    [cell updateCell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = [self.users objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UserActivityViewController *userActivityController = [storyboard instantiateViewControllerWithIdentifier:@"UserActivityViewController"];
    userActivityController.userId = user.userid;
    userActivityController.userName = user.username;
    [self.navigationController pushViewController:userActivityController animated:YES];
}

@end
