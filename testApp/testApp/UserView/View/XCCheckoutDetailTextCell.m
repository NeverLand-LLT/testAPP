//
//  XCCheckoutDetailTextCell.m
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutDetailTextCell.h"
#import "XCCheckoutDetailBaseModel.h"
#import "XCCustomerDetailModel.h"
@interface XCCheckoutDetailTextCell()

@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UILabel * placeholderLabel ;
@property (nonatomic, strong) UIView * separtatorLine ;

@end

@implementation XCCheckoutDetailTextCell

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _shouldShowSeparator = NO;
        [self configSubVies];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    CGFloat labeH = 24 * ViewRateBaseOnIP6;
    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - labeH) * 0.5, labelSize.width,labeH)];
    
    [_placeholderLabel sizeToFit];
    labelSize = _placeholderLabel.frame.size;
    [_placeholderLabel setFrame:CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 16 * ViewRateBaseOnIP6, _titleLabel.frame.origin.y, labelSize.width, labeH)];
    if (_shouldShowSeparator) {
        [_separtatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , self.bounds.size.height - 1, self.bounds.size.width - 30 * ViewRateBaseOnIP6, 1)];
    }
}

#pragma mark - Action Method

- (void)setupCellWithDetailPolicyModel:(XCCheckoutDetailBaseModel *)model
{
    if ([self.title isEqualToString:@"投保人:"] && isUsableNSString(model.onwerName,@"")) {
        [_placeholderLabel setText:model.onwerName];
    }
    else if ([self.title isEqualToString:@"身份证:"] && isUsableNSString(model.onwerIdentify,@"")) {
        [_placeholderLabel setText:model.onwerIdentify];
    }
    else if ([self.title isEqualToString:@"车牌号:"] && isUsableNSString(model.plateNo,@"")) {
        [_placeholderLabel setText:model.plateNo];
    }
    else if ([self.title isEqualToString:@"车架号:"] && isUsableNSString(model.vinNo,@"")) {
        [_placeholderLabel setText:model.vinNo];
    }
    else if ([self.title isEqualToString:@"初登日期:"] && isUsableNSString(model.recordDate,@"")) {
        [_placeholderLabel setText:model.recordDate];
    }
    else if ([self.title isEqualToString:@"发动机号:"] && isUsableNSString(model.engineNo,@"")) {
        [_placeholderLabel setText:model.engineNo];
    }
    else if ([self.title isEqualToString:@"车型名称:"] && isUsableNSString(model.brand,@"")) {
        [_placeholderLabel setText:model.brand];
    }
    else if ([self.title isEqualToString:@"车型代码:"] && isUsableNSString(model.model,@"")) {
        [_placeholderLabel setText:model.model];
    }
    else if ([self.title isEqualToString:@"(商业)起保日期:"] && isUsableNSString(model.syEffectDate,@"")) {
        [_placeholderLabel setText:model.syEffectDate];
    }
    else if ([self.title isEqualToString:@"(交强)起保日期:"] && isUsableNSString(model.jqEffectDate,@"")) {
        [_placeholderLabel setText:model.jqEffectDate];
    }
    else if ([self.title isEqualToString:@"保险公司:"] && isUsableNSString(model.insurerName,@"")) {
        [_placeholderLabel setText:model.insurerName];
    }
    else if ([self.title isEqualToString:@"缴费通知单号:"] && isUsableNSString(model.payNoticeNo,@"")) {
        [_placeholderLabel setText:model.payNoticeNo];
    }
    else if ([self.title isEqualToString:@"交强险(业务员)金额:"] && isUsable(model.jqMoney, [NSNumber class])) {
        [_placeholderLabel setText:[NSString stringWithFormat:@"%2f",[model.jqMoney doubleValue]]];
    }
    else if ([self.title isEqualToString:@"商业险(业务员)金额:"] && isUsable(model.syMoney, [NSNumber class])) {
      [_placeholderLabel setText:[NSString stringWithFormat:@"%2f",[model.syMoney doubleValue]]];
    }
    else if ([self.title isEqualToString:@"交强险(出单员)金额:"] && isUsable(model.jqMoneyExport, [NSNumber class])) {
      [_placeholderLabel setText:[NSString stringWithFormat:@"%2f",[model.jqMoneyExport doubleValue]]];
    }
    else if ([self.title isEqualToString:@"商业险(出单员)金额:"] &&  isUsable(model.syMoneyExport, [NSNumber class])) {
          [_placeholderLabel setText:[NSString stringWithFormat:@"%2f",[model.syMoneyExport doubleValue]]];
    }
    else if ([self.title isEqualToString:@"出单员:"] && isUsableNSString(model.exportmanName,@"")) {
        [_placeholderLabel setText:model.exportmanName];
    }
    else if ([self.title isEqualToString:@"交强险:"] && isUsable(model.jqValue, [NSNumber class])) {
         [_placeholderLabel setText:[NSString stringWithFormat:@"%2f",[model.jqValue doubleValue]]];
    }
    else if ([self.title isEqualToString:@"机动车损险:"] && isUsable(model.csValue, [NSNumber class])) {
          [_placeholderLabel setText:[NSString stringWithFormat:@"%2f",[model.csValue doubleValue]]];
    }
    else if ([self.title isEqualToString:@"出单员:"] && isUsableNSString(model.exportmanName,@"")) {
        [_placeholderLabel setText:model.exportmanName];
    }
    else if ([self.title isEqualToString:@"第三责任险:"] && isUsable(model.szValue, [NSNumber class])) {
          [_placeholderLabel setText:[NSString stringWithFormat:@"%2f",[model.szValue doubleValue]]];
    }
    else if ([self.title isEqualToString:@"车上(司机)险:"] && isUsable(model.cssjValue, [NSNumber class])) {
          [_placeholderLabel setText:[NSString stringWithFormat:@"%2f",[model.cssjValue doubleValue]]];
    }
    else if ([self.title isEqualToString:@"车上(乘客)险:"] && isUsable(model.csckValue, [NSNumber class])) {
          [_placeholderLabel setText:[NSString stringWithFormat:@"%2f",[model.csckValue doubleValue]]];
    }
}

