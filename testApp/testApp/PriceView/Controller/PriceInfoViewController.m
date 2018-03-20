//
//  PriceInfoViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInfoViewController.h"
#import "PriceInfolabelTableViewCell.h"
#import "PriceCommerceInsTableViewCell.h"
#import "PriceInfoAddTableViewCell.h"
#import "PriceInfoSaveTableViewCell.h"
@interface PriceInfoViewController ()<UITableViewDelegate,UITableViewDataSource,PriceInfoSaveTableViewCellDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation PriceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报价详情";
    [self createUI];
}

#pragma mark - UITableView delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *priceInforLabel = @"infoLabel";
    static NSString *priceCommerceIns = @"commerceIns";
    static NSString *priceCommerceInsFirst = @"commerceInsFirst";
    static NSString * priceInfoAdd = @"infoAdd";
    static NSString *priceInfoSave = @"infoSave";
    if (indexPath.section == 0) {
        PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
        if (!infoLableCell) {
            infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
        }
        infoLableCell.labelTag.text = @"交强险";
        infoLableCell.labelInfo.text = @"投保";
        infoLableCell.labelNumber.text = @"¥ 30000000";
        return infoLableCell;
    } else if (indexPath.section == 1) {
        if (indexPath.row < 5) {
            PriceCommerceInsTableViewCell *commerceInsCell = [tableView dequeueReusableCellWithIdentifier:priceCommerceInsFirst];
            if (!commerceInsCell) {
                commerceInsCell = [[PriceCommerceInsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceCommerceInsFirst];
            }
            if (indexPath.row == 0) {
                commerceInsCell.isFirst = YES;
            } else {
                commerceInsCell.isFirst = NO;
            }
            commerceInsCell.labelTag.text = @"机动车损险";
            commerceInsCell.labelInsure.text = @"不计免赔";
            commerceInsCell.labelAnnotate.text = @"投保";
            commerceInsCell.labelNumber.text = @"3000";
            return commerceInsCell;
        } else if (indexPath.row == 5){
            PriceInfoAddTableViewCell *infoAddCell = [tableView dequeueReusableCellWithIdentifier:priceInfoAdd];
            if (!infoAddCell) {
                infoAddCell = [[PriceInfoAddTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInfoAdd];
            }
            return infoAddCell;
        } else {
            PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
            if (!infoLableCell) {
                infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
            }
            infoLableCell.labelTag.text = @"合计";
            infoLableCell.labelNumber.text = @"¥ 30000000";
            return infoLableCell;
        }
        
    } else if (indexPath.section == 2) {
        PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
        if (!infoLableCell) {
            infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
        }
        infoLableCell.labelTag.text = @"总计";
        infoLableCell.labelNumber.text = @"¥ 30000000";
        return infoLableCell;
    }  else {
        PriceInfoSaveTableViewCell *infoSaveCell = [tableView dequeueReusableCellWithIdentifier:priceInfoSave];
        if (!infoSaveCell) {
            infoSaveCell = [[PriceInfoSaveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInfoSave];
        }
        infoSaveCell.delegate = self;
        return infoSaveCell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70 * ViewRateBaseOnIP6)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(31 * ViewRateBaseOnIP6 , 22 * ViewRateBaseOnIP6, 200, 26 * ViewRateBaseOnIP6)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    [view addSubview:label];
    if (section == 0) {
        label.text = @"交强险";
        return view;
    } else if (section == 1) {
        label.text = @"商业险";
        return view;
    } else {
        return nil;
    }
    
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 7;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 252*ViewRateBaseOnIP6;
    } else {
        return 88 * ViewRateBaseOnIP6;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < 2) {
      return 70 * ViewRateBaseOnIP6;
    } else if (section == 2){
        return 30 * ViewRateBaseOnIP6;
    } else {
        return 0;
    }
    
}

#pragma mark- cell Delegate
- (void)savePriveInfoDelegate{
    NSLog(@"保存");
}

- (void)submitNuclearInsDelegate{
    NSLog(@"提交核保");
    
}

#pragma mark- function

#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.myTableView];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorColor = [UIColor purpleColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}







@end