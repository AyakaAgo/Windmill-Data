{
    {
        version="2.0.7.2 beta",
        major=[[1.修正了“小记事”无法撤销重做的问题
2.调整了“小记事”的笔记背景颜色选取功能，可以选取预设颜色或随机
3.可以在“小记事”编辑页更改笔记的类别了
4.“小记事”可以选择以“只读模式”打开编辑页（“只读模式”下可以识别文本中的网页链接及电话号码内容）
5.部分体验优化]]
    },
    {
        version="2.0.7.1 beta",
        major=[[1.修正了“浏览器”无法跳转外部应用的问题并调整了提示逻辑。现在，外部跳转功能仅为已安装支持的应用做出跳转提示。
2.修正了在“设置”下拉刷新崩溃的问题
3.现在，在创建快捷方式后会额外显示一条提示。如果无法在桌面上找到快捷方式，可能需要前往系统设置页面手动授权。（即便已禁止了 Windmill 的“创建快捷方式”权限，系统可能仍会以“以允许”的状态返回给应用程序）
4.将部分图片资源移动到了云端，压缩了本地图片资源的大小
5.修正了在未安装QQ时使用跳转时错误的问题
6.修正了无法查看“Lua 基础知识”的问题
7.调整了“引导页”的界面与页面顺序
8.修正了在关闭了“应用內更新检测”后“关于页面”可能会崩溃的问题
9.现在，可以选择“浏览器”是否“复用活动页面”了
10.[测试功能] 主页面“工具”页的“小记事”（原“记事本”）现可新建笔记。（记忆卡片、待办事项以及云同步功能将在今年晚些时候推出）
11.修正了“安全性”设置的事件错误
12.修正了“浏览器”的“管理浏览数据”的错误
13.修正了首次打开“感谢名单与捐赠”页面在无网络环境下的状态显示问题，添加了文件校验。
14.[实验性功能] “应用”详情页新增32/64位兼容包识别
15.修正了在反复启动关闭“Java Api”页面后修改“显示系统加载类”后不会重启页面的问题
16.修正了在“浏览器”页面新建下载后退出页面不会提示下载完成状态的问题
17.修正了“应用”详情页“活动页“问题
18.调整了“设备信息”的“传感器”详情页的数值更新间隔，更新时间只在断开连接后才会显示
19.主页面“更多”页新增“内容+”，可以在这里使用 Windmill 筛选的来自第三方提供的服务
20.修正了在使用期间出现“Out of Java object”错误的问题
21.优化了“显示”设置更改，修正了反复修改设置不会更新页面的问题
22.现在在“浏览器”发起下载时可以修改文件名和路径了（受系统限制，部分系统版本不支持自由修改路径）
23.修正了部分文本错误
24.修正了在部分情况下程序崩溃的问题
25.将目标平台版本号提升至 31（Android 12）（初步）
26.修正了在 Android 12 下无法创建快捷方式的问题
27.再次修正了“图片转链接”刷新小概率崩溃的问题
28.优化了“Java Api”详情页字段加载方式，现在可以不显示非公共的方法与字段
29.修正了在某些情况下“轻调试”一直提示无法打开文件的问题
30.现在不会在内部储存下创建“androlua”文件夹了（缓存）
31.修正了“浏览器”在关闭了“地址栏色彩模式”后的界面显示问题
32.“关于”页新增“已知问题”，可以查看软件错误修正情况
33.现在主页面“工具”中未完成功能不会显示了
34.修正了广播接收器注册问题（再版）]]
    },
    {
        version="2.0.7 beta",
        major=[[1.[实验性功能] 支持“自适应图标”（Adaptive Icon）特性了（Android 8+）
2.“应用快捷方式”（App Shortcuts）仅在同意了使用条款才会添加到桌面图标，不同意时将会被清除
3.调整了更改了“主题背景”或“主题颜色”后页面的重启方式
4. 修正了滑动列表时概率崩溃的问题
5.修正了在安装后未启动来初始化文件便通过“深层链接”（Deep Links）启动 Windmill 出现的文件缺失错误
6.现在，“主页”设置中的“跳过启动画面”默认是开启的
7.在“类检查器”（Java Api）设置开启/关闭“显示系统加载类”后会自动重启 Java Api 列表页面了
8.为“代码调试”补回了“文件信息”功能
9.新增了“探索”设置
10.修正了在“引导页”拒绝了使用条款后再接受，“应用快捷方式”不会重新添加的问题
11.修正了“浏览器”页面在启动到前台时网页可能会白屏的问题
12.修正了“代码调试”无法跳转到调试页的问题
13.修正了在“代码调试”打开大型文本后无法跳转到“导入分析”的问题（不建议编辑大型文本，因为它们在使用“导入分析”时可能会出现问题）（现在，除了 lua 文件与 aly 文件，其他格式的文件将不提供“导入分析”）
14.修正了“应用”的“快捷方式高级配置”权限申请跳转问题
15.“浏览器”的“网页恢复”提示现在改为浮条样式了
16.调整了“浏览器”的退出逻辑
17.修正了“代码调试”在保存失败后无法跳转到新建文件来保存的问题
18.修正了“代码调试”在选择文字时没有光标的问题
19.修正了“浏览器”在达标签页数量限制后仍可创建标签页的问题
20.修正了跳转发送邮件没有邮箱地址的问题
21.修正了“图片转链接”将图片保存到本地后点按通知栏中的下载通知会错误地以安装包文件打开的问题
22.[实验性功能] “应用內更新检测”新增“应用內下载”，更新更方便了
23.修正了使用“加载对话框”页面无法正常打开的问题
24.统一了“代码调试”文件保存方式并完善了内容提示
25.优化了“代码调试”的“放大镜”显示效果，现在“放大镜”组件只会在缩放较小时显示，并且会随缩放调整放大比率
26.优化了“引导页”的逻辑
27.修正了“应用”详情页的“快捷方式高级配置”页面的预览效果在系统不支持设置壁纸或未设置壁纸时会错误地反复请求“读取储存空间”权限的问题
28.修正了页面路径设置错误的问题
29.修正了“设备信息”的“传感器”页面（以下简称“传感器”页面）在未取得授权后不会再次询问的问题
30.“传感器”页面在连接传感器并接收数值变更后可以查看到数值更新时间了
31.修正了在 Android 11 以下在“浏览器”页面返回会直接回到主页面的问题
32.现在可以查看包含其他用户的最近签到记录了]],
    },
    {
        version="2.0.6.3 beta",
        major=[[1.在“高级”设置调整“开关控件 TrackDrawable”后会自动重启页面了
2.修正了资源缺失问题
3.调整了“Http 调试”的链接输入，现在缺省的 http 协议会自动补充（跟随“浏览器”设置）
4.为“应用”的“快捷方式创建”补充了动态权限申请
5.将“显示”设置的“圆角角度”最小值限制为10
6.为“设备信息”的“传感器”补充了动态权限申请来修复身体传感器无法连接的问题
7.为“浏览器”菜单添加了退出选项，可以通过此选项关闭页面，而不是隐藏到后台
8.修正了浏览器页面的安全漏洞
9.其他修正与优化]],
    },
    {
        version="2.6.0.2 beta",
        major=[[1.修正了页面路径设置错误的问题
2.现在，“设备信息”中的“传感器”（以下简称为“传感器”）详情页可以手动控制连接与断开连接了
3.对“传感器”详情页中的“报告模式”为单次触发的传感器作出了连接行为变更
4.调整了主页面“退出到桌面”的行为
5.修正了在 Android 6.0 版本系统中“输入框”项目的颜色设定错误问题
6.修正了“安全性”设置在取消验证后无法再次验证的问题
7.修正了“安全性”设置在 Android 11 需要离开页面两次才会上锁的问题
8.修正了“编辑器”设置在 Android 10 以下系统的错误
9.新增“高级”设置]]
    },
    {
        version="2.6.0.1 beta",
        major=[[1.修正了页面路径设置错误的问题
2.修正了“系统共享库”无法进入的问题
3.“设备信息”的“传感器”现在可以查看详细信息了，并且可以查看传感器的数值变化
4.修正了“安全性”设置在取消验证后无法再次验证的问题
5.调整了“浏览器”页面的启动模式
6.现在 Windmill 支持以 64 位模式运行了
7.修正了“编辑器”设置无法更改“高亮颜色”的问题]],
    },
    {
        version="2.0.6 beta",
        major=[[1.修正了引导页权限检查的问题
2.[实验性功能] 通过修改 Androlua+ 代码，现在，Windmill 使用的权限将会动态申请，不会在首次启动时全部申请了
3.修正了“轻调试”页面不会跟随深色模式改变的问题（如果你担心文件保存问题，可以在“编辑器”设置中关闭“跟随深色模式”，此选项单独于全局设置）
4.修正了“浏览器”页面的事件错误，现在，浏览器将以单例模式启动
5.修正了长按事件的问题
6.修正了“编辑器”设置中无法更改“背景图像”的问题
7.调整了“应用”详情页“快捷方式配置”的用户界面，你可以预览图标在桌面上的显示效果了（实际以添加到桌面后为准）
8.修正了“应用”详情页中因为活动名为空而无法创建快捷方式的问题（使用应用名称）
9.独立化了“应用”详情页的“活动”详情页
10.修正了“应用”详情页的“快捷方式配置”图标在深色模式进入再切换到浅色模式后变暗的问题
11.修正了在“显示”设置中更改了“圆角角度”后页面没有更新的问题
12.修正了“Http 调试”的错误并优化了界面输入
13.修正了在“显示”设置中选取了固定的主题背景后切换系统的“深色模式”后仍会重新创建页面的问题
14.[实验性功能] “小程序”现在以可以初步使用了，现在，可以通过在主页面的“主页”页面下拉来前往“小程序广场”
15.完善了应用内更新提示功能（主页面与“关于”页）
16.在部分页面加入了下拉刷新操作
17.调整了“捐赠”页面的界面排布并对捐赠人员列表作出调整
18.“编辑器”设置中的“符号栏”设置现在可用了
19.调整了“安全性”设置，设置选项仅在开启了主开关才会显示
20.“显示”设置的“周开始日”设置项现在可用了
21.修正了“图片转链接”的列表加载问题（在刷新时不会小概率崩溃了）
22.优化了“显示”的主题更改设置并移除了“辅助色”支持
23.修正了“取色器”中的错误
24.“用户信息”中的“修改密码”功能现在可用了
25.优化了“条款”的内容展示，在线版本的条款不会跳转到浏览器查看了
26.修正了无法正确调用发送邮件的功能
27.修正了“系统共享库”无法查看的问题
28.现在，在主页面点按返回键 Windmill 将会切换到后台，而不是直接退出（可以在“更多”页点按“退出”来真正退出本应用）
29.修正了“图片转链接”详情页在重新创建后会重复上传图片的问题（如果上传失败，在重新创建后仍会尝试上传）
30.[实验性功能] IDE 的“创建项目”功能现在可用了（主功能将在后续版本添加补充）
31.“浏览器”的“页面内搜索”功能现在可用了
32.修正了全面屏设备上的“代码调试”在切换到横屏时界面被遮挡的问题
33.为“代码调试”添加了输入法布局调整动画（默认关闭）
34.修正了“调色板”的问题
35.为部分文件选择功能限定了文件类型
36.修正了在列表的最后一个输入框项目点按输入法的“完成”按钮后崩溃的问题
37.调整了首次启动时桌面图标 Shortcut 的添加时机
38.修正了在安卓11以下的系统版本“安全性”设置反复拉起密码验证界面的问题
39.修正了“浏览器”的“网站设置”在离开页面后不会重新锁定“Cookie”的问题（需要离开“网站设置”主页才会锁定）
40.调整了“引导页”权限申请项，仅在需要的系统版本上才会显示需要的项目]],
    },
    {
        version="2.0.5.2 beta",
        major="补丁更新",
        detail=[[1.修正了“类检查器”设置的问题
2.修正了“Java API”的搜索、模拟器上类名显示问题与其他问题
3.在“类检查器”设置中新增了“显示系统加载类”的实验性功能选项，默认关闭
4.调整了快捷方式 Shortcut 的图标
5.修正了一些软件错误]],
    },
    {
        version="2.0.5.1 beta",
        major="补丁更新",
        detail=[[1.修正了快捷方式 Shortcut 问题
2.调整了一些软件错误]],
    },
    {
        version="2.0.5 beta",
        major=[[1.修正了“应用”的列表加载问题（2.0.4 的更新让其加载速度大大提升！）
‌2.添加了部分 SDK 版本的方法适配
‌3.修正了“Windmill 调试工具”的错误
‌4.修正了“应用”活动列表的快捷方式创建问题，并在更高版本的系统可正确创建快捷方式
‌5.尝试修复桌面 Shortcut 的图标显示问题，并将其背景更改为非透明
‌6.修正了“内置浏览器”的“设置”与“网站设置”的错误
‌7.修正了“内置浏览器”部分网站无法选择文件的问题
‌8.在部分页面加入了下拉刷新操作
‌9.优化了开关选项的事件执行
‌10.修正了“内置浏览器”错误地提示打开外部应用的问题
‌11.现在，你可以在“编辑器”的编码设置中选择“维持文件配置”了，这样可以避免因为编码导致的内容读取问题
‌12.[实验性功能] 现在，“Java API”可以显示设备上的所有类了（而不是 Windmill 提供的列表）
‌13.优化了“Java API”的列表加载方式
‌14.现在，在“轻调试”中选择或创建文件都会经过储存访问框架
‌15.“轻调试”中的“导入分析”现在可用了
‌‌16.修正了在部分系统上无法访问“类检查器设置”的问题
‌17.尝试修正了开关控件的显示问题并加深了状态颜色
‌18.修正了在“类检查器”中启用“显示视图预览”后，查看某些视图类时应用可能会崩溃的问题
‌19.优化了“类检查器”的“显示字段内容”的字段加载方式
‌20.现在，可以在“应用”中提取图标、安装包以及横幅了
‌21.现在，在“应用”详情页创建活动快捷方式时可以自定义配置了（长按进入高级配置）
‌22.修正了“应用”的搜索结果中可能含有上个搜索词的问题
23.由于开发者的小失误，新增了一些软件错误]],
    },
    {
        version="2.0.4.1 beta",
        major="补丁更新",
        detail="1.修正了“调试工具”的“储存”分析的错误问题",
    },
    {
        version="2.0.4 beta",
        major=[[1.在无法保存图片的情况下提供手动选择保存路径的方法
2.移除/隐藏了“设备信息”中的部分信息，因为它们在更新的系统版本中无法被查看（旧版本中可获取的仍会显示）
3.调整了“设备信息”的刷新方式
4.修正了“应用”详情页加载列表时小概率崩溃的问题
5.调整与优化了“应用”的列表加载方式
6.在“设置”页面新增了“Windmill 调试工具”供开发人员发现软件问题
7.调整了“快捷图块管理”的保存时机
7.“日志”功能可以使用了
8. “浏览器”支持“深色模式”了（Android 10+）
9. “类检查器设置”的“平台与文档”的文档入口可以展开折叠，默认折叠
10.点击“设备信息”的“处理器”图块会跳转到正确的位置了
11.调整了开关控件的样式
12.优化了“浏览器”的“搜索”功能
13.可以通过下拉刷新来更换“设置”的“使用提示”
14.修正了“Java API”的“视图预览”的属性设置错误问题
15.调整了部分文本
16.微调部分界面与列表内容
17.Windmill 在“应用全屏显示”中归类为“已适配”了
18.为“内置浏览器”的标题栏增加了动画
19.修正了“内置浏览器”的“搜索”功能“当前网页”的链接不会更新的问题
20.修正了“最低支持的目标平台版本号”值获取问题
21.主页的“退出”功能现在有了二次确认
22.修复“应用”详情页中的“活动”页面条目事件问题]],
    },
    {
        version="2.0.3",
        major=[[已将目标平台版本号提升至 30（Android 11）！

为了帮助发现软件错误，现在“调试模式”已调整为默认开启。

1.修正主页“签到”的完成后状态问题
2.修正“快速反馈”中的依赖缺失问题
3.微调“快速反馈”列表
4.修正“Http 调试”的“Header”输入框的内容判断问题
5.修正“轻调试”的图片背景、“图片取色器”与“图片转链接”的本地图片读取问题
6.修正“图片转链接”的加载指示器显示问题
7.微调“设备信息”界面显示
8.微调“帮助与反馈”界面显示
9.修正了部分文本错误
10.移除了“轻调试”中的“历史记录”，请前往系统选择器中的“最近”查看
11.修复了“轻调试”无法跳转选择文件的问题]],
        --detail=[[]],
    },
    {
        version="2.0.2",
        major=[[2.0 公测版
        
· 全部主要列表更新为 RecyclerView 控件，视图类型多样化
· 部分用户界面与交互改版
· 优化与部分 bug 修复
        
部分功能未完善或不可用，可加入官方群聊留意后续更新。此版本有已知的部分 bug ，将在下个版本更新时修复。]],
    },
    {
        version="1.2.4",
        major=[[新增
· UUID 生成器
· 代码调试文件编辑记录

调整
· 优化页面层级
· 更改部分页面为 PopupWindow
· 新增“应用内浏览”选项
· IDE 设置新增编辑器设置，可设置字体颜色、大小与字型
· 合并了内置功能与小程序的快捷方式创建页面
· 部分页面的 GridView 更改为 RecyclerView
· 拆分了“颜色工具”的四个功能
· “调色板”可记住上次的颜色
· 微调手册页面内容 UI
· 微调“运行日志”页面
· 微调启动页 UI

移除
· 移除了“快捷操作”
· 移除了“Lua 程序设计”
· 移除了“启动页设置”的网络图片选项]],
        --detail=[[]],
    },
    {
        version="1.1",
        major=[[新增
· 开发人员选项新增“json 转 table”

调整
· 修复了应用管理与系统信息页面的 bug
· 更改引导页样式
· UI微调与功能优化、完善
· 更换了启动统计
· 语义化版本控制]],
        --detail=[[]],
    },
    {
        version="1.0.28",
        major=[[开发人员选项新增一些工具]],
        detail=[[新增
· 可打开内置小程序
· 开发人员选项新增“我的笔记”
· 开发人员选项新增工具：布局助手、图片转链接、应用、系统信息、Jar 转 dex、xml 转 table
· 小程序与开源工程的“官方”与“优质”标识

调整
· 界面微调
· 微调小程序主页
· 手册页面整合到开发人员选项
· 调整一些 Lua 依赖函数
· 细节更改]],
    },
    {
        version="1.0.24",
        major=[[开发人员选项新增一些工具]],
        detail=[[新增
· 开发人员选项新增“用户统计”页面
· 开发人员选项新增“页面初始时间”
· 开发人员选项新增“手册”页面，内含“代码手册”等 Lua 学习内容
· 开发人员选项-开源实例新增“Alp 工程”
· 增加了更多内置图标

调整
· 更改内置图标库为 Two-Tone 样式
· 微调了界面圆角角度
· 统一了菜单项目的外观
· 调整一些 Lua 依赖函数
· 细节更改
· 性能优化]],
    },
    {
        version="1.0.21",
        major=[[完善代码调试页面]],
        detail=[[新增
· 完善了开发人员选项-代码调试的一些功能（新建，打开，保存，查找，跳转行数，重新读取，对齐，语法检查，导出，编译，开发文档）
· 开发人员选项-代码调试新增JAVA API，导入分析
· 新增文件选择模块

调整
· 修复了离线模式的错误
· 主页面双击返回不会直接退出软件
· 微调设置-开发人员选项
· 调整部分页面的选项顺序
· 微调界面圆角角度
· 调整一些 Lua 依赖函数
· 性能优化]],
    },
    {
        version="1.0.19",
        major=[[向开发工具的方向转变]],
        detail=[[新增
 · 设置新增快捷操作，可查看天气等信息
 · 设置新增启动页选项，可关闭启动页
 · 设置-外观设置-导航栏颜色新增一个可选颜色（主题色）
 · 可将设置-开发人员选项设置为主页面
 · 完善了设置-开发人员选项-代码调试的一些功能
 · 新增一个选择模块
 · 新增一个依赖库
 · 新增一个 Lua 依赖文件
 · 调整一些 Lua 依赖函数

调整
 · 设置-外观设置更名为个性化
 · 设置-个性化-界面阴影强度更改为开关选项
 · 微调设置-开发人员选项
 · 界面微调
 · 微调界面圆角角度
 · 更改部分本地数据的储存方式
 · 内部文件结构更改
 · 微调应用运行页面]],
    },
    {
        version="1.0.17",
        major=[[变更为正式版

新增
 · 设置-外观设置新增界面阴影强度，可选三个强度等级（默认、低、无）
 · 设置-关于新增捐赠
 · 设置-关于新增感谢名单
 · 新增一些 Lua 依赖函数

调整
 · 主页面的新版本提示当天不重复提示
 · 设置-外观设置-导航栏沉浸更名为导航栏颜色，可选三种颜色（黑、白、灰），默认灰色
 · 微调设置-帮助与反馈-常见问题、设置-关于-更新日志和设置-关于-开源许可项目的布局
 · 合并设置-关于-更新日志和设置-关于-应用更新日志
 · 微调上下滚动界面的过度滑动效果
 · 更改界面背景颜色
 · 代码重构与优化

修复
 · 修复设置-帮助与反馈-常见问题项目显示顺序混乱的问题
 · 修复一些BUG]],
        --detail=[[]],
    },
    {
        version="1.0.15-alpha",
        major=[[新增
 · 设置-外观设置新增导航栏沉浸选项

调整
 · 微调设置-外观设置
 · 微调主页布局
 · 微调对话框布局
 · 调整 Lua 依赖函数

修复
 · 修复主页面-分类标签栏跳转不正确的问题
 · 修复一些BUG]],
        --detail=[[]],
    },
    {
        version="1.0.14-alpha",
        major=[[新增
 · 设置新增管理数据文件
 · 应用信息页面可查看图标大图并保存分享
 · 新增一些 Lua 依赖函数

修复
 · 修复应用运行页面执行两次的问题

调整
 · 更改界面背景色
 · 错误处理
 · 微调设置-开发者选项
 · 优化应用运行页面
 · 搜索英文关键词不区分大小写
 · 更改了数据储存路径
 · 本地储存的源码二次处理
 · 主题颜色应用到对话框按钮
 · 微调设置-关于-更新日志]],
        --detail=[[]],
    },
    {
        version="1.0.136-alpha",
        major=[[修复
 · 修复无法进入应用的问题

调整
 · 微调设置-开发者选项
 · 微调设置-开发者选项-代码调试]],
        --detail=[[]],
    },
    {
        version="1.0.13-alpha",
        major=[[新增
 · 应用错误页面

修复
 · Toast的显示问题

调整
 · 删除无用页面与函数
 · 优化应用的代码逻辑
 · 微调设置-关于
 · 微调设置-开发人员选项
 · 提高了应用的稳定性]],
        --detail=[[]],
    },
    {
        version="1.0.12-alpha",
        major=[[新增
 · 可在主页面切换离线模式
 · 设置-外观设置-主题颜色新增7种主题色（共11种）
 · 设置-关于新增开源许可
 · Toast动画

修复
 · Toast与部分控件的高宽问题
 · 关闭离线模式的错误
 · 修复设置-帮助与反馈的错误

调整
 · 微调交互
 · 微调Toast样式
 · 更换应用图标
 · 更改主题色的色值
 · 更改默认主题色蓝色为绿色
 · 微调设置-开发者选项-源码调试
 · 微调布局（阴影，卡片圆角化）]],
        --detail=[[]],
    },
    {
        version="1.0.109-alpha",
        major=[[新增
 · 新增一些 Lua 依赖函数
 · 设置-开发者选项-源码调试新增快捷符号栏与撤销重做

调整
 · 微调布局
 · 微调一些 Lua 依赖函数
 · 设置-关于-引导页的图片与文字]],
        --detail=[[]],
    },
    {
        version="1.0.108-alpha",
        major=[[新增
 · 设置-开发者选项-代码调试可自动保存代码内容

修复
 · 设置-开发者选项的开关保存状态

调整
 · 设置-关于-引导页的图片文字
 · 对话框文字颜色]],
        --detail=[[]],
    },
    {
        version="1.0.107-alpha",
        major=[[新增
 · 设置-开发者选项新增代码调试
 · 新增一些 Lua 依赖函数

修复
 · 修复设置-关于-更新日志显示顺序混乱的问题

调整
 · 移除设置-开发者模式的密钥
 · 移除主页面在检测版本号时的“已是最新版本”提示]],
        --detail=[[]],
    },
    {
        version="1.0.105-alpha",
        major=[[新增
 · 设置-关于新增日志查看

修复
 · 修复主页面应用口令无法识别的问题

调整
 · 微调识别应用口令的对话框布局
 · 微调检测更新的对话框布局
 · 更改界面背景色]],
        --detail=[[]],
    },
    {
        version="1.0.1025-alpha",
        major=[[优化与 Bug 修复]],
        detail=[[新增
 · 上下滑动界面的过度滑动效果

调整
 · 更改通知栏背景颜色
 · 微调布局
 · 统一长按菜单的项目
 · 调整交互
 · 取消界面全屏模式
 · 首次启动应用的加载界面和动画效果
 · 打开已启动过的应用时不显示加载界面
 · 全部适配夜间模式]],
    },
    {
        version="1.0-alpha",
        major=[[新增
 · 设置新增离线模式选项
 · 设置-外观设置新增表格布局选项
 · 设置-外观设置新增暗色模式、自动旋转屏幕和主题颜色选项
 · 设置新增开发者选项]],
        --detail=[[]],
    },
}