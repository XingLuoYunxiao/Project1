export interface ResponseData<T>{
  /**
   *  current page number
   */
  currentPage: number;

  /**
   *  Number of resource data on each page
   */
  pageSize: number;

  /**
   *  Total page number
   */
  pageCount: number;

  /**
   *  Total resource data number
   */
  total: number;

  /**
   *  Is there a next page
   */
  hasNext: boolean;

  /**
   *  Resource List
   */
  resourceList: T[];
}