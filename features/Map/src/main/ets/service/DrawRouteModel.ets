
import { map, mapCommon, navi } from '@kit.MapKit';
import Logger from 'utils/src/main/ets/utils/Logger';

export class DrawRouteModel {
  private index:number = 0;

  //绘制所有路径
  async drawRoutes(mapController: map.MapComponentController | undefined, routes: Array<navi.Route>) {
    for(; this.index < routes.length; this.index++){
      await this.drawRoute(mapController, routes[this.index].steps[0].roads);
      if( this.index === 0 && mapController){
        let start = routes[this.index].steps[0].startLocation;
        let pointAnnotationOptions: mapCommon.PointAnnotationParams = {
          // 定义点注释图标锚点
          position: {
            latitude: start.latitude,
            longitude: start.longitude
          },
          // 定义点注释名称与地图poi名称相同时，是否支持去重
          repeatable: false,
          // 定义点注释的碰撞规则
          collisionRule: mapCommon.CollisionRule.NAME,
          // 定义点注释的标题，数组长度最小为1，最大为3
          titles: [{
            // 定义标题内容
            content: '起点',
            // 定义标题字体颜色
            color: 0xFF000000,
            // 定义标题字体大小
            fontSize: 20,
            // 定义标题描边颜色
            strokeColor: 0xFFFFFFFF,
            // 定义标题描边宽度
            strokeWidth: 2,
          }
          ],
          // 定义点注释的显示属性，为true时，在被碰撞后仍能显示
          forceVisible: true,
          // 定义碰撞优先级，数值越大，优先级越低
          priority: 3,
          // 定义点注释展示的最小层级
          minZoom: 2,
          // 定义点注释展示的最大层级
          maxZoom: 22,
          // 定义点注释是否可见
          visible: true,
          // 定义点注释叠加层级属性
          zIndex: 10
        }
        await mapController.addPointAnnotation(pointAnnotationOptions);
      }
    }
  }

  //绘制两点之间的路径
  async drawRoute(mapController: map.MapComponentController | undefined, steps: Array<navi.RouteRoad>) {
    if (mapController === undefined) {
      Logger.info('Drawing failed');
      return;
    }
    let roads: Array<mapCommon.LatLng> = [];
    let start: mapCommon.LatLng = {
      latitude: steps[0].startLocation.latitude,
      longitude: steps[0].startLocation.longitude
    };

    let end: mapCommon.LatLng = {
      latitude: steps[steps.length - 1].endLocation.latitude,
      longitude: steps[steps.length - 1].endLocation.longitude
    };

    for (let index = 0; index < steps.length; index++) {
      for (let i = 0; i < steps[index].polyline.length; i++) {
        roads.push(steps[index].polyline[i]);
      }
    }

    let polylineOption: mapCommon.MapPolylineOptions = {
      points: roads,
      color: 0xFF089C57,
      jointType: mapCommon.JointType.ROUND,
      width: 24
    };
    if( this.index === 0){
      this.addMarker(mapController, start).then(async () => {
        this.addMarker(mapController, end).then(async () => {
          mapController.addPolyline(polylineOption).then(() => {
            Logger.info('Drawing success');
          });
        });
      });
    }else{
      this.addMarker(mapController, end).then(async () => {
        mapController.addPolyline(polylineOption).then(() => {
          Logger.info('Drawing success');
        });
      });
    }

  }

  async addMarker(mapController: map.MapComponentController, position: mapCommon.LatLng) {
    let pointAnnotationOptions: mapCommon.PointAnnotationParams = {
      // 定义点注释图标锚点
      position: {
        latitude: position.latitude,
        longitude: position.longitude
      },
      // 定义点注释名称与地图poi名称相同时，是否支持去重
      repeatable: false,
      // 定义点注释的碰撞规则
      collisionRule: mapCommon.CollisionRule.NAME,
      // 定义点注释的标题，数组长度最小为1，最大为3
      titles: [{
        // 定义标题内容
        content: `${this.index+1}`,
        // 定义标题字体颜色
        color: 0xFF000000,
        // 定义标题字体大小
        fontSize: 20,
        // 定义标题描边颜色
        strokeColor: 0xFFFFFFFF,
        // 定义标题描边宽度
        strokeWidth: 2,
      }
      ],
      // 定义点注释的显示属性，为true时，在被碰撞后仍能显示
      forceVisible: true,
      // 定义碰撞优先级，数值越大，优先级越低
      priority: 3,
      // 定义点注释展示的最小层级
      minZoom: 2,
      // 定义点注释展示的最大层级
      maxZoom: 22,
      // 定义点注释是否可见
      visible: true,
      // 定义点注释叠加层级属性
      zIndex: 10
    }
    await mapController.addPointAnnotation(pointAnnotationOptions);
    if( this.index === 0 ){
      let markerOptions: mapCommon.MarkerOptions = {
        position: position,
        rotation: 0,
        visible: true,
        zIndex: 0,
        alpha: 1,
        anchorU: 0.5,
        anchorV: 1,
        clickable: false,
        draggable: false,
        flat: false
      };
      await mapController.addMarker(markerOptions);
    }
  }
}