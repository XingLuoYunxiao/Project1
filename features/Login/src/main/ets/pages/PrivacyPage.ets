import { BuilderNameConstants, RouterModule } from "routermodule"
import Constants from "../common/constants/Constants"

@Component
export struct PrivacyPage {
  @Consume('appPathStack') appPathStack: NavPathStack

  build() {
    NavDestination(){
      Row(){
        Image($r('app.media.ic_back')).width($r('app.float.md_topic_width')).onClick(()=>{
          this.appPathStack.pop()
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .height(Constants.TOP_HEIGHT_PAGE)
      Scroll() {
        Text('  感谢您使用虚拟旅游导览应用（以下简称“本应用”）。本应用致力于为您提供便捷、高效的在线旅游导览服务。为了保护您的隐私权益，我们根据《中华人民共和国网络安全法》、《中华人民共和国个人信息保护法》等相关法律法规，制定本隐私策略。本隐私策略详细说明了本应用在收集、使用、存储、共享和保护您的个人信息方面的具体做法。\n' +
          '\n' +
          '一、个人信息收集范围\n' +
          '\n' +
          '基本信息类：包括您的姓名、性别、年龄、手机号码、邮箱等。\n' +
          '账户类：包括账号、密码、头像、昵称等。\n' +
          '设备信息类：包括设备型号、操作系统、唯一设备识别码等。\n' +
          '位置信息类：包括实时位置、历史位置等。\n' +
          '使用记录类：包括浏览记录、搜索记录、点击记录等。\n' +
          '二、个人信息使用目的\n' +
          '\n' +
          '提供旅游导览服务：根据您的需求，为您推荐合适的旅游路线、景点介绍、语音讲解等。\n' +
          '客户服务：为您解答疑问、提供帮助，以及进行满意度调查等。\n' +
          '优化应用体验：根据您的使用习惯和反馈，不断优化应用功能和界面设计。\n' +
          '安全保障：确保应用正常运行，预防网络攻击、诈骗等安全风险。\n' +
          '三、个人信息存储期限\n' +
          '\n' +
          '基本信息类：在您使用本应用期间及注销账号后一定期限内存储。\n' +
          '账户类：在您使用本应用期间及注销账号后一定期限内存储。\n' +
          '设备信息类：在您使用本应用期间及注销账号后一定期限内存储。\n' +
          '位置信息类：在您使用本应用期间及注销账号后一定期限内存储。\n' +
          '使用记录类：在您使用本应用期间及注销账号后一定期限内存储。\n' +
          '四、个人信息共享与披露\n' +
          '\n' +
          '在获取您的明确同意的情况下，本应用可能会将您的个人信息共享给合作伙伴，以提供更优质的服务。\n' +
          '根据法律法规规定，或政府主管部门、司法机关的要求，本应用可能会披露您的个人信息。\n' +
          '为维护本应用和其他用户的合法权益，如发现您存在违法、违规行为，本应用可能会披露您的相关信息。\n' +
          '六、个人信息保护措施\n' +
          '\n' +
          '本应用采取加密技术、安全审计等措施，确保您的个人信息安全。\n' +
          '本应用严格限制内部员工访问、使用您的个人信息，防止泄露风险。\n' +
          '本应用定期进行安全检查，发现并及时修复潜在的安全漏洞。\n' +
          '七、用户权利\n' +
          '\n' +
          '您有权查询、修改、删除您的个人信息。\n' +
          '您有权注销账号，本应用将停止收集和使用您的个人信息。\n' +
          '您有权撤回同意本隐私策略的授权，但可能会影响您使用本应用的部分功能。\n' +
          '八、隐私策略更新\n' +
          '\n' +
          '本应用可能会根据业务发展、法律法规变化等因素，对本隐私策略进行更新。更新后的隐私策略将在本应用中公布，请您及时关注。\n' +
          '\n' +
          '九、联系我们\n' +
          '\n' +
          '如果您对本隐私策略有任何疑问或建议，请通过以下方式与我们联系：\n' +
          '\n' +
          '客服邮箱：[example@example.com] 客服电话：[400-xxx-xxxx]\n' +
          '\n' +
          '本应用将竭诚为您解答和处理相关问题。感谢您的信任与支持！\n' +
          '\n')
      }
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .hideTitleBar(true)
    .padding({left:20,right:20})
    .margin({top:Constants.HEADER_HEIGHT_PAGE,bottom:30})
  }
}
@Builder
export function PrivacyPageBuilder() {
  PrivacyPage()
}

const builderName = BuilderNameConstants.LOGIN_PRIVACYPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(PrivacyPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
