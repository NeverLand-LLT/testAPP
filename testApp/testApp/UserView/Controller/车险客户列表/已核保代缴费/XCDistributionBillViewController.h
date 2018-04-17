//
//  XCDistributionBillViewController.h
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"

@interface XCDistributionBillViewController : XCUserBaseViewController
/** 商业险金额 */
@property (nonatomic, strong) NSString * syMoney ;
/** 交强险金额 */
@property (nonatomic, strong) NSString * jqMoney ;
/** 保单ID */
@property (nonatomic, strong) NSNumber * policyId ;
/** 礼包数据 */
@property (nonatomic, strong) NSArray * packageArr ;
@end
