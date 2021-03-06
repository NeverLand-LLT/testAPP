//
//  XCCustomerFollowViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerFollowViewController.h"
#import "SelectTimeView.h"
#import "PriceUnderwritingImportTableViewCell.h"
#define kimportTableCellID @"importTableCellID"
@interface XCCustomerFollowViewController ()<XCDistributionFooterViewDelegate,PriceUnderwritingImportTableViewCellDelegate>

/** 操作类型记录 */
@property (nonatomic, copy) NSString * operateStr ;
/** 下次跟进时间记录     */
@property (nonatomic, copy) NSString * nextFollowTimeStr ;
/** 跟进内容 非必须选 */
@property (nonatomic, copy) NSString * contentStr ;

@end

@implementation XCCustomerFollowViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    [self.tableView registerClass:[PriceUnderwritingImportTableViewCell class] forCellReuseIdentifier:kimportTableCellID];
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
    self.operateStr = @"";
    self.nextFollowTimeStr = @"";
    self.contentStr = @"";
    
}

#pragma mark - Init Method

- (void)configureData
{
    self.dataArrM = [[NSMutableArray alloc] initWithArray:@[@"操作类型",@"下次跟进时间",@"跟进内容"]];
}
- (void)initUI
{

}
#pragma mark - Action Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView endEditing:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([NSStringFromClass([cell class]) isEqualToString:NSStringFromClass([XCDistributionPicketCell class])]) {
        if ((indexPath.section == 0 && indexPath.row == 0)) {
            NSArray * arr = @[@"人伤案件",@"无责事故案件",@"特殊案件",@"代垫付案件"];
            __weak __typeof(self) weakSelf = self;
            LYZSelectView *alterView = [LYZSelectView alterViewWithArray:arr confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                [(XCDistributionPicketCell *)cell setTitleValue:selectStr];
                weakSelf.operateStr = selectStr;
            }];
            [weakSelf.view addSubview:alterView];
        }
        else if ((indexPath.section == 0 && indexPath.row == 1)) {
            __weak __typeof(self) weakSelf = self;
            SelectTimeView *selectView = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            selectView.block = ^(NSString *string) {
                [(XCDistributionPicketCell *)cell setTitleValue:string];
                weakSelf.nextFollowTimeStr = string;
            };
            [self.view addSubview:selectView];
        }
       
    }
}
#pragma mark - Delegates & Notifications
#pragma mark - XCDistributionFooterViewDelegate
- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    __weak __typeof(self) weakSelf = self;
    NSDictionary *param = @{
                            @"customerId":self.customerID,
                            @"customerName":self.customerName,
                            @"content":self.contentStr,
                            @"operate":self.operateStr,
                            @"nextFollowTime":self.nextFollowTimeStr
                            };
    [RequestAPI postPolicyRevokeBySaleMan:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (response[@"result"]) {
            [strongSelf requestSuccessHandler];
        }else {
            [strongSelf requestFailureHandler];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf requestFailureHandler];
    }];
    
    FinishTipsView *alterView = [[FinishTipsView alloc] initWithTitle:@"提交成功" complete:^{
        
    }];
    [self.view addSubview:alterView];
}

#pragma mark - PriceUnderwritingImportTableViewCellDelegate
- (void)textViewENDWithTextView:(UITextView *)textView
{
    self.contentStr = textView.text;
}
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.dataArrM[indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        PriceUnderwritingImportTableViewCell *cell = (PriceUnderwritingImportTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kimportTableCellID forIndexPath:indexPath];
        cell.textView.text = @"内容描述...";
        cell.delegate = self;
        return cell;
    }else {
        XCDistributionPicketCell *cell = (XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID forIndexPath:indexPath];
        if (indexPath.row == self.dataArrM.count - 1) {
            cell.shouldShowSeparator = NO;
        }
        [cell setTitle:title];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
    [footerView setTitle:@"提交"];
    footerView.delegate = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 233 * ViewRateBaseOnIP6;
    }
    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerViewHeigth;
    footerViewHeigth = (60 + 88 + 60) * ViewRateBaseOnIP6;
    return footerViewHeigth;
}

#pragma mark - Privacy Method
- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}
- (void)requestSuccessHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"提交成功" complete:nil];
    [self.view addSubview:tipsView];
}
#pragma mark - Setter&Getter

////获取操作类型
//NSDictionary *param = @{
//                        @"dictCode":[UserInfoManager shareInstance].ticketID ,
//                        };
//__block NSMutableArray *packArrM = [[NSMutableArray alloc] init];
//
//[RequestAPI getValidPackage:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
//    if (response[@"data"]) {
//        NSArray *dataArr = response[@"data"];
//        for (NSDictionary *dataInfo in dataArr) {
//            XCUserPackageModel *packageModel = [XCUserPackageModel yy_modelWithJSON:dataInfo];
//            if (packageModel) {
//                [packArrM addObject:packageModel];
//            }
//        }
//    }
//
//    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
//} fail:^(id error) {
//}];
@end
