




#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "CalloutMapAnnotation.h"
#import "BasicMapAnnotation.h"

@protocol MapViewControllerDidSelectDelegate; 
@interface MapViewController : UIViewController<MKMapViewDelegate>
{
    MKMapView *_mapView;
}
@property (nonatomic, assign) id<MapViewControllerDidSelectDelegate> delegate;
@property(nonatomic,retain)IBOutlet MKMapView *mapView;

//@property(nonatomic,assign)id<MapViewControllerDidSelectDelegate> delegate;

- (void)resetAnnitations:(NSArray *)data;
- (NSString *)returnTheCityName;
- (void)putAddress:(NSDictionary *)cityNameDic andCityName:(NSString *)cityName;
@end

@protocol MapViewControllerDidSelectDelegate <NSObject>

@optional
- (void)customMKMapViewDidSelectedWithInfo:(id)info;

@end