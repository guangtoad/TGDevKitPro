//
//  BaiduMapViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/06/09.
//

#import "BaiduMapViewController.h"
//#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface BaiduMapViewController ()
//<BMKMapViewDelegate>

//@property (nonatomic,strong) BMKMapView *baiduMapView;
@end

@implementation BaiduMapViewController

//- (BMKMapView *)baiduMapView{
//    if (!_baiduMapView) {
//        _baiduMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(15, 20, CGRectGetWidth([[UIScreen mainScreen] bounds]) - 15 * 2.0, 152)];
//        _baiduMapView.delegate = self;
//        [_baiduMapView setUserInteractionEnabled:false];
//    }
//    return _baiduMapView;
//}
//
//- (void) viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.baiduMapView viewWillAppear];
//    self.baiduMapView.delegate = self;
//    CLLocationCoordinate2D coordinate2D;
//    coordinate2D.latitude = 41.835441;
//    coordinate2D.longitude = 123.429440;
//    [self.baiduMapView setCenterCoordinate:coordinate2D animated:true];
//}
//
//- (void) viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self.baiduMapView viewWillDisappear];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self.view addSubview:self.baiduMapView];
//}
//
//- (void) viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//}
//
//- (void) willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
//    [coordinator animateAlongsideTransition:NULL completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        [self.baiduMapView setFrame:self.view.bounds];
//    }];
//}
////- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
////    NSLog(@"%s",__FUNCTION__);
////}
//
//- (void)mapViewDidRenderValidData:(BMKMapView *)mapView withError:(NSError *)error{
//    NSLog(@"%sError:%@",__FUNCTION__,error);
//}
//
///// 地图初始化完毕时会调用此接口
///// @param mapView 地图View
//- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
//    NSLog(@"%s :%@",__FUNCTION__,mapView);
//}
//
//- (void)mapViewDidFinishRendering:(BMKMapView *)mapView{
//    NSLog(@"%s :%@",__FUNCTION__,mapView);
//}

@end
