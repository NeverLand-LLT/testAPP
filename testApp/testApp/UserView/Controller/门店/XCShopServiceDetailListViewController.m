//
//  XCShopServiceDetailListViewController.m
//  testApp
//
//  Created by Melody on 2018/4/13.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopServiceDetailListViewController.h"
#import "XCShopDetailListCell.h"
#import "XCShopServiceModel.h"
#define kDetailListCellID @"DetailListCellID"
#import "XCShopServiceAddServiceViewController.h"
#import "XCShopServiceEditedServiceViewController.h"
@interface XCShopServiceDetailListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XCShopDetailListCellDelegate>

/** <# 注释 #> */
@property (nonatomic, strong) UICollectionView * collectionView ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * addServiceBtn;
@end

@implementation XCShopServiceDetailListViewController

#pragma mark - Init Method
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
        _topBar = [[BaseNavigationBar alloc] init];
        _topBar.delegate  = self;
        _topBar.title = title;
        self.navTitle = title;
        [self.view addSubview:_topBar];
    }
    return self;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureData];
    [self createUI];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [_collectionView setFrame:CGRectMake(0, kHeightForNavigation + kBottomMargan, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation - 98 * ViewRateBaseOnIP6 - kBottomMargan)];
    [_addServiceBtn setFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame) , SCREEN_WIDTH, 98 * ViewRateBaseOnIP6)];
    
}

#pragma mark - Action Method
- (void)clickAddNewService:(UIButton *)button
{
    NSDictionary *param = @{
                            @"storeId":self.storeID,
                            @"category":self.titleTypeStr,
                            @"PageSize":@"-1"
                            };
    __weak __typeof(self) weakSelf = self;
    [RequestAPI queryServiceByStoreId:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (response[@"data"]) {
            if (response[@"data"][@"dataSet"]) {
                NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                NSArray *origionDataArr = response[@"data"][@"dataSet"];
                for (NSDictionary *dataInfo in origionDataArr) {
                    XCShopServiceModel *serviceModel = [XCShopServiceModel yy_modelWithJSON:dataInfo];
                    [dataArrM addObject:serviceModel];
                }
                XCShopServiceAddServiceViewController *addService = [[XCShopServiceAddServiceViewController alloc] initWithTitle:@"添加服务"];
                addService.storeID = strongSelf.storeID;
                addService.dataArrM = dataArrM;
                [strongSelf.navigationController pushViewController:addService animated:YES];
            }
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
        [strongSelf showAlterInfoWithNetWork:errStr];
    }];
    
  
}
#pragma mark - Delegates & Notifications
#pragma  mark - XCShopDetailListCellDelegate
-(void)XCShopDetailListCellClickEditedButton:(UIButton *)button serviceModel:(XCShopServiceModel *)serviceModel
{
    XCShopServiceEditedServiceViewController *editedVC = [[XCShopServiceEditedServiceViewController alloc] initWithTitle:serviceModel.serviceName];
    editedVC.model = serviceModel;
    
    [self.navigationController pushViewController:editedVC animated:YES];
    
}

#pragma mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UICollectionViewDataSource&&UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCShopServiceModel *model = self.dataArr[indexPath.row];
    XCShopDetailListCell *cell = (XCShopDetailListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kDetailListCellID forIndexPath:indexPath];
    cell.delegate = self;
    [cell setupCellWithModel:model];
    
    return cell;
}

#pragma mark - Privacy Method

- (void)configureData
{

}

- (void)createUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.minimumInteritemSpacing = 18 * ViewRateBaseOnIP6;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - (30 + 18 + 30)*ViewRateBaseOnIP6) * 0.5 , (336+158) * ViewRateBaseOnIP6);
    layout.sectionInset =  UIEdgeInsetsMake( 20 * ViewRateBaseOnIP6, 25* ViewRateBaseOnIP6, 0,25 * ViewRateBaseOnIP6);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation - 98 * ViewRateBaseOnIP6) collectionViewLayout:layout];
    _collectionView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [_collectionView  registerClass:[XCShopDetailListCell class] forCellWithReuseIdentifier:kDetailListCellID];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _addServiceBtn = [UIButton buttonWithType:0];
    [_addServiceBtn setTitle:@"添加服务" forState:UIControlStateNormal];
    [_addServiceBtn setTitleColor:COLOR_RGB_255(68, 68, 68) forState:UIControlStateNormal];
    _addServiceBtn.titleLabel.font = [UIFont systemFontOfSize:30 * ViewRateBaseOnIP6];
    [_addServiceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,  24 * ViewRateBaseOnIP6, 0, 0)];
    [_addServiceBtn addTarget:self action:@selector(clickAddNewService:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [UIImage imageNamed:@"添加符号"];
    [_addServiceBtn setBackgroundColor:[UIColor whiteColor]];
    [_addServiceBtn setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:_collectionView];
    [self.view addSubview:_addServiceBtn];
}

- (void)showAlterInfoWithNetWork:(NSString *)titleStr
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:titleStr complete:nil];
    [self.view addSubview:tipsView];
}
#pragma mark - Setter&Getter

@end
