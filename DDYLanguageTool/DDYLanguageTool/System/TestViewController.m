#import "TestViewController.h"
#import "DDYLanguageTool.h"
#import "AppDelegate.h"
#import "DDYTabBarController.h"
#import "DDYNavigationController.h"

@interface TestViewController ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TestViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableFooterView:[UIView new]];
    
    if (self.viewTopClass == 1) {
        self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"ddyLanguage", @"tag":@"language"}]];
    } else if (self.viewTopClass == 2) {
        self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"ddyChinese", @"tag":@"zh-Hans"},@{@"title":@"ddyEnglish", @"tag":@"en"}]];
    } else {
        self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"ddyTestSetting", @"tag":@"setting"}]];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ddyCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ddyCellID"];
    }
    cell.textLabel.text = DDYLocalStr(self.dataArray[indexPath.row][@"title"]);
    NSString *tempTag = self.dataArray[indexPath.row][@"tag"];
    cell.accessoryType = [tempTag isEqualToString:[DDYLanguageTool ddy_AppLanguage]] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.viewTopClass == 1) {
        TestViewController *vc = [TestViewController new];
        vc.viewTopClass = 2;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (self.viewTopClass == 2) {
        NSUInteger index = self.tabBarController.selectedIndex;
        __weak __typeof__ (self)weakSelf = self;
        [DDYLanguageTool ddy_SetLanguage:self.dataArray[indexPath.row][@"tag"] complete:^(NSError *error) {
            __strong __typeof__ (weakSelf)strongSelf = weakSelf;
            [strongSelf resetRootViewController:index];
        }];
    } else {
        TestViewController *vc = [TestViewController new];
        vc.viewTopClass = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 重新设置
- (void)resetRootViewController:(NSUInteger)selectedIndex {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DDYTabBarController *tabBarController = [[DDYTabBarController alloc] init];
    appDelegate.window.rootViewController = tabBarController;
    // 第一层 切换到原来选择的
    tabBarController.selectedIndex = selectedIndex;
    
    if ([tabBarController.selectedViewController isKindOfClass:[DDYNavigationController class]]) {
        DDYNavigationController *navigationController = (DDYNavigationController *)tabBarController.selectedViewController;
        
        // 第二层
        TestViewController *vc = [TestViewController new];
        vc.viewTopClass = 1;
        [navigationController pushViewController:vc animated:NO];
        
        // 第三次 重新模态弹出语言选择界面
        TestViewController *languageVC = [TestViewController new];
        languageVC.viewTopClass = 2;
        [navigationController pushViewController:languageVC animated:NO];
    }
    
}

@end
