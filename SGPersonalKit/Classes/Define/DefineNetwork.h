//
//  DefineNetwork.h
//  MeiYueFuBusinessClient
//
//  Created by 拾光 on 2017/2/26.
//  Copyright © 2017年 丶拾光. All rights reserved.
//

#ifndef DefineNetwork_h
#define DefineNetwork_h

typedef NS_ENUM(NSInteger, StatusCode){
    StatusCode_Success          =0,//成功
    StatusCode_ServerError      =-1,//服务器异常
    StatusCode_Relogin          =-100,//请重新登录
    StatusCode_AccountUnsafe          =-55,//账号不安全 设备id匹配不上需申诉
    StatusCode_WeiXinNotBind          =-15,//微信未绑定
    StatusCode_ParameterError   =2,//参数有误
    StatusCode_NoPermissions    =3,//没有权限操作
    StatusCode_NotUpdate        =4,//不能进行更新
    StatusCode_NotRecommend        =5,//不能进行推单
    StatusCode_NotLogin         =10,//用户未登录
};

#define SERVER_HOST_TEST1               @"http://192.168.0.115:8080/"         //立洋测试地址
#define SERVER_HOST_TEST11               @"http://192.168.0.114:8080/"         //启明测试地址
#define SERVER_HOST_OFFICIAL_Text               @"http://test.meiyuefu.com/"         //外网测试地址
#define SERVER_HOST_ShouZu         @"http://shouzu.meiyuefu.com/"          //生产地址
#define SERVER_HOST_yuefu         @"https://www.meiyuefu.com/"          //生产地址
#define SERVER_HOST_TEST2           @"http://101.200.54.50:8805/"
#define HOST_TITLE_ARRAY   @[@"美月收生产环境",@"测试地址2",@"外网测试地址",@"立洋测试环境",@"启明测试环境",@"月付生产环境"]
#define HOST_ARRAY   @[SERVER_HOST_ShouZu,SERVER_HOST_TEST2,SERVER_HOST_OFFICIAL_Text,SERVER_HOST_TEST1,SERVER_HOST_TEST11,SERVER_HOST_yuefu]

#define kServerHost  @"kServerHost"

#pragma mark     ⬇️⬇️⬇️⬇️⬇️⬇️⬇️测试与正式环境切换⬇️⬇️⬇️⬇️⬇️⬇️⬇️
//如果是debug模式 可摇一摇调出dubug面板切换测试与线上环境  否则为正式环境
#define SERVER_HOST  SERVER_HOST_ShouZu





#define kObject     @"object"
#define kCode       @"code"
#define kMsg        @"message"


#pragma mark - 接口 - 
#define ApiLogin                        @"app/public/checklogin"//用户登录
#define ApiCaptcha                      @"app/public/getcaptcha"//获取验证码

#define ApiReport                       @"app/public/report"//数据上报
#define ApiVersion                      @"app/public/version"//版本更新信息接口
#define ApiFeedBack                     @"app/agent/add/suggestpost"//经纪人意见反馈接口
#define ApiHelpList                     @"app/public/get/helplist"//帮助列表
#define ApiChangePassword               @"app/agent/update/password"//经纪人修改密码
#define ApiMessageList                  @"app/public/get/messagelist"//消息查询接口
#define ApiWeiXinBind                   @"app/public/userbindopenid"//绑定微信openid
#define ApiWeiXinUnBind                 @"app/public/userunbindopenid"//解绑微信
#define ApiUpdateCertification          @"app/public/authentication"//修改认证状态
#define ApiUploadCerInfo                @"app/public/idcardupload"//上传认证信息
#define ApiRegister                     @"app/public/register"//注册
#define ApiRegisterCaptcha              @"app/agent/getregistercaptcha"//获取注册验证码
#define ApiCheckRegisterCaptcha         @"app/agent/checkcaptcha"//校验注册验证码

#define ApiOrderList               @"app/agent/get/recommendlist"//租客列表 done
#define ApiOrderDetail             @"app/agent/get/orderdetail"//管家获取租客详情接口 done

#define ApiOrderRecommentPost      @"app/agent/add/recommendpost"//管家推单接口、续租接口复用
#define ApiOrderCerResult          @"app/agent/orderauthentication"//租客人脸识别认证结果
#define ApiOrderStatus             @"app/agent/get/orderstatus"//轮训订单状态接口
#define ApiOrderUploadCerInfo      @"app/agent/useridcardupload"//认证信息上传接口 （租客人脸识别）
#define ApiOrderRentPlan           @"app/agent/getprewciewbillcheck"//收租计划接口

#define ApiCheckOrderDate          @"app/agent/checkorderbasisinfo"//校验下单日期
#define ApiFinanceList             @"app/agent/getDayAccountDetailList"//每日财务列表
#define ApiFinanceCalendarList     @"app/agent/getCalendarInfo"//财务日历统计列表
#define ApiBillDetail              @"app/agent/getbillcheckInfo"//账单详情
#define ApiMonthTotalList          @"app/agent/getAccountDetailStatList"//每日财务统计

