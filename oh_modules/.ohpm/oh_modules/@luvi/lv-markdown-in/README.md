# <center>lv-markdown-in</center>

### <center>V2.0.9(API11及以上)</center>

---

### 🍃 使用效果演示

<img src="https://qxj.api.eeeo.cc:6655/ruoyi-admin/profile/publicImages/lvmd1.jpg" width="266"/>
<img src="https://qxj.api.eeeo.cc:6655/ruoyi-admin/profile/publicImages/lvmd2.jpg" width="266"/>
<img src="https://qxj.api.eeeo.cc:6655/ruoyi-admin/profile/publicImages/lvmd3.jpg" width="266"/>

### 📚 简介

鸿蒙原生Markdown解析预览库，可在OpenHarmony、HarmonyOS系统运行，`兼容api9（1.x.x版本）、api10及以上（2.x.x版本），支持3种内容加载模式（纯文本、资源文件、沙箱文件）`
，[支持html常用标签解析](https://ohpm.openharmony.cn/#/cn/detail/@luvi%2Fhtml2md)，致力于更便捷的OpenHarmony设备的Markdown内容解析。

### 🎁 lv-markdown-in 目前支持

| 基本语法                                                                | 拓展语法                                                                    | 
|---------------------------------------------------------------------|-------------------------------------------------------------------------|
| [标题](https://markdown.com.cn/basic-syntax/headings.html)            | [表格](https://markdown.com.cn/extended-syntax/tables.html)               |
| [段落](https://markdown.com.cn/basic-syntax/paragraphs.html)          | [代码块](https://markdown.com.cn/extended-syntax/fenced-code-blocks.html)  |
| [换行](https://markdown.com.cn/basic-syntax/line-breaks.html)         | [脚注](https://markdown.com.cn/extended-syntax/footnotes.html)            |
| [强调（粗体、斜体、粗斜体）](https://markdown.com.cn/basic-syntax/emphasis.html) | [任务列表](https://markdown.com.cn/extended-syntax/task-lists.html)         |
| [引用块](https://markdown.com.cn/basic-syntax/blockquotes.html)        | [删除线](https://markdown.com.cn/extended-syntax/strikethrough.html)       | 
| [列表](https://markdown.com.cn/basic-syntax/lists.html)               | [支持html常用标签解析](https://ohpm.openharmony.cn/#/cn/detail/@luvi%2Fhtml2md) | 
| [代码](https://markdown.com.cn/basic-syntax/code.html)                |                                                                         | 
| [分割线](https://markdown.com.cn/basic-syntax/horizontal-rules.html)   |                                                                         |
| [链接](https://markdown.com.cn/basic-syntax/links.html)               |                                                                         | 
| [图片](https://markdown.com.cn/basic-syntax/images.html)              |                                                                         |

### 🔥 版本说明【重要】

> ***1.x.x*** 版本系列兼容 `API9`

> ***2.x.x - 2.0.2*** 版本系列兼容 `API10及以上`

> ***2.0.3*** 及以上版本系列兼容 `API11及以上`

### 🍺 lv-markdown-in 安装
---
1.运行命令

``` shell
ohpm install @luvi/lv-markdown-in
```

2.在项目中引入插件

``` javascript
import { lvMarkdownIn } from @luvi/lv-markdown-in
```

3.在代码中使用

``` javascript
lvMarkdownIn({ text: content.toString() }) // content为文本内容
```

### 🍊 3种内容加载模式（纯文本、资源文件、沙箱文件）

#### 1.纯文本模式（text）

---

``` javascript
lvMarkdownIn({
    text: content.toString(), // content为文本内容
    loadMode: "text", // 默认text可省略
    loadCallBack: { // loadCallBack回调可省略
      success(r: LMICallBack) {
        console.log("luvi-markdown-in > " + r.code, r.message)
      },
      fail(r: LMICallBack) {
        console.error("luvi-markdown-in > " + r.code, r.message)
      }
    }
})
```

#### 2.资源文件模式（rawfile）

---
使用资源文件模式，`需要将 loadMode 字段设置为 rawfile`，rawfilePath 需要填写模块中 rawfile
目录的文件路径，同时需要传递应用上下文context，loadCallBack 为可选参数，用于资源加载时的回调检查。

``` javascript
lvMarkdownIn({
    context: getContext(),  // 资源文件模式必填参数
    loadMode: "rawfile",
    rawfilePath: "t/text.md",
    loadCallBack: {
      success(r: LMICallBack) {
        console.log("luvi-markdown-in > " + r.code, r.message)
      },
      fail(r: LMICallBack) {
        console.error("luvi-markdown-in > " + r.code, r.message)
      }
    }
})
```

#### 3.沙箱文件模式（sandbox）

---
使用沙箱文件模式，`需要将 loadMode 字段设置为 sandbox`，loadCallBack 为可选参数，用于资源加载时的回调检查。

``` javascript
lvMarkdownIn({
    loadMode: "sandbox",
    sandboxPath: getContext().getApplicationContext().filesDir + "/t2/text.md",
    loadCallBack: {
      success(r: LMICallBack) {
        console.log("luvi-markdown-in > " + r.code, r.message)
      },
      fail(r: LMICallBack) {
        console.error("luvi-markdown-in > " + r.code, r.message)
      }
    }
})
```

### 🍊 超链接、图片点击拦截，自定义控制跳转行为

---

需要注意的是，使用拦截行为后，`return false`才可拦截正常拦截库中默认打开行为，`return true`则不拦截，但会进入该逻辑。

``` javascript
// 导入 mdRegister
import { mdRegister } from '@luvi/lv-markdown-in'

// 注册超链接点击回调、return false 则表示拦截，自行处理超链接跳转逻辑
mdRegister.HandleHyperlink = (url: string) => {
    console.log("拦截跳转 > " + url)
    return false
}

// 注册图像点击回调、return false 则表示拦截，自行处理图像展示逻辑
mdRegister.HandleImage = (url: string) => {
    console.log("拦截打开图像 > " + url)
    return false
}
```

### 🍊 动态样式改变

---

在页面加载完成后动态改变样式，以 `lvText` 字体样式为例，在自定义组件中需要使用 `@State` 装饰 `lvText`，类型为 `LvText`
，后续使用新属性修改样式即可，示例代码如下。

``` javascript
// 导入 lvTitle
import { lvTitle, LvText } from '@luvi/lv-markdown-in'

// @State装饰 lvText
@State newText: LvText = lvText

// 动态改变字体颜色
Button("改变lvText.setTextColor").onClick(() => {
    this.newText.setTextColor("blue")
})
```

### 📦 自定义样式

#### 1.标题样式（lvTitle）

---

``` javascript
// 导入 lvTitle
import { lvTitle } from '@luvi/lv-markdown-in'
// 用法
lvTitle.setLevel1Title(50)            // 设置一级标题字号50
lvTitle.setLevelTitleColor("blue")    // 设置标题字体颜色为蓝色
```

| 方法                   | 说明         | 参数                         |
|----------------------|------------|----------------------------|
| setLevel1Title()     | 设置 1 级标题字号 | number / string 默认：32      |
| setLevel2Title()     | 设置 2 级标题字号 | number / string 默认：29      |
| setLevel3Title()     | 设置 3 级标题字号 | number / string 默认：26      |
| setLevel4Title()     | 设置 4 级标题字号 | number / string 默认：23      |
| setLevel5Title()     | 设置 5 级标题字号 | number / string 默认：20      |
| setLevel6Title()     | 设置 6 级标题字号 | number / string 默认：17      |
| setLevelTitleColor() | 	设置标题字体颜色  | string        默认："#303133" |

#### 2.文字样式（lvText）
---

``` javascript
// 导入 lvText
import { lvText } from '@luvi/lv-markdown-in'
// 用法
lvText.setTextSize(20)                   // 设置文本字号20
lvText.setTextColor("red")               // 设置文本颜色为红色
lvText.setTextMarkBackground("#000")     // 设置标记文本的背景颜色为黑色
lvText.setTextLineHeight("25")           // 设置标记文本的行高
```

| 方法                      | 说明          | 参数                           |
|-------------------------|-------------|------------------------------|
| setTextSize()           | 设置文本字号	     | number / string 默认：15        |
| setTextColor()          | 设置文本颜色      | string        默认："#303133"   |
| setTextMarkBackground() | 设置标记文本的背景颜色 | string        默认："#7cff8321" |
| setTextLineHeight()     | 设置标记文本的行高   | string        默认："24"        |

#### 3.超链接样式（lvLink）
---

``` javascript
// 导入 lvLink
import { lvLink } from '@luvi/lv-markdown-in'
// 用法
lvLink.setTextSize(20)            // 设置超链接文本字号20
lvLink.setTextColor("red")        // 设置超链接文本颜色为红色
lvLink.setTextUnderline(true)     // 设置超链接下划线
```

| 方法                 | 说明         | 参数                         |
|--------------------|------------|----------------------------|
| setTextSize()      | 设置超链接文本字号	 | number / string 默认：15      |
| setTextColor()     | 设置超链接文本颜色  | string        默认："#3A8AEB" |
| setTextUnderline() | 设置超链接下划线   | boolean    默认：false        |

#### 4.图片样式（lvImage）
---
需要注意的是：若在md文本内容中未单独设置图片宽高，将采用默认全局宽高，可通过 setImgWidth() 与 setImgHeight()
进行设置。若强制开启图片全局宽高将会覆盖所有图片的宽高，即使在md文本内容中已设置图片宽高，可通过 setConfGloable() 进行设置

``` javascript
// 导入 lvImage
import { lvImage } from '@luvi/lv-markdown-in'
// 用法
lvImage.setImgWidth("70%")         // 设置图片宽度为70%
lvImage.setImgHeight(null)         // 设置图片高度为null
lvImage.setConfGlobal(true)        // 强制开启图片全局宽高
```

| 方法               | 说明       | 参数                       |
|------------------|----------|--------------------------|
| setImageWidth()  | 设置图片宽度	  | number / string 默认："60%" |
| setImageHeight() | 设置图片高度   | string        默认：null    |
| setConfGlobal()  | 强制开启全局宽高 | boolean    默认：false      |

#### 5.代码块（lvCode）
---
提供 `暗夜` 与 `明亮` 双主题，同时可设置索引列的展示与隐藏。

``` javascript
// 导入 lvCode
import { lvCode } from '@luvi/lv-markdown-in'
// 用法
lvCode.setTheme("dark")         // 设置代码块主题为暗夜
lvCode.setIndexState(true)      // 展示代码块索引列
```

| 方法              | 说明          | 参数                                         |
|-----------------|-------------|--------------------------------------------|
| setTheme()      | 设置代码块主题     | 	string: "dark" / "light"        默认："dark" |
| setIndexState() | 设置索引列的展示与隐藏 | 	boolean        默认："false"                 |

#### 6.引用块样式（lvQuote）
---
需要注意的是引用块中字体大小与字体颜色，请使用 `lvText` 进行设置

``` javascript
// 导入 lvQuote
import { lvQuote } from '@luvi/lv-markdown-in'
// 用法
lvQuote.setBackgroundColor("rgba(234, 239, 255, 0.62)")      // 设置引用块背景颜色为淡粉色
lvQuote.setBorderColor("red")                                // 设置引用块左边颜色为红色
```

| 方法                   | 说明         | 参数                                            |
|----------------------|------------|-----------------------------------------------|
| setBackgroundColor() | 设置引用块背景颜色  | 	string        默认："rgba(234, 239, 255, 0.62)" |
| setBorderColor()     | 	设置引用块左边颜色 | 	string        默认："#409EFF"                   |

#### 7.其他样式

---

需要注意的是列表、表格、任务列表、脚注、删除线、引用块等语法中字体大小与字体颜色，请使用 `lvText` 进行设置

### 🍺 CSDN同步文章

详细用法请参考CSDN文章：[lv-markdown-in for CSDN](https://blog.csdn.net/weixin_44640245/article/details/134630747)

### 🍺 其他

有关Markdown的更多信息，请参阅Markdown官方教程 [Markdown](https://markdown.com.cn/)

使用过程中发现任何问题都可以提 [Issues](https://gitee.com/luvi/lv-markdown-in/issues)。

### 🍺 版权声明

本项目采用 MIT 开源协议，允许商用，修改，再分发。再分发时请注明原作者及原仓库地址。