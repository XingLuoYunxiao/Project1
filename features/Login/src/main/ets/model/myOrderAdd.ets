@Observed
class myOrderAdd {
  // 属性定义
  order_id: number;
  spot_id: number;
  order_time: Date;
  order_status: string;
  total_amount: number;
  quantity: number;
  order_type: number;
  user_id: string;
  spotname: string;
  spot_img:string;
  spot_price:number;


  // 构造函数
  constructor(order_id: number = 0, spot_id: number = 0, order_time: Date = new Date(),
    order_status: string = "1", total_amount: number = 1.0, quantity: number = 0,
    order_type: number = 0, user_id: string = "0", spotname: string = '',spot_img:string='',
  spot_price:number=0) {
    this.order_id = order_id;
    this.spot_id = spot_id;
    this.order_time = order_time;
    this.order_status = order_status;
    this.total_amount = total_amount;
    this.quantity = quantity;
    this.order_type = order_type;
    this.user_id = user_id;
    this.spotname = spotname;
    this.spot_img=spot_img;
    this.spot_price=spot_price;
  }
}

export {myOrderAdd}
