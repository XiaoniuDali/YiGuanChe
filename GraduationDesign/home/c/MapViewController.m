//
//  MapViewController.m
//  
//
//  Created by Jian-Ye on 12-10-16.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "MapViewController.h"
#import "CallOutAnnotationVifew.h"
#import "JingDianMapCell.h"
#define span 40000

@interface MapViewController ()
{
    NSMutableArray *_annotationList;
    
    CalloutMapAnnotation *_calloutAnnotation;
	CalloutMapAnnotation *_previousdAnnotation;
    NSString *_cityName;
    NSMutableArray *_locationMuArr;
    NSDictionary *_carAgencyDic;
    
}
@property (nonatomic,strong)CLLocationManager *locationManager;
-(void)setAnnotionsWithList:(NSArray *)list;

@end

@implementation MapViewController

@synthesize mapView=_mapView;

@synthesize delegate;

//- (void)dealloc
//{
//    [_mapView release];
//    [_annotationList release];
//    [super dealloc];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLocation];
    _annotationList = [[NSMutableArray alloc] init];
}
// 初始化定位
- (void)initLocation{
    _locationMuArr = [NSMutableArray array];
    
    CLLocationManager *locationManager=[[CLLocationManager alloc]init];
    
    self.locationManager=locationManager;
    
    //请求授权
    [locationManager requestWhenInUseAuthorization];
    
    /*
     MKUserTrackingModeNone  不进行用户位置跟踪
     MKUserTrackingModeFollow  跟踪用户的位置变化
     MKUserTrackingModeFollowWithHeading  跟踪用户位置和方向变化
     */
    //设置用户的跟踪模式
    self.mapView.userTrackingMode=MKUserTrackingModeFollow;
    /*
     MKMapTypeStandard  标准地图
     MKMapTypeSatellite    卫星地图
     MKMapTypeHybrid      鸟瞰地图
     MKMapTypeSatelliteFlyover
     MKMapTypeHybridFlyover
     */
    self.mapView.mapType=MKMapTypeStandard;
    //实时显示交通路况
    self.mapView.showsTraffic=YES;
}
//跟踪到用户位置时会调用该方法
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //创建编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //反地理编码
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error!=nil || placemarks.count==0) {
            return ;
        }
        //获取地标
        CLPlacemark *placemark=[placemarks firstObject];
        //设置标题
        userLocation.title=placemark.locality;
        //设置子标题
        userLocation.subtitle=placemark.name;
        
        _cityName = placemark.locality;
    }];
    
}
// 反地理编码返回城市名称
- (NSString *)returnTheCityName{
    return _cityName;
}
// 地理编码
- (void)putAddress:(NSDictionary *)cityNameDic andCityName:(NSString *)cityName{
    
    _carAgencyDic = cityNameDic;
    
    if (cityName == nil) {
        
        cityName = [cityNameDic[@"addressDetail"] substringFromIndex:3];
    }

    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    [geocoder geocodeAddressString:cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        // CLPlacemark : 地标
        // location : 位置对象
        // addressDictionary : 地址字典
        // name : 地址详情
        // locality : 城市
        
        if(error == nil)
        {
            CLPlacemark *pl = [placemarks firstObject];
            CLLocation *lo = pl.location;

            NSDictionary *locationDic=[NSDictionary dictionaryWithObjectsAndKeys:@(lo.coordinate.latitude),@"latitude",@(lo.coordinate.longitude),@"longitude",nil];
            
            [_locationMuArr addObject:locationDic];
            
            [self resetAnnitations:_locationMuArr];
            
            
            NSLog(@"%f",lo.coordinate.latitude);
            NSLog(@"%f",lo.coordinate.longitude);
        }else
        {
            NSLog(@"错误");
        }
    }];
}
// 添加大头针
-(void)setAnnotionsWithList:(NSArray *)list
{
    for (NSDictionary *dic in list) {
        
        CLLocationDegrees latitude=[[dic objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude=[[dic objectForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
        
        MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location,span ,span );
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
        [_mapView setRegion:adjustedRegion animated:YES];
        
        BasicMapAnnotation *  annotation=[[BasicMapAnnotation alloc] initWithLatitude:latitude andLongitude:longitude];
        [_mapView   addAnnotation:annotation];
    }
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        if (_calloutAnnotation) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
        _calloutAnnotation = [[CalloutMapAnnotation alloc]
                               initWithLatitude:view.annotation.coordinate.latitude
                               andLongitude:view.annotation.coordinate.longitude];
        [mapView addAnnotation:_calloutAnnotation];
        
        [mapView setCenterCoordinate:_calloutAnnotation.coordinate animated:YES];
	}
    else{
        if([delegate respondsToSelector:@selector(customMKMapViewDidSelectedWithInfo:)]){
            [delegate customMKMapViewDidSelectedWithInfo:@"点击至之后你要在这干点啥"];
        }
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (_calloutAnnotation&& ![view isKindOfClass:[CallOutAnnotationVifew class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[CalloutMapAnnotation class]]) {

        CallOutAnnotationVifew *annotationView = (CallOutAnnotationVifew *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
        
        if (!annotationView) {
            annotationView = [[CallOutAnnotationVifew alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
            JingDianMapCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"JingDianMapCell" owner:self options:nil] objectAtIndex:0];
            cell.agencyDic = _carAgencyDic;
            [cell setCarAgency:_carAgencyDic];
            [annotationView.contentView addSubview:cell];  
        }
        return annotationView;
	} else if ([annotation isKindOfClass:[BasicMapAnnotation class]]) {
        
         MKAnnotationView *annotationView =[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomAnnotation"];
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:@"pin.png"];
            
        }
		
		return annotationView;
    }
	return nil;
}
- (void)resetAnnitations:(NSArray *)data
{
    
    [_annotationList removeAllObjects];
    [_annotationList addObjectsFromArray:data];
    [self setAnnotionsWithList:_annotationList];
    
}
@end
