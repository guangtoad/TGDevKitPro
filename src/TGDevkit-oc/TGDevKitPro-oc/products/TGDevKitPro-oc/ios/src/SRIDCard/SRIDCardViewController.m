////
////  SRIDCardViewController.m
////  TGTestApp iOS
////
////  Created by toad on 2022/08/02.
////
//
//#import "SRIDCardViewController.h"
//#import <CoreBluetooth/CoreBluetooth.h>
////#import <SRIDCardReader/SRIDCardReader.h>
//#import <ReactiveObjC/ReactiveObjC.h>
//
//#define APP_KEY @"80FCA4581DEB4C1DA51D6754737488EB"
//#define APP_SECRET @"BFF82B79F3D244829854091C82259101"
//#define APP_PASSWORD @"03D42AD83AD84285B0653E90E064AF54"
//
//@interface SRIDCardViewController ()<UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate,SRIDCardReaderDelegate>
//@property (nonatomic,strong) CBCentralManager *cbCentralManager;
//@property (nonatomic,strong) NSMutableArray<CBPeripheral *> *deviceList;
//@property (nonatomic,weak) IBOutlet UITableView *deviceTableView;
//@property (nonatomic,weak) IBOutlet UILabel *txtRSState;
//@property (nonatomic,strong)  CBPeripheral *selectPeripheral;
//@property (nonatomic,weak) IBOutlet UITextField *txtPeripheralName;
//@property (nonatomic,strong) SRIDCardReader *srIDCardReader;
//@property (nonatomic,strong) RACDisposable *rac;
//@end
//
//@implementation SRIDCardViewController
//
//- (CBPeripheralState) selectPeripheralState{
//    return NULL != self.selectPeripheral ? self.selectPeripheral.state : CBPeripheralStateDisconnected;
//}
//- (SRIDCardReader *)srIDCardReader{
//    if (!_srIDCardReader) {
//        _srIDCardReader = [SRIDCardReader initDevice];
//        _srIDCardReader.delegate = self;
//        [_srIDCardReader setAppKey:APP_KEY];
//        [_srIDCardReader setAppSecret:APP_SECRET];
//        [_srIDCardReader setPassword:APP_PASSWORD];
//    }
//    return _srIDCardReader;
//}
//- (NSMutableArray<CBPeripheral *> *)deviceList{
//    if (!_deviceList) {
//        _deviceList = [[NSMutableArray alloc] init];
//    }
//    return _deviceList;
//}
//- (CBCentralManager *)cbCentralManager{
//    if (!_cbCentralManager) {
//        _cbCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//    }
//    return _cbCentralManager;
//}
//
//- (void)setSelectPeripheral:(CBPeripheral *)selectPeripheral{
//    if (NULL != _selectPeripheral) {
//        if (CBPeripheralStateConnecting == _selectPeripheral.state ||
//            CBPeripheralStateConnected == _selectPeripheral.state){
//            [self.cbCentralManager cancelPeripheralConnection:_selectPeripheral];
//        }
//    }
//    _selectPeripheral = selectPeripheral;
//    if (NULL != _selectPeripheral) {
//        self.txtPeripheralName.text = _selectPeripheral.name;
//        if (NULL != self.rac) {
//            [self.rac dispose];
//            self.rac = NULL;
//        }
////        @weakify(self);
//        __weak typeof(self) weakSelf = self;
//        self.rac = [RACObserve(_selectPeripheral, state) subscribeNext:^(id  _Nullable x) {
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            if (NULL != x && [x respondsToSelector:@selector(intValue)]) {
//                
//                switch ([x intValue]) {
//                    case CBPeripheralStateDisconnected:{
//                        [strongSelf.txtRSState performSelectorOnMainThread:@selector(setText:) withObject:@"未连接" waitUntilDone:false];
//                        break;
//                    }
//                    case CBPeripheralStateConnecting:{
//                        [strongSelf.txtRSState performSelectorOnMainThread:@selector(setText:) withObject:@"连接中" waitUntilDone:false];
//                        break;
//                    }
//                    case CBPeripheralStateConnected:{
//                        [strongSelf.txtRSState performSelectorOnMainThread:@selector(setText:) withObject:@"已连接" waitUntilDone:false];
//                        break;
//                    }
//                    case CBPeripheralStateDisconnecting:{
//                        [strongSelf.txtRSState performSelectorOnMainThread:@selector(setText:) withObject:@"断开中" waitUntilDone:false];
//                        break;
//                    }
//                    default:{
//                        [strongSelf.txtRSState performSelectorOnMainThread:@selector(setText:) withObject:@"未知" waitUntilDone:false];
//                        break;
//                    }
//                }
//            }
//            else {
//            }
//        }];
//    }
//    else {
//        self.txtPeripheralName.text = @"";
//    }
//}
//- (void) dealloc{
//    if (CBPeripheralStateConnecting == self.selectPeripheral.state || CBPeripheralStateConnected == self.selectPeripheral.state) {
//        [self.cbCentralManager cancelPeripheralConnection:self.selectPeripheral];
//    }
////    if (self.cbCentralManager.isScanning) {
////        [self.cbCentralManager stopScan];
////    }
//}
//
//- (IBAction) click_read:(id)sender{
//    [self performSelectorInBackground:@selector(readDICARBySelectDevice) withObject:NULL];
//}
//- (IBAction) click_scan:(id)sender{
//    if (@available(iOS 13.0, *)) {
//        if (CBManagerAuthorizationDenied == self.cbCentralManager.authorization) {
//                [self showAlert:@"蓝牙权限未开启" handler:NULL];
//        }
//    }
//    NSLog(@"self.cbCentralManager.st%lde：(long)%d",self.cbCentralManager.state);
//    if (CBManagerStatePoweredOff == self.cbCentralManager.state || CBManagerStateUnknown == self.cbCentralManager.state) {
//        [self showAlert:@"蓝牙未开启" handler:NULL];
//    }
//    if (!self.cbCentralManager.isScanning) {
//        [self.deviceList removeAllObjects];
//        self.selectPeripheral = NULL;
//        [self.cbCentralManager scanForPeripheralsWithServices:nil options:@{
//            CBCentralManagerScanOptionAllowDuplicatesKey : @YES
//        }];
//    }
//}
//
//- (void) readDICARBySelectDevice{
//    if (NULL != self.selectPeripheral) {
//        int connectState = -1;
//        if (!self.srIDCardReader.connectStatus) {
//            connectState = [self.srIDCardReader connectPeripheral:self.selectPeripheral withCBManager:self.cbCentralManager withTimeout:15];
//        }
//        else {
//            connectState = 0;
//        }
//        if (0 == connectState) {
//            [self.srIDCardReader readIDCardByJson:15];
//            //                [self showAlert:[NSString stringWithFormat:@"readIDCard:%@",readIDCard] handler:NULL];
//        }
//        else {
//            [self showAlert:[NSString stringWithFormat:@"连接失败：%d",connectState] handler:NULL];
//        }
//    }
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
////    self.cbCentralManager;
////    self.srIDCardReader;
//    // Do any additional setup after loading the view from its nib.
//}
//
//#pragma  mark -- CBCentralManagerDelegate
//- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
//    switch (central.state) {
//        case CBManagerStateUnknown:
//            break;
//        case CBManagerStateResetting:
//            break;
//        case  CBManagerStateUnsupported:
//            break;
//        case CBManagerStateUnauthorized:
//            break;
//        case CBManagerStatePoweredOff:
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
//    if(peripheraln.name == nil || [self.deviceList containsObject:peripheraln]){
//        return;
//    }
//    //
//    if (peripheraln.name.length != 0) {
//        [self.deviceList addObject:peripheraln];
//    }
//    else{
//    }
//    [self.deviceTableView reloadData];
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
//#pragma mark - UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.deviceList.count > 0 ? 1 : 0;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSInteger result = 0;
//    switch (section) {
//        case 0:
//            result = self.deviceList.count;
//            break;
//        default:
//            break;
//    }
//    return result;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SRIDCardViewControllerCell"];
//    }
//    NSInteger section = indexPath.section;
//    NSInteger row = indexPath.row;
//    switch (section) {
//        case 0:{
//            CBPeripheral *peripheral = self.deviceList[row];
//            cell.textLabel.text = peripheral.name;
//            break;
//        }
//        default:
//            break;
//    }
//    return cell;
//}
//#pragma mark - UITableViewDelegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger section = indexPath.section;
//    NSInteger row = indexPath.row;
//    switch (section) {
//        case 0:{
//            if (row < self.deviceList.count) {
//               self.selectPeripheral =  self.deviceList[row];
//            }
//            break;
//        }
//        default:
//            break;
//    }
//}
//
//- (int)connectPeripheral:(CBPeripheral *)bt withCBManager:(CBCentralManager *)cbmanager withTimeout:(int)timeout
//{
////    if (nil == bt || nil == cbmanager) {
////        return 1;
////    }
//    int ret = 1;
//    //= [srIDCard connectPeripheral:bt withCBManager:cbmanager withTimeout:timeout];
////    retBle = ret;
////    if (ret == 0) {
////
////    }else{
////        NSLog(@"设备连接失败");
////    }
//    return ret;
//}
//
//- (void)readerIDCardInfoSuccess:(void (^)(NSString * _Nonnull))successBlock
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self.srIDCardReader readIDCardByJson:15];
//        
//    });
//}
//
//- (void)SRsuccessBack:(CBPeripheral *)peripheral withData:(id)data{
//    
//}
//
//- (void)SRsuccessIdCardInfoAndPhotoBack:(CBPeripheral *)peripheral withData:(id)data
//{
//    
//}
//
///*
// 功能：返回读取结果的JSON字符串
// 参数：JSON字符串
// 返回值：无
// */
//- (void)idCardInfoJsonStr:(NSString *)jsonStr
//{
//    [self showAlert:[NSString stringWithFormat:@"读取成功：%@",jsonStr] handler:NULL];
//}
//
///*
// 功能：代理方法，返回身份证密文
// 参数：身份证密文
// 返回值：无
// */
//- (void)idResponSuccessBack:(NSData *)data
//{
//    
//}
//
//- (void)SRfailedBack:(CBPeripheral *)peripheral withError:(NSError *)error
//{
////    [self showAlert:[NSString stringWithFormat:@"%@%@",error.domain,error.code]; handler:NULL];
//    [self showAlertTitle:@"读取失败" message:[NSString stringWithFormat:@"%@(%ld)",error.domain,(long)error.code] handler:NULL];
////    [self showAlert:[NSString stringWithFormat:@"读取失败：%ld",(long)error.code] handler:NULL];
//    
//}
//
//@end