#define ApiShangQuanPost           @"app/agent/get/shangquanpost"//小区商圈接口
#define ApiUpdateOrder             @"app/agent/update/order"//管家修改订单接口
#define ApiUploadContract          @"app/agent/add/contractuploadBatch"//管家提交租房合同接口
#define ApiDeleteOrder             @"app/agent/orderdelete"//管家删除订单
#define ApiRecommendConfig         @"app/agent/getagentforbiddenstatus"//推单权限
#define ApiOrderClone              @"app/agent/orderclone"//信息补全 线下转线上
#define ApiSkipFaceCheck           @"app/agent/skipfacecheckpost"//跳过接口
#define ApiCityList                 @"app/agent/get/citypost"//小区商圈接口

#pragma mark - 法人接口

#define ApiLegalHomepage                @"app/agent/firstpageinfo"//
#define ApiLegalToDo                    @"app/agent/firstpagetodolist"//待办列表
#define ApiLegalBankCardList            @"app/agent/bankcardlist"//银行卡
#define ApiLegalWithdrawInfo            @"app/agent/getfinanceinfo"//可提现信息
#define ApiLegalWithdrawPost            @"app/agent/prewithdrawpost"//提现操作
#define ApiLegalClearOrder              @"app/agent/renttuiorder"//清退操作"
#define ApiLegalClearConfirm            @"app/agent/confirmqingtui"//清退确认
#define ApiLegalClearOrderInfo          @"app/public/qingtuipreview"//清退预览信息"
#define ApiLegalWithdrawRecord          @"app/agent/prewithdrawrecord"//提现记录
#define ApiLegalWithdrawDetail          @"app/agent/prewithdrawInfo"//提现详情
#define ApiLegalAgentList               @"app/agent/getagentpage"//房管员列表
#define ApiLegalTransferAgentList       @"app/agent/getsubagentlist"//转移管家列表
#define ApiLegalOrderTransfer           @"app/agent/transorderagent"//转移订单
#define ApiLegalAgentDetail             @"app/agent/getagentdetail"//房管员详情
#define ApiLegalAddAgent                @"app/agent/addagent"//添加房管员
#define ApiLegalAgentRecordStatus       @"app/agent/updateagentrecordstatus"//管家工作状态修改
#define ApiLegalAgentValid              @"app/agent/updateagentvalid"//管家操作权限
#define ApiLegalChooseCommunityList     @"app/agent/gethousecommunitylist"//小区列表
#define ApiLegalCommunityList           @"app/agent/gethouseinfocommunityalllist"//小区列表
#define ApiLegalChooseHouseList         @"app/agent/getvacancyhouselist"//小区房屋列表
#define ApiLegalHouseList               @"app/agent/getCommunityDetailList"//小区房屋列表
#define ApiLegalAddHouse                @"app/agent/addhouseinfo"//添加房屋
#define ApiLegalChooseRoomList          @"app/agent/getroomlist"//合租房间列表
#define ApiLegalInitial                 @"app/agent/queryinitial"//小区首字母
#define ApiLegalHouseInfo               @"app/agent/getroominfo"//房屋详情
#define ApiLegalAddRoom                 @"app/agent/addroompost"//房间添加
#define ApiLegalDeleteRoom                 @"app/agent/roomdelete"//房间删除
#define ApiLegalRoomChart                 @"app/agent/getroomchart"//房屋收益数据

#define ApiLegalSearchCommunity         @"app/agent/getcommunitysug"//模糊匹配小区
#define ApiLegalRechargeCode            @"app/agent/rechargesign"//
#define ApiLegalRechargePay            @"app/agent/rechargepay"//
#define ApiLegalUpdateBill            @"app/agent/update/billcheckpaystatus"//

#define ApiLegalBKList              @"app/agent/accountlist"//记账列表
#define ApiLegalBKCommunityList     @"app/agent/gethouseinfocommunityalllist"//记账小区列表
#define ApiLegalBKHouseList         @"app/agent/getvacancyhouselist"//记账小区房屋列表
#define ApiLegalBKEdit              @"app/agent/addaccountbook"//添加记账

#define ApiLegalBKConfig              @"app/agent/accounticonenum"//记账配置
#define ApiLegalBKDetail              @"app/agent/accountdetail"//记账详情
#define ApiLegalBKDelete                @"app/agent/accountdelete"//记账删除

#define ApiLegalHouseBookkeepingInfo    @"app/agent/getroomaccountinfo"//房屋记账
#define ApiLegalHouseBKMonthList        @"app/agent/getroomaccountinfomonth"//房屋记账每月


#pragma mark - 房管员接口

#define ApiAgentHomepage                @"app/agent/agentfirstpage"//



#endif /* DefineNetwork_h */
