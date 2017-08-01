//
//  DefineUM.h
//  MeiYueFuBusinessClient
//
//  Created by 拾光 on 2017/5/4.
//  Copyright © 2017年 丶拾光. All rights reserved.
//

#ifndef DefineUM_h
#define DefineUM_h


#import <UMMobClick/MobClick.h>

//   [MobClick event:];


#define kUM_agent_homepage_overdue          @"agent_homepage_overdue"//管家-首页-逾期需处理
#define kUM_agent_homepage_undone           @"agent_homepage_undone"//管家-首页-登记未完成
#define kUM_agent_homepage_tab              @"agent_homepage_tab"  //管家-首页-tab切换
#define kUM_agent_order_tab                 @"agent_order_tab"  //管家-租客-tab切换
#define kUM_agent_register                  @"agent_register"  //管家—租客登记
#define kUM_agent_finance_tab               @"agent_finance_tab"  //管家—财务_tab切换
#define kUM_agent_personal_tab              @"agent_personal_tab"  //管家-我的-tab切换
#define kUM_agent_homepage_withdraw            @"agent_homepage_withdraw"  //管家-申请提现操作
#define kUM_agent_event_withdraw            @"agent_event_withdraw"  //管家-申请提现操作
#define kUM_agent_event_withdraw_done       @"agent_event_withdraw_done"  //管家-申请提现操作_操作完成
#define kUM_agent_order_detail              @"agent_order_detail"  //管家-租客-租客详情1
#define kUM_agent_personal_userinfo         @"agent_personal_userinfo"  //管家-我的-个人资料
#define kUM_agent_personal_withdraw         @"agent_personal_withdraw"  //管家-我的-提现
#define kUM_agent_personal_bankcard         @"agent_personal_bankcard"  //管家-我的-银行卡1
#define kUM_agent_personal_weixinbind       @"agent_personal_weixinbind"  //管家-我的-微信绑定
#define kUM_agent_personal_weixinunbind     @"agent_personal_weixinunbind"  //管家-我的-微信解绑
#define kUM_agent_personal_message          @"agent_personal_message"  //管家-我的-我的消息
#define kUM_agent_personal_help             @"agent_personal_help"  //管家-我的-常见问题
#define kUM_agent_personal_feedback         @"agent_personal_feedback"  //管家-我的-意见反馈
#define kUM_agent_personal_about            @"agent_personal_about"  //管家-我的-关于我们
#define kUM_agent_register_userinfo         @"agent_register_userinfo"  //管家-登记-填写信息
#define kUM_agent_register_editplan         @"agent_register_editplan"  //管家-登记-编辑收租计划
#define kUM_agent_register_certification    @"agent_register_certification"  //管家-登记-人脸识别
#define kUM_agent_register_certification_fail   @"agent_register_certification_fail"  //管家-登记-人脸识别_识别失败
#define kUM_agent_register_scan                 @"agent_register_scan"  //管家-登记-租客扫码
#define kUM_agent_register_uploadcontract       @"agent_register_uploadcontract"  //管家-登记-上传合同
#define kUM_agent_order_checklist               @"agent_order_checklist"  //管家-租客-账单列表
#define kUM_agent_order_checklist_detail        @"agent_order_checklist_detail"  //管家-租客-账单列表_详情
#define kUM_agent_finance_checkdetail           @"agent_finance_checkdetail"  //管家-财务-账单详情


#define kUM_agent_homepage_totallist_select     @"agent_homepage_totallist_select"  //管家-首页-月份统计列表-点击
#define kUM_agent_order_detail_phone            @"agent_order_detail_phone"  //管家-租客-详情页-电话
#define kUM_agent_order_detail_delete           @"agent_order_detail_delete"  //管家-租客-详情-删除按钮点击
#define kUM_agent_personal_message_withdraw     @"agent_personal_message_withdraw"  //管家-我的-消息-登记
#define kUM_agent_personal_message_register     @"agent_personal_message_register"  //管家-我的-消息-登记
#define kUM_agent_personal_message_system       @"agent_personal_message_system"  //管家-我的-消息-系统
#define kUM_agent_personal_feedback_confirm     @"agent_personal_feedback_confirm"  //管家-我的-意见反馈-提交
#define kUM_agent_register_editplan_alert       @"agent_register_editplan_alert"  //管家-登记-编辑收租计划-弹窗
#define kUM_agent_register_editplan_add         @"agent_register_editplan_add"  //管家-登记-编辑收租计划-添加
#define kUM_agent_register_editplan_delete         @"agent_register_editplan_delete"  //管家-登记-编辑收租计划-删除
#define kUM_agent_register_review1              @"agent_register_review1"  //管家-登记-回显1
#define kUM_agent_register_review1_reviewplan    @"agent_register_review1_reviewplan"  //管家-登记-回显1-查看收租计划
#define kUM_agent_register_review2              @"agent_register_review2"  //管家-登记-回显2
#define kUM_agent_register_review3              @"agent_register_review3"  //管家-登记-回显3
#define kUM_agent_order_search_pv               @"agent_order_search_pv"  //管家-租客-搜索-pv
#define kUM_agent_order_search_handle           @"agent_order_search_handle"  //管家-租客-搜索-操作
#define kUM_agent_order_search_list_select      @"agent_order_search_list_select"  //管家-租客-搜索-列表点击
#define kUM_agent_order_type_2                  @"agent_order_type_2"  //管家-租客_type切换_未完成
#define kUM_agent_order_type_3                  @"agent_order_type_3"  //管家-租客_type切换_租住中
#define kUM_agent_order_type_4                  @"agent_order_type_4"  //管家-租客_type切换_已退租
#define kUM_agent_order_type_5                  @"agent_order_type_5"  //管家-租客_type切换_失败
#define kUM_agent_order_type_8                  @"agent_order_type_8"  //管家-租客_type切换_住满
#define kUM_agent_finance_calendar_select       @"agent_finance_calendar_select"  //管家-财务-日历点击
#define kUM_agent_finance_calendar_today        @"agent_finance_calendar_today"  //管家-财务-日历-返回今天
#define kUM_agent_finance_checkdetail_unpay     @"agent_finance_checkdetail_unpay"  //管家-财务-账单详情-未完成
#define kUM_agent_finance_checkdetail_already    @"agent_finance_checkdetail_already"  //管家-财务-账单详情-已完成
#define kUM_agent_finance_checkdetail_cancel    @"agent_finance_checkdetail_cancel"  //管家-财务-账单详情_已退租
#define kUM_agent_finance_record                @"agent_finance_record"  //管家-财务-明细
#define kUM_agent_finance_record_detail         @"agent_finance_record_detail"  //管家-财务-明细-详情
//#define kUM_    @""  //
//#define kUM_    @""  //


//,,0
//,,0
//,,0
//,,0
//,,0
//,,0
//,,0
//,,0
//,,0

#endif /* DefineUM_h */
