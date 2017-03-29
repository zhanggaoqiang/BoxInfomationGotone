//
//  MapDetailViewController.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/11.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>


@interface MapDetailViewController : UIViewController<BMKMapViewDelegate,BMKRouteSearchDelegate>
{
      BMKMapView *_mapView;
    UIView *_layview;
  
    NSString *  _startAddrText;
    
    NSString* _wayPointAddrText;
    NSString* _endAddrText;
    BMKRouteSearch* _routesearch;
    NSString *startcity;
    
      
}



@property(nonatomic,strong)NSString *startCity;
@property(nonatomic,strong)NSString *endCity;

@property(nonatomic,strong)NSString *startDis;
@property(nonatomic,strong)NSString *endDis;

@end
