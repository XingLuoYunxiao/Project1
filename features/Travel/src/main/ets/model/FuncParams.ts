type OperationType = 'query' | 'add' | 'update' | 'delete' | 'count';

interface Filter {
  [key: string]: any;
}

interface OrderBy {
  field: string;
  type: 'asc' | 'desc'
}

export interface Params {
  type: OperationType;
  pageNum?: number;
  filter?: Filter[]; // 可选属性，因为不是所有操作都需要过滤器
  orderBy?: OrderBy; // 可选属性，因为不是所有操作都需要排序
  limit?: number; // 可选属性，用于限制返回的结果数量
  offset?: number; // 可选属性，用于分页时跳过的结果数量
  document?: any[]; // 可选属性，对象数组，具体类型取决于的定义
  updateData?: { [key: string]: any }; // 可选属性，用于更新操作的数据
}