- (void)setupCellWithCustomerDetailModel:(XCCustomerDetailModel *)model
{
    if ([self.title isEqualToString:@"客户名称:"] && isUsableNSString(model.customerName,@"")) {
        [_placeholderLabel setText:model.customerName];
    }
    else if ([self.title isEqualToString:@"客户来源:"] && isUsableNSString(model.source,@"")) {
        [_placeholderLabel setText:model.source];
    }
    else if ([self.title isEqualToString:@"性别:"] && isUsableNSString(model.sex,@"")) {
        [_placeholderLabel setText:model.sex];
    }
    else if ([self.title isEqualToString:@"生日:"] && isUsableNSString(model.birthday,@"")) {
        [_placeholderLabel setText:model.birthday];
    }
    else if ([self.title isEqualToString:@"区域:"] && isUsableNSString(model.area,@"")) {
        [_placeholderLabel setText:model.area];
    }
    else if ([self.title isEqualToString:@"地址:"] && isUsableNSString(model.address,@"")) {
        [_placeholderLabel setText:model.address];
    }
    else if ([self.title isEqualToString:@"身份证:"] && isUsableNSString(model.identity,@"")) {
        [_placeholderLabel setText:model.identity];
    }
    else if ([self.title isEqualToString:@"车牌号:"] && isUsableNSString(model.brand,@"")) {
        [_placeholderLabel setText:model.brand];
    }
    else if ([self.title isEqualToString:@"初登日期:"] && isUsableNSString(model.recordDate,@"")) {
        [_placeholderLabel setText:model.recordDate];
    }
    else if ([self.title isEqualToString:@"车架号:"] && isUsableNSString(model.vinNo,@"")) {
        [_placeholderLabel setText:model.vinNo];
    }
    else if ([self.title isEqualToString:@"发动机号:"] && isUsableNSString(model.engineNo,@"")) {
        [_placeholderLabel setText:model.engineNo];
    }
    else if ([self.title isEqualToString:@"车型代码:"] && isUsableNSString(model.model,@"")) {
        [_placeholderLabel setText:model.vinNo];
    }
    else if ([self.title isEqualToString:@"联系方式:"] && isUsableNSString(model.phoneNo,@"")) {
        [_placeholderLabel setText:model.phoneNo];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configSubVies
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setFont:[UIFont systemFontOfSize: 26 * ViewRateBaseOnIP6]];
    [_titleLabel setTextColor:COLOR_RGB_255(68, 68, 68)];
    [self addSubview:_titleLabel];
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_placeholderLabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
    [_placeholderLabel setTextColor:COLOR_RGB_255(165, 165, 165)];
    [self addSubview:_placeholderLabel];
    
    _separtatorLine = [[UIView alloc] init];
    [_separtatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    [self addSubview:_separtatorLine];
}

#pragma mark - Setter&Getter

- (void)setTitle:(NSString *)title
{
    if ([_title isEqualToString:title]) {
        return;
    }
    _title = title;
    [_titleLabel setText:_title];
    [_titleLabel sizeToFit];

}

- (void)setTitlePlaceholder:(NSString *)titlePlaceholder
{
    if ([_titlePlaceholder isEqualToString:titlePlaceholder]) {
        return;
    }
    _titlePlaceholder = titlePlaceholder;
    [_placeholderLabel setText:_titlePlaceholder];
    [_placeholderLabel sizeToFit];
}


@end
