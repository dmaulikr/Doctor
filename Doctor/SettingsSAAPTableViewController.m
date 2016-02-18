#import "SettingsSAAPTableViewController.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface SettingsSAAPTableViewController ()

@property (nonatomic, weak) IBOutlet UILabel *settingsNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *settingsCRMLabel;
@property (nonatomic, weak) IBOutlet UILabel *settingsContactLabel;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIImageView *settingsSAAPCameraImageView;

@end

@implementation SettingsSAAPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDoctorData];
    self.tableView.tableFooterView = [UIView new];
    self.settingsSAAPCameraImageView.layer.cornerRadius = self.settingsSAAPCameraImageView.frame.size.height/2;
    self.settingsSAAPCameraImageView.layer.masksToBounds = YES;
    CLLocationCoordinate2D teste = CLLocationCoordinate2DMake(-8.102625399999999, -34.885785699999985);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(teste, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
    
//    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//    annotation.coordinate = self.store.storeCoordinate;
//    // annotation.title = self.store.storeFantasyName;
//    // annotation.subtitle = self.store.storeAddress;
//    
//    [_mapView addAnnotation:annotation];

}

- (void) setupDoctorData{
    self.settingsNameLabel.text = self.doctor.doctorNameString;
    self.settingsCRMLabel.text = [NSString stringWithFormat:@"CRM: %@", self.doctor.doctorCRMString];
    self.settingsContactLabel.text = self.doctor.doctorContactString;
    if (self.doctor.doctorPhotoData){
        self.settingsSAAPCameraImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.settingsSAAPCameraImageView.image = [UIImage imageWithData:self.doctor.doctorPhotoData];
    }
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
//    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.store.storeCoordinate
//                                                   addressDictionary:nil];
//    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//    [mapItem setName:self.store.storeFantasyName];
//    [mapItem openInMapsWithLaunchOptions:nil];
}

@end
