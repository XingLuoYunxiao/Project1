import { RouterModel } from '../model/RouterModel';
import Logger from './Logger';

export class RouterModule {
  static builderMap: Map<string, WrappedBuilder<[object]>> = new Map<string, WrappedBuilder<[object]>>();
  static routerMap: Map<string, NavPathStack> = new Map<string, NavPathStack>();

  // Registering a builder by name.
  public static registerBuilder(builderName: string, builder: WrappedBuilder<[object]>): void {
    RouterModule.builderMap.set(builderName, builder);
  }


  // Get builder by name.
  public static getBuilder(builderName: string): WrappedBuilder<[object]> {
    const builder = RouterModule.builderMap.get(builderName);
    if (!builder) {
      Logger.info('not found builder ' + builderName);
    }
    return builder as WrappedBuilder<[object]>;
  }

  // Registering a router by name.
  public static createRouter(routerName: string, router: NavPathStack): void {
    RouterModule.routerMap.set(routerName, router);
  }

  // Get router by name.
  public static getRouter(routerName: string): NavPathStack {
    return RouterModule.routerMap.get(routerName) as NavPathStack;
  }


  // Jumping to a Specified Page by Obtaining the Page Stack.
  public static async push(router: RouterModel): Promise<void> {
    const harName = router.builderName.split('_')[0];
    // Dynamically import the page to be redirected to.
    await import(harName).then((ns: ESObject): Promise<void> => ns.harInit(router.builderName));
    RouterModule.getRouter(router.routerName).pushPath({ name: router.builderName, param: router.param });
  }

  // Obtain the page stack and pop it.
  public static pop(routerName: string): void {
    // Find the corresponding route stack for pop.
    RouterModule.getRouter(routerName).pop();
  }

  // Get the page stack and clear it.
  public static clear(routerName: string): void {
    // Find the corresponding route stack for pop.
    RouterModule.getRouter(routerName).clear();
  }

  // Directly jump to the specified route.
  public static popToName(routerName: string, builderName: string): void {
    RouterModule.getRouter(routerName).popToName(builderName);
  }

  public static async replacePath(routerName: string, builderName: string, params: object): Promise<void> {
    const harName = builderName.split('_')[0];
    await import(harName).then((ns: ESObject): Promise<void> => ns.harInit(builderName));
    RouterModule.getRouter(routerName).replacePathByName(builderName, params);
  }
}
