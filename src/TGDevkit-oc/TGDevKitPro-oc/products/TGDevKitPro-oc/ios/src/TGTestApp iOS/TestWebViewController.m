////
////  RealNameWebViewController.m
////  TGTestApp iOS
////
////  Created by toad on 2022/07/21.
////
//
//#import "TestWebViewController.h"
//#import <WebKit/WebKit.h>
////#import <SRIDCardReader/SRIDCardReader.h>
//#import "ZSYPopoverListView.h"
//@interface TestWebViewController ()<CBCentralManagerDelegate,SRIDCardReaderDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UITextFieldDelegate>{
//    
////     SRIDCardReader *sr;
//    CBCentralManager *manager;
//    CBPeripheral *currentDevice;
//    
//    NSMutableArray *deviceList;
//}
//
//@property (nonatomic,assign) BOOL needReload;
//@property (nonatomic,strong) IBOutlet WKWebView *webView;
//@property (nonatomic,strong) IBOutlet BaseTextField *txtUrl;
//@property (nonatomic,strong) IBOutlet UIScrollView *debugView;
//@property (nonatomic,strong) IBOutlet UITextView *txtJavaSprict;
//@end
//
//@implementation TestWebViewController
//
//- (NSArray<NSDictionary *> *) debugItems{
//    return @[
//        @{
//            @"TITLE":@"返回",
//            @"ACTION":NSStringFromSelector(@selector(click_GoBack:))
//        }
//        ,
//        @{
//            @"TITLE":@"前进",
//            @"ACTION":NSStringFromSelector(@selector(click_forward:))
//        }
//        ,@{
//            @"TITLE":@"刷新",
//            @"ACTION":NSStringFromSelector(@selector(click_reload:))
//        }];
//}
//
//- (IBAction) click_forward:(id)sender{
//    if ([self.webView canGoForward]) {
//        [self.webView goForward];
//    }
//}
//- (IBAction) click_reload:(id)sender{
//    [self.webView reload];
//}
//
//- (IBAction) click_showHideDebug:(id)sender{
//    [self.debugView setHidden:!self.debugView.hidden];
//}
//
//- (void )evaluateJavaScript:(NSString *)javaScript{
//    [self.webView evaluateJavaScript:@"" completionHandler:^(id _Nullable x, NSError * _Nullable error) {
//        if (NULL != error) {
//            [self showAlertTitle:@"WKWebView 调用 JS" message:[NSString stringWithFormat:@"失败：%@",error] handler:nil];
//        }
//        else {
//            [self showAlertTitle:@"WKWebView 调用 JS" message:[NSString stringWithFormat:@"返回结果：%@",NULL != x ? x : @"无"] handler:nil];
//        }
//    }];
//}
//
//- (WKWebView *)webView{
//    if (!_webView) {
//        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//        NSArray<NSString *> *handlerNames = @[@"readCardInfo",@"Share",@"Camera"];
//        for (int i = 0 ; i < [handlerNames count]; i++) {
//            [userContentController addScriptMessageHandler:self name:handlerNames[i]];
//        }
//        configuration.userContentController = userContentController;
//        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
//        _webView.UIDelegate = self;
//        _webView.navigationDelegate = self;
//    }
//    return _webView;
//}
//
//- (UITextView *)txtJavaSprict{
//    if (!_txtJavaSprict) {
//        _txtJavaSprict = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
//    }
//    return _txtJavaSprict;
//}
//
//- (UIView *)debugView{
//    
//    if (!_debugView) {
//        
////        _debugView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 52)];
//        _debugView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 52)];
//        CGRect frame = CGRectMake(0, 4, 0, 52 - 8);
//        
//        NSArray<NSDictionary *> *debugItems = [self debugItems];
//                
//        int index = 0;
//        
//        for (NSDictionary * item in debugItems) {
//            NSString *title = item[@"TITLE"];
//            UIButton *debugBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            frame.origin.x = CGRectGetMaxX(frame) + 8;
//            CGFloat width = [title sizeWithAttributes:@{
//                NSFontAttributeName:debugBtn.titleLabel.font
//            }].width;
//            width = MAX(48, width + 8);
//            frame.size.width = width;
//            
//            debugBtn.layer.borderColor = [UIColor grayColor].CGColor;
//            debugBtn.layer.borderWidth = 0.5;
//            debugBtn.frame = frame;
//            
//            [debugBtn setTitle:item[@"TITLE"] forState:UIControlStateNormal];
//            [debugBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            SEL sel = NSSelectorFromString(item[@"ACTION"]);
//            if ([self respondsToSelector:sel]) {
//                [debugBtn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
//            }
//            [_debugView addSubview:debugBtn];
//        }
//        [_debugView setContentSize:CGSizeMake(CGRectGetMaxX(frame), CGRectGetHeight(_debugView.frame))];
//        
//        _debugView.layer.borderColor = [UIColor blueColor].CGColor;
//        _debugView.layer.borderWidth = 0.5;
//    }
//    return _debugView;
//}
//
//- (UITextField *)txtUrl{
//    if (!_txtUrl) {
//        _txtUrl = [[BaseTextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 32)];
//        _txtUrl.backgroundColor = [UIColor colorNamed:@"COLOR_BACKCOLOR"];
//        _txtUrl.returnKeyType = UIReturnKeyGo;
//        _txtUrl.delegate = self;
//    }
//    return _txtUrl;
//}
//
//- (void) reloadData{
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.uri]];
//    [self.webView loadRequest:request];
//    self.needReload = false;
//}
//
//- (void) layoutSubviews{
//    CGRect frame = self.view.bounds;
//    self.navigationController.navigationBar.translucent = NO;
//    frame.size.height = 32;
//    self.txtUrl.frame = frame;
//    
//
//    frame.origin.y = CGRectGetMaxY(frame);
//    frame.size.height = CGRectGetMaxY(self.view.bounds) - frame.origin.y;
//    [self.webView setFrame:frame];
//    frame.origin.y = self.view.bounds.size.height - self.debugView.frame.size.height;
//    frame.size.height = self.debugView.frame.size.height;
//    self.debugView.frame = frame;
//    self.debugView.hidden = true;
//}
//
//- (IBAction) click_GoBack:(id)sender{
//    if (self.webView.canGoBack) {
//        [self.webView goBack];
//    }
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    
//    self.needReload = true;
//    [self.view addSubview:self.webView];
//    [self.view addSubview:self.txtUrl];
//    [self.view addSubview:self.debugView];
//    
//    UIBarButtonItem *goBackItem = [[UIBarButtonItem alloc] initWithTitle:@"调试" style:UIBarButtonItemStylePlain target:self action:@selector(click_showHideDebug:)];
//    self.navigationItem.rightBarButtonItem = goBackItem;
//    
////    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(click_reloadWebview:)];
////    self.navigationItem.rightBarButtonItem = rightItem;
//}
//
//- (void) viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    [self layoutSubviews];
//}
//
//- (void) asdasd{
//    NSString *javaScript = @"";
//    [self.webView evaluateJavaScript:javaScript completionHandler:^(id _Nullable, NSError * _Nullable error) {
//        
//    }];
//}
//
//- (void) viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    if (self.needReload) {
//        [self reloadData];
//    }
//}
//- (IBAction) click_reloadWebview:(id)sender{
//    [self reloadData];
//}
//
//- (void) initSR{
//    manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
//    sr = [SRIDCardReader initDevice];
//    sr.delegate = self;
//}
//- (IBAction)readerList:(id)sender {
//    deviceList=nil;
//    manager.delegate=self;
//    [manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
//    
//}
//-(void)connectReader:(CBPeripheral *)peripheral{
//    int ret = [sr connectPeripheral:peripheral withCBManager:manager withTimeout:15];
//    NSLog(@"ret:%d",ret);
//    if (ret == 0) {
//        [sr readIDCardByJson:15];
//    }else{
//    }
//    
//}
//
//#pragma mark - WKNavigationDelegate
//
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
//{
//    
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
//{
//    self.navigationItem.title = webView.title;
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
//{
//    self.navigationItem.title = webView.title;
//}
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSString* reqUrl = navigationAction.request.URL.absoluteString;
//    self.txtUrl.text = reqUrl;
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
//
//#pragma mark - WKScriptMessageHandler
//
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
//    [self showAlertTitle:@"JS 调用 WKWebView" message:[NSString stringWithFormat:@"name:%@\nbody:%@",message.name,message.body] handler:nil];
//}
//
//#pragma mark ZSYPopoverListDelegate
//- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    self.selectedIndexPath = indexPath;
//    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
//    cell.imageView.image = [UIImage imageNamed:@"fs_main_login_selected.png"];
//    currentDevice=[deviceList objectAtIndex:indexPath.row];
//    [self performSelectorOnMainThread:@selector(connectReader:) withObject:currentDevice waitUntilDone:NO];
////    _readerLable.text = currentDevice.name;
//    if ([currentDevice.name containsString:@"XGD"]) {
////        isMposDevice = true;
//    }else{
////        isMposDevice = false;
//    }
//    //    [self connectReader:currentDevice];
////    [listView dismiss];
//}
//
//
//#pragma mark Sunrise_BLE_STIDCardReaderDelegate
///*
// 功能：代理方法，当扫描到周围的蓝牙设备时，通过该代理获得代表各个蓝牙设备的对象数组
// 参数：蓝牙对象数组
// 返回值：无
// */
//- (void)didUpdatePeripheralList:(NSArray *)peripherals{
//    if (deviceList == nil) {
//        deviceList = [NSMutableArray array];
//    }
//    for (int i=0;i<[peripherals count];i++) {
//        currentDevice = peripherals[i];
//        if ([deviceList containsObject:currentDevice]) {
//            continue;
//        }
//        [deviceList addObject:currentDevice];
//        NSLog(@"%@",deviceList);
////        rowCount=(int)[deviceList count];
////        [listView.mainPopoverListView reloadData];
//    }
//}
//
///*
// 功能：代理方法，读取身份证成功时可以通过这个代理方法获取身份证信息
// 参数：peripheral 代表蓝牙设备的对象
//      data 身份证信息
// 返回值：无
// */
//- (void)SRsuccessBack:(CBPeripheral *)peripheral withData:(id)data{
//    
//}
///*
// 功能：代理方法，读取身份证成功时可以通过这个代理方法同时返回信息和头像
// idCardName 姓名
// idCardEngName 英文名（外国人永居证特有，其他为空字符串）
// idCardSex 性别
// idCardNation 民族（外国人永居证为国籍）
// idCardVersion 证件版本号（外国人永居证特有，其他为空字符串）
// idCardBorn 出生日期（格式：yyyyMMdd）
// idCardAddr 住址（外国人永居证为空字符串）
// idCardNo 证件号码
// idCardIssueAt 签发机关
// idCardEffDate 有效期起始日期（格式：yyyyMMdd）
// idCardExpDate 有效期截止日期（格式：yyyyMMdd）
// idCardPassCardNo 通行证号码（港澳台居住证特有，其他为空字符串）
// idCardPassNum 签发次数（港澳台居住证特有，其他为空字符串）
// idCardCertType 证件类型（"I"为外国人永居证，"J"为港澳台居住证，""为大陆居民身份证）
// idCardPhoto 头像数据（NSData类型）;
// 参数：peripheral 代表蓝牙设备的对象
// data 证件信息
// */
//- (void)SRsuccessIdCardInfoAndPhotoBack:(CBPeripheral*)peripheral withData:(id)data{
//    //    NSLog(@"证件信息：%@",(NSDictionary*)data);
//}
//#pragma  mark -- CBCentralManagerDelegate
//- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
//    switch (central.state) {
//        case CBManagerStateResetting:
//            break;
//            
//        case CBManagerStateUnsupported:
//            break;
//        case CBManagerStateUnauthorized:
//            break;
//        case CBManagerStatePoweredOff:
////            [self showMessage:@"尚未打开蓝牙，请在设置中打开"];
//            break;
//        case CBManagerStatePoweredOn:
//            break;
//        default:
//            break;
//    }
//}
//
//- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheraln advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
//    //发现设备
//    if(deviceList==nil){
//        deviceList=[NSMutableArray array];
//    }
//    if([deviceList containsObject:peripheraln] || peripheraln.name == nil){
//        return;
//    }
////    //
////    ////    if([peripheraln.name hasPrefix:@"KT8"])
////    if (peripheraln.name.length != 0) {
////        [deviceList addObject:peripheraln];
////    }else{
////        [nullList addObject:peripheraln];
////    }
//////    NSLog(@"%@",deviceList);
////    rowCount=(int)[deviceList count];
////    [listView.mainPopoverListView reloadData];
//}
//
//- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
//    NSLog(@"has connected");
//    //    [self.mutableData setLength:0];
//    //    self.peripheral.delegate = self;
//    //此时设备已经连接上了  你要做的就是找到该设备上的指定服务 调用完该方法后会调用代理CBPeripheralDelegate（现在开始调用另一个代理的方法了）的
//    //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
//    //    [self.peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
//    
//}
//
//- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
//    //此时连接发生错误
//    NSLog(@"connected periphheral failed");
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if (self.txtUrl.text.length < 1) {
//        [self showAlert:@"没有地址" handler:NULL];
//        return true;
//    }
//    NSURL *url = [NSURL URLWithString:self.txtUrl.text];
//    if (NULL == url) {
//        [self showAlert:[NSString stringWithFormat:@"地址不对:%@",self.txtUrl.text] handler:NULL];
//        return true;
//    }
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
//    return true;
//}
//
//@end
