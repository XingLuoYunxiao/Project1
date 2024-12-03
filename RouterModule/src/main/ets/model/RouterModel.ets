import { RouterModule } from '../utils/RouterModule';

// Routing information.
export class RouterModel {
  // Route page alias, in the form：${bundleName}_${pageName}.
  builderName: string = "";
  // Routing Stack Name.
  routerName: string = "";
  // Parameters that need to be transferred to the page.
  param?: object = new Object();
}

// Create routing information and put it into the routing stack table.
export function buildRouterModel(routerName: string, builderName: string, param?: object) {
  console.log('buildRouterModel')
  let router: RouterModel = new RouterModel();
  router.builderName = builderName;
  router.routerName = routerName;
  router.param = param;
  RouterModule.push(router);
  console.log('buildRouterModel2')
}


