//
//  XCUserCaseDetailTextCell.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCCarTransactioDetailModel.h"
#import "XCUserCaseDetailModel.h"
#import "XCCheckoutDetailBaseModel.h"
@interface XCUserCaseDetailTextCell : UITableViewCell
/** 标题 */
@property (nonatomic, copy) NSString * titleStr ;
/** 动态内容数组 */
@property (nonatomic, strong) NSArray * labelTitleArrM ;

/** 第二种类型 */
@property (nonatomic, assign) BOOL isMutableTextType ;
/** 长文字设置 */
@property (nonatomic, copy) NSString * longString;

/**
 年审初配置
 */
- (void)setupCellWithCarTransactionDetailModel:(XCCarTransactioDetailModel *)model;
/**
 违章初配置
 */
- (void)setupCellWithViolationCarTranDetailModel:(XCCarTransactioDetailModel *)model;
/**
 维修初配置
 */
- (void)setupCellWithRepairCarTranDetailModel:(XCCarTransactioDetailModel *)model;

- (void)setupCellWithCaseDetailModel:(XCUserCaseDetailModel *)model clipName:(BOOL)clip;

/**
 配送详情 使用
 */
- (void)setupDistributionCellWithDetailBaseModel:(XCCheckoutDetailBaseModel *)model;
/**
 财务审核中 使用
 */
- (void)setupFinaAudiaCellWithDetailBaseModel:(XCCheckoutDetailBaseModel *)model;

/**
 配送以及财务审核中保单信息配置
 */
- (void)setupCommonDFBillCellWithDetailBaseModel:(XCCheckoutDetailBaseModel *)model;

+ (CGFloat)getCellHeight;
+ (CGFloat)getCaseCellHeightWithClip:(BOOL)clip;
@end
