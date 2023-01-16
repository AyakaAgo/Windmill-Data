{
--contributor={"MUK"},
{"基础代码",
{"参考链接",[[关于 Lua 的语法和 Android API 请参考以下网页。

Lua官网
http://www.lua.org

Android API
https://developer.android.google.cn/reference/packages?hl=cn]]},
{"部分常用方法",[[--activity 相关函数（通常情况下，this 等同于 activity）
activity.setTitle('Title')--设置窗口标题（如果设置了无标题栏主题则不可视）
activity.setTheme(android.R.style.Theme_DeviceDefault_Light)--设置主题，注意主题要在 setContentView 前设置才有效
activity.setContentView(View)--设置窗口视图

activity.getWidth()--获取activity宽
activity.getHeight()--获取activity高
--以上获取的不是屏幕实际高宽

activity.newActivity("main")--跳转新页面
activity.finish()--关闭当前页面
activity.recreate()--重构activity
os.exit()--结束程序

--转换
tostring(123)--转换字符串
tonumber("123")--转换数字
tointeger(12.3)--转换整数

--线程
--线程中 this 指的是 thread 自身
thread(function()print"线程"end)
task(function()print"线程"end)--AsyncTask

--加载代码
loadfile("filepath")--将文件转换为一个函数并返回
loadstring("print(\"Hello World!\")")--将字符串转换为一个函数并返回
--如果有语法错误则抛异常

loadlayout({TextView})--加载布局表并返回
loadbitmap("imagepath")--加载本地/网络图片并返回

--执行
dofile("filepath",{传递参数})--执行文件内容，第二个参数为可选值
this.doFile("filepath",{传递参数})--同上
this.doString("print(\"Hello World!\")",{传递参数})--执行字符串内容，第二个参数为可选值

--activity返回值
activity.setResult(int,intent)
activity.result(table)
--通过返回的 activity 中的 onActivityResult 函数接收指令]]},
{"导入模块、包或类",[[require "import" 
--以导入import模块，简化写代码的难度。
--目前程序还内置bmob,canvas,cjson,ftp,gl,http,import,md5,smtp,socket,sensor,xml,zip,zlib等模块。

--一般模块导入形式：
local http=require "http"
--这样导入的是局部变量
--导入import后也可以使用 import "http" 的形式，导入为全局变量

--在使用Java类之前需要导入相应的包或者类，可以用包名.*的形式导入导入包：
import "android.widget.*"

--或者用完整的类名导入类：
import "android.widget.Button"

--导入内部类：
import "android.view.View$OnClickListener"

--或者在导入类后通过.使用内部类
View.OnClickListene

--导入的类为全局变量，你可以使用
local Button=import "android.widget.Button"
--的形式保存为局部变量，以解决类名冲突问题。]]},
{"创建布局与控件",[[--安卓使用布局与视图管理和显示 UI。
--布局（layout）负责管理视图（view）如何显示，如 LinearLayout 以线性排列视图，FrameLayout 则要求自行指定停靠与位置。
--视图则显示具体内容，如 TextView 可以向用户展示文字内容，Button 可以响应用户点击事件。

--创建一个线性布局
local layout=LinearLayout(activity)
--创建一个按钮视图
local button=Button(activity)
--将按钮添加到布局
layout.addView(button)
--将刚才的内容设置为活动内容视图：
activity.setContentView(layout)

--activity 是当前窗口的上下文对象，如果你习惯也可以使用 this
local button=Button(this)

--在创建复杂布局时使用上面的方法十分不便
--可以使用 loadlayout 模块来创建一个布局
local view=loadlayout({
    LinearLayout,
    {
        Button,
    },
})]]},
{"使用事件",[[--此处举例点击事件
--创建事件处理函数
local function click(v)
    print(v)
end

--把函数添加到事件接口
local listener=View.OnClickListener{onClick=click}

--把接口注册到组件
button.setOnClickListener(listener)

--也可以使用匿名函数
button.setOnClickListener(View.OnClickListener{onClick=function(s)
    print(v)
end})
--注意如果事件相同，OnClickListener 等监听可复用在多个不同控件上
    
--onxxx事件可以简写
button.onClick=function(v)
    print(v)
end]]},
{"getXXX 与 setXXX",[[--如果 Java 的 getxxx 方法没有参数或者 setxxx 方法只有一个参数时可以简写
button.Text="按钮"--相当于setText
local x=button.Text--相当于getText]]},
{"Activity 回调事件",[[--在 Activity 文件添加以下函数，这些函数可以在特定的状态下被执行。
function main(...)
    --...：newActivity传递过来的参数。
    print("入口函数",...)
end

function onConfigurationChanged(config)
    --config：配置信息
    print("屏幕配置改变")
end

--Activity 生命周期
function onCreate()
    print("Activity 创建")
end

function onStart()
    print("Activity 开始")
end
  
function onResume()
    print("返回程序")
end

function onPause()
    print("Activity 暂停")
end

function onStop()
    print("Activity 停止")
    end

function onDestroy()
    print("Activity 退出")
end

--接收来自其他 Activity 的参数
function onResult(name,...)
  --name：返回的活动名称
  --...：返回的参数
  print("返回活动",name,...)
end

function onActivityResult(request,result,intent)
  --request：请求码，即调用startActivityForResult()传递过去的值  
  --result：结果码，结果码用于标识返回数据来自哪个新 Activity
  --intent：储存参数的 Intent
end

--屏幕触摸事件
function onTouchEvent(event)
    --event：事件
    print("触摸事件",event)
end
--如果设置了 ContentView 将会被拦截

--虚拟键、实体键点按事件
function onKeyDown(keycode,event)
    --keycode：键值
    --event：事件
    print("按键按下",keycode)
end

function onKeyUp(keycode,event)
    --keycode：键值
    --event：事件
    print("按键抬起",keycode)
end

function onKeyLongPress(keycode,event)
    --keycode：键值
    --event：事件
    print("按键长按",keycode)
end

--ActionBar相关
function onCreateOptionsMenu(menu)
    --menu：选项菜单。
    menu.add("菜单")
end

function onOptionsItemSelected(item)
    --item：选中的菜单项
    print(item.Title)
end]]},
{"按键与触控",[[--按键与触控

function onKeyDown(code,event)
    print(code event)
end

function onTouchEvent(event)
    print(event)
end
--支持onKeyDown,onKeyUp,onKeyLongPress,onTouchEvent
--返回值必须为 boolean 类型]]},
{"字符串基本操作",[[local strings="左中右"

--左边
local 左=strings:match("(.+)中")

--之间
local 中=strings:match("左(.-)右")

--右边
local 右=strings:match("(.+)右")

--替换
string.gsub(原字符串,替换的字符串,替换成的字符串)

--匹配位置
local 起始位置,结束位置=string.find(字符串,子串)

--按位置捕获
string.sub(字符串,子串起始位置,子串结束位置)]]},
{"数组",[[local array={1,2,3}
local array=[1,2,3]--使用 [] 时 value 不带有 key]]},
{"线程",[[--需导入import模块，参看thread,timer与task函数说明。
--线程中使用独立环境运行，不能使用外部变量与函数，需要使用参数和回调与外部交互。
--线程中 this 指自身

--任务
task(str,args,callback)
--str 为任务执行代码，args 为参数，callback 为回调函数，任务返回值将传递到回调方法

--线程
local t=thread(str,args)
--str 为线程中执行的代码，args 为初始传入参数

--在主线程调用线程中方法
call(t,fn,args)
--t 为线程，fn 为方法名称，args 为参数

--设置线程中的变量
set(t,fn,arg)
--t 为线程，fn 为变量名称，arg 为变量值

--在线程调用主线程中方法
call(fn,args)
--fn 为方法名称，args 为参数

--在线程设置主线程变量
set(fn,arg)
--fn 为变量名称，arg 为变量值

--注. 参数类型为 字符串，数值，Java对象，布尔值与nil
--线程要使用quit结束线程。

local t=timer(func,delay,period,args)
--func 为定时器执行的函数，delay 为定时器延时，period 为定时器间隔，args 为初始化参数

t.Enable=false--暂停定时器
t.Enable=true--启动定时器
t.stop()--停止定时器

--注意：定时器函数定义run函数时定时器重复执行run函数，否则重复执行构建时的func函数]]},
{"布局表",[=[--使用布局表
--使用布局表须导入android.view与android.widget包。

require "import"
import "android.widget.*"
import "android.view.*"

--布局表格式
local layout={
    控件类名,
    id="控件名称",
    属性=值,
    {
        子控件类名,
        id="控件名称",
        属性=值,
    }
}
  
--例如：
local layout={
  LinearLayout,
  id="linear",--视图ID，可以在loadlayout后直接使用
  orientation="vertical",--属性与值
  {
    TextView,--子视图类名称
    text="Hello World!",
    layout_width="fill",
  },
}

--使用loadlayout函数解析布局表生成布局。
activity.setContentView(loadlayout(layout))
--也可以简化为
activity.setContentView(layout)
--如果使用单独文件布局(比如有个layout.aly布局文件)也可以简写为：
activity.setContentView("layout")
--此时不用导入布局文件。

--[[布局表支持大部份安卓控件属性，
与安卓XML布局文件的不同点：

id表示在Lua中变量的名称，而不是安卓的可以findViewById的数字id（当然，你也可以设为数字id，然后使用findViewById）;

ImageView的src属性是当前目录图片名称或绝对文件路径图片或网络上的图片;

layout_width与layout_height的值支持fill与wrap简写;

onClick值为lua函数或java onClick接口或他们的全局变量名称;

背景background支持背景图片，背景色与LuaDrawable自绘制背景，背景图片参数为是当前目录图片名称或绝对文件路径图片或网络上的图片，颜色同backgroundColor，自绘制背景参数为绘制函数或绘制函数的全局变量名称;

控件背景色使用backgroundColor设置，值为十六进制颜色值(0x...);

尺寸单位支持 px，dp，sp，in，mm，%w，%h，推荐使用 dp。
其他参考 loadlayout 与 loadbitmap。]]]=]},
{"Lua 类型与 Java 类型",[[--在大多数情况下androlua可以很好的处理Lua与Java类型之间的自动转换，但是Java的数值类型有多种(double,float,long,int,short,byte)，而Lua只有number，在必要的情况下可以使用类型的强制转换。
local i=int(10)
--i就是一个Java的int类型数据
local d=double(10)
--d是一个Java的double类型

--在调用Java方法时androlua可以自动将Lua的table转换成Java的array，Map或interface
--Map类型可以像使用Lua表一样简便。
local map=HashMap{a=1,b=2}
print(map.a)
map.a=3
--取长度运算符#可以获取Java中array，List,Map,Set，String的长度。]]},
{"2D 绘图",[[import "android.graphics.*"

local paint=Paint().setARGB(100,0,250,0)

local surface=SurfaceView(acticity)

local holder=surface.getHolder()

holder.addCallback(SurfaceHolder.Callback{
    surfaceChanged=function(holder,format,width,height)
    
    end,
    surfaceCreated=function(holder)
        local ca=holder.lockCanvas()
        if ca then
            ca.drawRect(0,0,200,300,paint)
        end
        holder.unlockCanvasAndPost(ca)
    end,
    surfaceDestroyed=function(holder)
   
    end})

activity.setContentView(surface)]]},
{"Open GL 模块",[[require "import"
import "gl"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.opengl.*"

local mTriangleData ={
    0.0,0.6,0.0,
    -0.6,0.0,0.0,
    0.6,0.0,0.0,
}

local mTriangleColor = {
    1,0,0,0,
    0,1,0,0,
    0,0,1,0,
}

local sr=GLSurfaceView.Renderer{
    onSurfaceCreated=function(gl2, config)
        gl.glDisable(gl.GL_DITHER)
        .glHint(gl.GL_PERSPECTIVE_CORRECTION_HINT,gl.GL_FASTEST)
        .glClearColor(0,0,0,0)
        .glShadeModel(gl.GL_SMOOTH)
        .glClearDepth(1.0)
        .glEnable(gl.GL_DEPTH_TEST)
        .glDepthFunc(gl.GL_LEQUAL)
    end,
    onDrawFrame=function(gl2, config)
        gl.glClear(gl.GL_COLOR_BUFFER_BIT|gl.GL_DEPTH_BUFFER_BIT)
        .glMatrixMode(gl.GL_MODELVIEW)
        .glLoadIdentity()
        .glRotate(0,1,1,1)
        .glTranslate(0, 0,0)
        .glEnableClientState(gl.GL_VERTEX_ARRAY)
        .glEnableClientState(gl.GL_COLOR_ARRAY)
        .glVertexPointer(mTriangleData,3)
        .glColorPointer(mTriangleColor,4)
        .glDrawArrays(gl.GL_TRIANGLE_STRIP,0,3)
        .glFinish()
        .glDisableClientState(gl.GL_VERTEX_ARRAY)
        .glDisableClientState(gl.GL_COLOR_ARRAY)
    end,
    onSurfaceChanged= function (gl2, w, h)
        local r=w/h
        gl.glViewport(0,0,w,h)
        .glLoadIdentity()
        .glFrustum(-r,r,-1,1,1,10)
    end}

local glSurefaceView=GLSurfaceView(activity)
.setRenderer(sr)

activity.setContentView(glSurefaceView)]]},
{"http 同步网络模块",[=[body,cookie,code,headers=http.get(url [,cookie,ua,header])
body,cookie,code,headers=http.post(url ,postdata [,cookie,ua,header])
code,headers=http.download(url [,cookie,ua,ref,header])
body,cookie,code,headers=http.upload(url ,datas ,files [,cookie,ua,header])

--[[参数说明
url 网址
postdata post的字符串或字符串数据组表
datas upload的字符串数据组表
files upload的文件名数据表
cookie 网页要求的cookie
ua 浏览器识别
ref 来源页网址
header http请求头]]

require "import"
import "http"

--get函数以get请求获取网页，参数为请求的网址与cookie
body,cookie,code,headers=http.get("http://www.androlua.com")

--post函数以post请求获取网页，通常用于提交表单，参数为请求的网址，要发送的内容与cookie
body,cookie,code,headers=http.post("http://androlua.com/Login.Asp?Login=Login&Url=http://androlua.com/bbs/index.asp","name=用户名&pass=密码&ki=1")

--download函数和get函数类似，用于下载文件，参数为请求的网址，保存文件的路径与cookie
http.download("http://androlua.com","/sdcard/a.txt")

--upload用于上传文件，参数是请求的网址，请求内容字符串部分，格式为以key=value形式的表，请求文件部分，格式为key=文件路径的表，最后一个参数为cookie
http.upload("http://androlua.com",{title="标题",msg="内容"},{file1="/sdcard/1.txt",file2="/sdcard/2.txt"})]=]},
{"Http 异步网络模块",[=[--获取内容 get函数
Http.get(url,cookie,charset,header,callback)
--[[url 网络请求的链接网址
cookie 使用的cookie，也就是服务器的身份识别信息
charset 内容编码
header 请求头
callback 请求完成后执行的函数

除了url和callback其他参数都不是必须的

回调函数接受四个参数值分别是
code 响应代码，2xx表示成功，4xx表示请求错误，5xx表示服务器错误，-1表示出错
content 内容，如果code是-1，则为出错信息
cookie 服务器返回的用户身份识别信息
header 服务器返回的头信息]]

--向服务器发送数据 post函数
Http.post(url,data,cookie,charset,header,callback)
--除了增加了一个data外，其他参数和get完全相同
--data 向服务器发送的数据

--下载文件 download函数
Http.download(url,path,cookie,header,callback)
--参数中没有编码参数，其他同get，
--path 文件保存路径

--需要特别注意一点，只支持同时有127个网络请求，否则会出错

--Http其实是对Http.HttpTask的封装，Http.HttpTask使用的更加通用和灵活的形式
--参数格式如下
Http.HttpTask( url, String method, cookie, charset, header,  callback) 
--[[所有参数都是必选，没有则传入nil

url 请求的网址
method 请求方法可以是get，post，put，delete等
cookie 身份验证信息
charset 内容编码
header 请求头
callback 回调函数]]

--该函数返回的是一个HttpTask对象，
--需要调用execute方法才可以执行，
local t=Http.HttpTask(xxx)
t.execute{data}

--注意调用的括号是花括号，内容可以是字符串或者byte数组，
--使用这个形式可以自己封装异步上传函数]=]},
{"Bmob 网络数据库",[[local b=bmob(id,key)
--id 用户id，key 应用key。

b:insert(key,data,callback)
--新建数据表，key 表名称，data 数据，callback 回调函数。

b:update(key,id,data,callback)
--更新数据表，key 表名称id 数据id，data 数据，callback 回调函数。

b:query(key,data,callback)
--查询数据表，key 表名称，data 查询规则，callback 回调函数。

b:increment(key,id,k,v,c)
--原子计数，key 表名称，id 数据id，k 数据key，v 计数增加量。

b:delete(key,id,callback)
--删除数据，key 表名称,id 数据id，callback 回调函数。

b:sign(user,pass,mail,callback)
--注册用户，user 用户名，pass 密码，mail 电子邮箱，callback 回调函数。

b:login(user or mail,pass,callback)
--登录用户，user 用户名，pass 密码，mail 电子邮箱，callback 回调函数。

b:upload(path,callback)
--上传文件，path 文件路径，callback 回调函数。

b:remove(url,callback)
--删除文件，url 文件路径，callback 回调函数。

--注：
--查询规则支持表或者json格式，具体用法参考官方api
--回调函数的第一个参数为状态码，-1 出错，其他状态码参考http状态码，第二个参数为返回内容。]]},
{"LuaUtil",[[import "com.androlua.LuaUtil"
--此处未列出全部方法，可自行在 dex 查看。

copyDir(from,to)
--复制文件或文件夹，from 源路径，to 目标路径。

zip(from,dir,name)
--压缩文件或文件夹，from 源路径，dir 目标文件夹，name zip文件名称。

unZip(from,to)
--解压文件，from zip文件路径，to 目标路径。

getFileMD5(path)
--获取文件MD5值， path 文件路径。

getFileSha1(path)
--获取文件Sha1值， path 文件路径。]]},
{"LuaAdapter 适配器",[[--构建方法
local adapter=LuaAdapter(activity,data,layout)
--构建适配器，activity 当前活动，data 列表数据，layout 列表项目布局。
--data参数可选,格式为{{id=value},{id=value}}格式的数组表。

adapter.add(data)
--添加数据，data 为列表项目数据，格式为{id=value}。

adapter.insert(idx,{id=value})
--插入数据，idx 为从0计数的插入位置，data 为列表项目数据，格式为{id=value}。

adapter.remove(idx)
--删除数据，idx 为从0计数的删除位置。

adapter.clear()
--清空数据。

adapter.notifyDataSetChanged()
--更新数据。
--除非关闭了自动刷新，此方法无需手动调用

--也可以使用table.insert/table.remove直接对data表操作，table库操作从1开始计数，改操作需要手动更新列表。

--在使用LuaAdapter的ListView的onItemClick/onItemLongClick回调函数中，第三个参数为从0开始的项目序号，第四个参数为从1开始的项目序号。]]},
{"部分函数参考",[==[--[a]表示参数a可选，(...)表示不定参数。函数调用在只有一个参数且参数为字符串或表时可以省略括号。
--AndroLua库函数在import模块，为便于使用都是全局变量。
--s 表示string类型，i 表示整数类型，n 表示浮点数或整数类型，t 表示表类型，b 表示布尔类型，o 表示Java对象类型，f为Lua函数。

each(o)
--参数：o 实现Iterable接口的Java对象
--返回：用于Lua迭代的闭包
--作用：Java集合迭代器


enum(o)
--参数：o 实现Enumeration接口的Java对象
--返回：用于Lua迭代的闭包
--作用：Java集合迭代器

import(s)
--参数：s 要载入的包或类的名称
--返回：载入的类或模块
--作用：载入包或类或Lua模块
import "http" --载入 .lua 模块
import "android.widget.*" --载入包
import "android.widget.Button" --载入类
import "android.view.View$OnClickListener" --载入内部类

loadlayout(t [,t2])
--参数：t 要载入的布局表，t2 保存view的表
--返回：布局最外层view
--作用：载入布局表，生成view
layout={
    LinearLayout,
    layout_width="fill",
    {
        TextView,
        text="Androlua",
        id="tv"
        }
    }
main={}
activity.setContentView(loadlayout(layout,main))
print(main.tv.getText())

loadbitmap(s)
--参数：s 要载入图片的地址，支持相对地址，绝对地址与网址
--返回：bitmap对象
--作用：载入图片
--注意：载入网络图片需要在线程中进行

task(s [,...], f)
--参数：s 任务中运行的代码或函数，... 任务传入参数，f 回调函数
--返回：无返回值
--作用：在异步线程运行Lua代码，执行完毕在主线程调用回调函数
--注意：参数类型包括 布尔，数值，字符串，Java对象，不允许Lua对象
function func(a,b)
    require "import"
    print(a,b)
    return a+b
    end
task(func,1,2,print)

thread(s[,...])
--参数：s 线程中运行的lua代码或脚本的相对路径(不加扩展名)或函数，... 线程初始化参数
--返回：返回线程对象
--作用：开启一个线程运行Lua代码
--注意：线程需要调用quit方法结束线程
func=[[
a,b=...
function add()
    call("print",a+b)
    end
]]
t=thread(func,1,2)
t.add()

timer(s,i1,i2[,...])
参数：s 定时器运行的代码或函数，i1 前延时，i2 定时器间隔，... 定时器初始化参数
返回：定时器对象
作用：创建定时器重复执行函数
function f(a)
    function run()
        print(a)
        a=a+1
        end
    end

t=timer(f,0,1000,1)
t.Enabled=false--暂停定时器
t.Enabled=true--重新定时器
t.stop()--停止定时器

luajava.bindClass(s)
参数：s class的完整名称，支持基本类型
返回：Java class对象
作用：载入Java class
Button=luajava.bindClass("android.widget.Button")
int=luajava.bindClass("int")

luajava.createProxy(s,t)
参数：s 接口的完整名称，t 接口函数表
返回：Java接口对象
作用：创建Java接口
onclick=luajava.createProxy("android.view.View$OnClickListener",{onClick=function(v)print(v)end})

luajava.createArray(s,t)
参数：s 类的完整名称，支持基本类型，t 要转化为Java数组的表
返回：创建的Java数组对象
作用：创建Java数组
arr=luajava.createArray("int",{1,2,3,4})

luajava.newInstance(s [,...])
参数：s 类的完整名称，... 构建方法的参数
作用：创建Java类的实例
b=luajava.newInstance("android.widget.Button",activity)

luajava.new(o[,...])
参数：o Java类对象，... 参数
返回：类的实例或数组对象或接口对象
作用：创建一个类实例或数组对象或接口对象
注意：当只有一个参数且为表类型时，如果类对象为interface创建接口，为class创建数组，参数为其他情况创建实例
b=luajava.new(Button,activity)
onclick=luajava.new(OnClickListener,{onClick=function(v)print(v)end})
arr=luajava.new(int,{1,2,3})
(示例中假设已载入相关类)

luajava.coding(s [,s2 [, s3]])
参数：s 要转换编码的Lua字符串，s2 字符串的原始编码，s3 字符串的目标编码
返回：转码后的Lua字符串
作用：转换字符串编码
注意：默认进行GBK转UTF8

luajava.clear(o)
参数：o Java对象
返回：无
作用：销毁Java对象
注意：仅用于销毁临时对象

luajava.astable(o)
参数：o Java对象
返回：Lua表
作用：转换Java的Array List或Map为Lua表

luajava.tostring(o)
参数：o Java对象
返回：Lua字符串
作用：相当于 o.toString()]==]},
{"Activity 部分 API 参考",[[setContentView(layout, env)
设置布局表layout为当前activity的主视图，env是保存视图ID的表，默认是_G
getLuaDir()
返回脚本当前目录
getLuaDir(name)
返回脚本当前目录的子目录
getLuaExtDir()
返回Androlua在SD的工作目录
getLuaExtDir(name)
返回Androlua在SD的工作目录的子目录
getWidth()
返回屏幕宽度
getHeight()
返回屏幕高度，不包括状态栏与导航栏
loadDex(path)
加载当前目录dex或jar，返回DexClassLoader
loadLib(path)
加载当前目录c模块，返回载入后模块的返回值(通常是包含模块函数的包)
registerReceiver(filter)
注册一个广播接收者，当再次调用该方法时将移除上次注册的过滤器
newActivity(req, path, enterAnim, exitAnim, arg)
打开一个新activity，运行路径为path的Lua文件，其他参数为可选，arg为表，接受脚本为变长参数
result{...}
向来源activity返回数据，在源activity的onResult回调
newTask(func[, update], callback)
新建一个Task异步任务，在线程中执行func函数，其他两个参数可选，执行结束回调callback，在任务调用update函数时在UI线程回调该函数
新建的Task在调用execute{}时通过表传入参数，在func以unpack形式接收，执行func可以返回多个值
newThread(func, arg)
新建一个线程，在线程中运行func函数，可以以表的形式传入arg，在func以unpack形式接收
新建的线程调用start()方法运行，线程为含有loop线程，在当前activity结束后自动结束loop
newTimer(func, arg)
新建一个定时器，在线程中运行func函数，可以以表的形式传入arg，在func以unpack形式接收
调用定时器的start(delay, period)开始定时器，stop()停止定时器，Enabled暂停恢复定时器，Period属性改变定时器间隔]]},
{"loadlayout 布局表支持属性",[[--android:drawingCacheQuality
    auto=0,
    low=1,
    high=2,

    --android:importantForAccessibility
    auto=0,
    yes=1,
    no=2,

    --android:layerType
    none=0,
    software=1,
    hardware=2,

    --android:layoutDirection
    ltr=0,
    rtl=1,
    inherit=2,
    locale=3,

    --android:scrollbarStyle
    insideOverlay=0x0,
    insideInset=0x01000000,
    outsideOverlay=0x02000000,
    outsideInset=0x03000000,

    --android:visibility
    visible=0,
    invisible=1,
    gone=2,

    wrap_content=-2,
    fill_parent=-1,
    match_parent=-1,
    wrap=-2,
    fill=-1,
    match=-1,

    --android:orientation
    vertical=1,
    horizontal= 0,

    --android:gravity
    axis_clip = 8,
    axis_pull_after = 4,
    axis_pull_before = 2,
    axis_specified = 1,
    axis_x_shift = 0,
    axis_y_shift = 4,
    bottom = 80,
    center = 17,
    center_horizontal = 1,
    center_vertical = 16,
    clip_horizontal = 8,
    clip_vertical = 128,
    display_clip_horizontal = 16777216,
    display_clip_vertical = 268435456,
    --fill = 119,
    fill_horizontal = 7,
    fill_vertical = 112,
    horizontal_gravity_mask = 7,
    left = 3,
    no_gravity = 0,
    relative_horizontal_gravity_mask = 8388615,
    relative_layout_direction = 8388608,
    right = 5,
    start = 8388611,
    top = 48,
    vertical_gravity_mask = 112,
    end = 8388613,

    --android:textAlignment
    inherit=0,
    gravity=1,
    textStart=2,
    textEnd=3,
    textCenter=4,
    viewStart=5,
    viewEnd=6,
    
    --android:inputType
    none=0x00000000,
    text=0x00000001,
    textCapCharacters=0x00001001,
    textCapWords=0x00002001,
    textCapSentences=0x00004001,
    textAutoCorrect=0x00008001,
    textAutoComplete=0x00010001,
    textMultiLine=0x00020001,
    textImeMultiLine=0x00040001,
    textNoSuggestions=0x00080001,
    textUri=0x00000011,
    textEmailAddress=0x00000021,
    textEmailSubject=0x00000031,
    textShortMessage=0x00000041,
    textLongMessage=0x00000051,
    textPersonName=0x00000061,
    textPostalAddress=0x00000071,
    textPassword=0x00000081,
    textVisiblePassword=0x00000091,
    textWebEditText=0x000000a1,
    textFilter=0x000000b1,
    textPhonetic=0x000000c1,
    textWebEmailAddress=0x000000d1,
    textWebPassword=0x000000e1,
    number=0x00000002,
    numberSigned=0x00001002,
    numberDecimal=0x00002002,
    numberPassword=0x00000012,
    phone=0x00000003,
    datetime=0x00000004,
    date=0x00000014,
    time=0x00000024,
    
    --android:ellipsize
    end　　  
    start 　　
    middle     
    marquee

    --相对布局rule
    layout_above=2,
    layout_alignBaseline=4,
    layout_alignBottom=8,
    layout_alignEnd=19,
    layout_alignLeft=5,
    layout_alignParentBottom=12,
    layout_alignParentEnd=21,
    layout_alignParentLeft=9,
    layout_alignParentRight=11,
    layout_alignParentStart=20,
    layout_alignParentTop=10,
    layout_alignRight=7,
    layout_alignStart=18,
    layout_alignTop=6,
    layout_alignWithParentIfMissing=0,
    layout_below=3,
    layout_centerHorizontal=14,
    layout_centerInParent=13,
    layout_centerVertical=15,
    layout_toEndOf=17,
    layout_toLeftOf=0,
    layout_toRightOf=1,
    layout_toStartOf=16

    --尺寸单位
    px=0,
    dp=1,
    sp=2,
    pt=3,
    in=4,
    mm=5]]},
--[=[{"when 保留关键字",[[--when就相当于简化过的if

if 5>1 then
  print("OK")
end
when 5>1 print("OK")

if 1>5 then
  print("emmmm")
 else
  print("OK")
end
when 1>5 print("emmmm") else print("OK")]]},]=]
{"defer 延时执行",[[print(1)
print(2)
print(3)
print(4)
--打印出1234

defer print(1)
defer print(2)
print(3)
defer print(4)
--打印出了3421
--说明代码运行顺序是先运行无defer的，然后有defer的从下往上运行]]},
},
{"实用代码",
{"字符串匹配网址",[[string.gmatchUrl=function(str)
  local t={}
  for i,v in string.gfind(str,"https?://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]") do
    table.insert(t,string.sub(str,i,v))
  end
  return t
end--返回table，支持匹配多个链接

--调用示例
local str="Lua 官网 http://lua.org 安卓开发者 https://developer.android.google.cn/"
print(dump(str:gmatchUrl()))]]},
{"通知图库更新文件",[[--方法1 通过广播
activity.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE,Uri.parse("file://"..图片路径)))

--方法2 MediaScannerConnection
import "android.media.MediaScannerConnection"
MediaScannerConnection.scanFile(activity, {File(图片路径).getAbsolutePath()}, nil, nil)]]},
{"dp, sp 与 px 的转换",[[local scale=activity.getResources().getDisplayMetrics().scaledDensity

local function dp2px(dpValue)
  return dpValue * scale + 0.5
end

local function px2dp(pxValue)
  return pxValue / scale + 0.5
end

local function px2sp(pxValue)
  return pxValue / scale + 0.5
end

local function sp2px(spValue)
  return spValue * scale + 0.5
end]]},
{"遍历字符串",[[local a="你好, world!"

for i=1 , utf8.len(a) do
  print(utf8.sub(a,i,i))
end]]},
{"获取设备ID",[[import "android.provider.Settings$Secure"
local android_id = Secure.getString(activity.getContentResolver(), Secure.ANDROID_ID)]]},
{"获取 IMEI、IMSI、运营商名称",[[import "android.content.Context" 
local telephone=activity.getSystemService(Context.TELEPHONY_SERVICE)

local IMEI=telephone.getDeviceId()
local IMSI=telephone.getSubscriberId()
local NetworkOperator=telephone.getNetworkOperatorName()]]},
{"背景渐变动画",[[import "android.animation.ObjectAnimator"
import "android.animation.ArgbEvaluator"
import "android.animation.ValueAnimator"
import "android.graphics.Color"

local colorAnim = ObjectAnimator.ofInt(控件ID,"backgroundColor",{多个颜色值的 table})
colorAnim.setDuration(3000)--时长
colorAnim.setEvaluator(ArgbEvaluator())--估值器
colorAnim.setRepeatCount(ValueAnimator.INFINITE)--重复次数
colorAnim.setRepeatMode(ValueAnimator.REVERSE)--重复模式
colorAnim.start()]]},
{"返回系统桌面",[[import "android.content.Intent"

local home=Intent(Intent.ACTION_MAIN)
home.addCategory(Intent.CATEGORY_HOME)
activity.startActivity(home)]]},
{"模拟按键",[=[local function sendKeyCode(keyCode)
  return pcall(function()
    Runtime.getRuntime().exec("input keyevent "..keyCode)
  end)
end

--sendKeyCode(4)--返回键

--[[键值对照表
KeyEvevent 常量名   描述   常量值
KEYCODE_0      '0' key.   7
KEYCODE_1      '1' key.   8
KEYCODE_2      '2' key.   9
KEYCODE_3      '3' key.   10
KEYCODE_4      '4' key.   11
KEYCODE_5      '5' key.   12
KEYCODE_6      '6' key.   13
KEYCODE_7      '7' key.   14
KEYCODE_8      '8' key.   15
KEYCODE_9      '9' key.   16

KEYCODE_A      'A' key.   29
KEYCODE_B      'B' key.   30
KEYCODE_C      'C' key.   31
KEYCODE_D      'D' key.   32
KEYCODE_E      'E' key.   33
KEYCODE_F      'F' key.   34
KEYCODE_G      'G' key.   35
KEYCODE_H      'H' key.   36
KEYCODE_I      'I' key.   37
KEYCODE_J      'J' key.   38
KEYCODE_K      'K' key.   39
KEYCODE_L      'L' key.   40
KEYCODE_M      'M' key.   41
KEYCODE_N      'N' key.   42
KEYCODE_O      'O' key.   43
KEYCODE_P      'P' key.   44
KEYCODE_Q      'Q' key.   45
KEYCODE_R      'R' key.   46
KEYCODE_S      'S' key.   47
KEYCODE_T      'T' key.   48
KEYCODE_U      'U' key.   49
KEYCODE_V      'V' key.   50
KEYCODE_W      'W' key.   51
KEYCODE_X      'X' key.   52
KEYCODE_Y      'Y' key.   53
KEYCODE_Z      'Z' key.   54

META_ALT_LEFT_ON   This mask is used to check whether the left ALT meta key is pressed.            16
META_ALT_MASK      This mask is a combination of META_ALT_ON, META_ALT_LEFT_ON and META_ALT_RIGHT_ON.      50
META_ALT_ON      This mask is used to check whether one of the ALT meta keys is pressed.            2
META_ALT_RIGHT_ON   This mask is used to check whether the right the ALT meta key is pressed.         32
META_CAPS_LOCK_ON   This mask is used to check whether the CAPS LOCK meta key is on.            1048576
META_CTRL_LEFT_ON   This mask is used to check whether the left CTRL meta key is pressed.            8192
META_CTRL_MASK      This mask is a combination of META_CTRL_ON, META_CTRL_LEFT_ON and META_CTRL_RIGHT_ON.      28672
META_CTRL_ON      This mask is used to check whether one of the CTRL meta keys is pressed.         4096
META_CTRL_RIGHT_ON   This mask is used to check whether the right CTRL meta key is pressed.            16384
META_FUNCTION_ON   This mask is used to check whether the FUNCTION meta key is pressed.            8
META_META_LEFT_ON   This mask is used to check whether the left META meta key is pressed.            131072
META_META_MASK      This mask is a combination of META_META_ON, META_META_LEFT_ON and META_META_RIGHT_ON.      458752
META_META_ON      This mask is used to check whether one of the META meta keys is pressed.         65536
META_META_RIGHT_ON   This mask is used to check whether the right META meta key is pressed.            262144
META_NUM_LOCK_ON   This mask is used to check whether the NUM LOCK meta key is on.               2097152
META_SCROLL_LOCK_ON   This mask is used to check whether the SCROLL LOCK meta key is on.            4194304
META_SHIFT_LEFT_ON   This mask is used to check whether the left SHIFT meta key is pressed.            64
META_SHIFT_MASK      This mask is a combination of META_SHIFT_ON, META_SHIFT_LEFT_ON and META_SHIFT_RIGHT_ON.   193
META_SHIFT_ON      This mask is used to check whether one of the SHIFT meta keys is pressed.         1
META_SHIFT_RIGHT_ON   This mask is used to check whether the right SHIFT meta key is pressed.            128
META_SYM_ON      This mask is used to check whether the SYM meta key is pressed.               4

KEYCODE_APOSTROPHE   ''' key.   75
KEYCODE_AT      '@' key.   77
KEYCODE_BACKSLASH   '\' key.   73
KEYCODE_COMMA      ',' key.   55
KEYCODE_EQUALS      '=' key.   70
KEYCODE_GRAVE      '`' key.   68
KEYCODE_LEFT_BRACKET   '[' key.   71
KEYCODE_MINUS      '-' key.   69
KEYCODE_PERIOD      '.' key.   56
KEYCODE_PLUS      '+' key.   81
KEYCODE_POUND      '#' key.   18
KEYCODE_RIGHT_BRACKET   ']' key.   72
KEYCODE_SEMICOLON   ';' key.   74
KEYCODE_SLASH      '/' key.   76
KEYCODE_STAR      '*' key.   17
KEYCODE_SPACE      Space key.   62
KEYCODE_TAB      Tab key.   61

KEYCODE_ENTER      Enter key.      66
KEYCODE_ESCAPE      Escape key.      111
KEYCODE_CAPS_LOCK   Caps Lock key.      115
KEYCODE_CLEAR      Clear key.      28
KEYCODE_PAGE_DOWN   Page Down key.      93
KEYCODE_PAGE_UP      Page Up key.      92
KEYCODE_SCROLL_LOCK   Scroll Lock key.   116
KEYCODE_MOVE_END   End.         123
KEYCODE_MOVE_HOME   Home.         122
KEYCODE_INSERT      Insert key.      124
KEYCODE_SHIFT_LEFT   Left Shift.      59
KEYCODE_SHIFT_RIGHT   Right Shift.      60

KEYCODE_F1   F1 key.      131
KEYCODE_F2   F2 key.      132
KEYCODE_F3   F3 key.      133
KEYCODE_F4   F4 key.      134
KEYCODE_F5   F5 key.      135
KEYCODE_F6   F6 key.      136
KEYCODE_F7   F7 key.      137
KEYCODE_F8   F8 key.      138
KEYCODE_F9   F9 key.      139
KEYCODE_F10   F10 key.   140
KEYCODE_F11   F11 key.   141
KEYCODE_F12   F12 key.   142

KEYCODE_BACK      Back key.      4
KEYCODE_CALL      Call key.      5
KEYCODE_ENDCALL      End Call key.      6
KEYCODE_CAMERA      Camera key.      27
KEYCODE_FOCUS      Camera Focus key.   80
KEYCODE_VOLUME_UP   Volume Up key.      24
KEYCODE_VOLUME_DOWN   Volume Down key.   25
KEYCODE_VOLUME_MUTE   Volume Mute key.   164
KEYCODE_MENU      Menu key.      82
KEYCODE_HOME      Home key.      3
KEYCODE_POWER      Power key.      26
KEYCODE_SEARCH      Search key.      84
KEYCODE_NOTIFICATION   Notification key.   83
KEYCODE_NUM      Number modifier key.   78
KEYCODE_SYM      Symbol modifier key.   63
KEYCODE_SETTINGS   Settings key.      176

KEYCODE_DEL      Backspace key. Deletes characters before the insertion point, unlike KEYCODE_FORWARD_DEL.   67
KEYCODE_FORWARD_DEL   Forward Delete key. Deletes characters ahead of the insertion point, unlike KEYCODE_DEL.   112

KEYCODE_NUMPAD_0      Numeric keypad '0' key.      144
KEYCODE_NUMPAD_1      Numeric keypad '1' key.      145
KEYCODE_NUMPAD_2      Numeric keypad '2' key.      146
KEYCODE_NUMPAD_3      Numeric keypad '3' key.      147
KEYCODE_NUMPAD_4      Numeric keypad '4' key.      148
KEYCODE_NUMPAD_5      Numeric keypad '5' key.      149
KEYCODE_NUMPAD_6      Numeric keypad '6' key.      150
KEYCODE_NUMPAD_7      Numeric keypad '7' key.      151
KEYCODE_NUMPAD_8      Numeric keypad '8' key.      152
KEYCODE_NUMPAD_9      Numeric keypad '9' key.      153
KEYCODE_NUMPAD_ADD      Numeric keypad '+' key       157
KEYCODE_NUMPAD_COMMA      Numeric keypad ',' key       159
KEYCODE_NUMPAD_DIVIDE      Numeric keypad '/' key       154
KEYCODE_NUMPAD_DOT      Numeric keypad '.' key       158
KEYCODE_NUMPAD_EQUALS      Numeric keypad '=' key.      161
KEYCODE_NUMPAD_LEFT_PAREN   Numeric keypad '(' key.      162
KEYCODE_NUMPAD_MULTIPLY      Numeric keypad '*' key      155
KEYCODE_NUMPAD_RIGHT_PAREN   Numeric keypad ')' key.      163
KEYCODE_NUMPAD_SUBTRACT      Numeric keypad '-' key      156
KEYCODE_NUMPAD_ENTER      Numeric keypad Enter key.   160
KEYCODE_NUM_LOCK      Numeric keypad Num Lock key.   143


KEYCODE_MEDIA_FAST_FORWARD   Fast Forward media key.      90
KEYCODE_MEDIA_NEXT      Play Next media key.      87
KEYCODE_MEDIA_PAUSE      Pause media key.      127
KEYCODE_MEDIA_PLAY      Play media key.         126
KEYCODE_MEDIA_PLAY_PAUSE   Play/Pause media key.      85
KEYCODE_MEDIA_PREVIOUS      Play Previous media key.   88
KEYCODE_MEDIA_RECORD      Record media key.      130
KEYCODE_MEDIA_REWIND      Rewind media key.      89
KEYCODE_MEDIA_STOP      Stop media key.         86
]]]=]},
{"获取屏幕尺寸",[[import "android.util.DisplayMetrics"
import "java.lang.Math"

local function getScreenPhysicalSize(ctx)
  local dm = DisplayMetrics()
  ctx.getWindowManager().getDefaultDisplay().getMetrics(dm)
  return Math.sqrt(Math.pow(dm.widthPixels, 2) + Math.pow(dm.heightPixels, 2)) / (160 * dm.density);
end

print(getScreenPhysicalSize(activity))]]},
{"发送邮件",[[import "android.content.Intent"

local i = Intent(Intent.ACTION_SEND)
i.setType("message/rfc822")--发送内容的类型
i.putExtra(Intent.EXTRA_EMAIL, {"2113075983@.com"})--可发送多个收件人
i.putExtra(Intent.EXTRA_SUBJECT,"Feedback")--邮件的主题
i.putExtra(Intent.EXTRA_TEXT,"Content")--邮件的内容
activity.startActivity(Intent.createChooser(i, "Choice"))--创建应用选择]]},
{"更改对话框标题、消息与按钮颜色",[[自定义默认弹窗标题,消息,按钮的颜色
local dialog=AlertDialog.Builder(this)
.setTitle("标题")
.setMessage("消息")
.setPositiveButton("积极",nil)
.setNeutralButton("中立",nil)
.setNegativeButton("否认",nil)
.show()

--消息
message=dialog.findViewById(android.R.id.message)
message.setTextColor(0xff1DA6DD)

--按钮
dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff1DA6DD)--积极
dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff1DA6DD)--消极
dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff1DA6DD)--中立

--标题
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
local sp = SpannableString("标题")
sp.setSpan(ForegroundColorSpan(0xff1DA6DD),0,utf8.len(tostring(sp)),Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
dialog.setTitle(sp)
--也可以使用 dialog.setCustomTitle(view) 方法将原有标题设为一个自定义控件]]},
{"使用 TTS 播报语音",[=[import "android.speech.tts.*"

local mTextSpeech = TextToSpeech(activity, TextToSpeech.OnInitListener{
  onInit=function(status)
    --如果装载TTS成功
    if (status == TextToSpeech.SUCCESS)
      result = mTextSpeech.setLanguage(Locale.CHINESE);
      --[[LANG_MISSING_DATA-->语言的数据丢失
          LANG_NOT_SUPPORTED-->语言不支持]]
      if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
        --不支持中文
        print("您的手机不支持中文语音播报功能。");
        result = mTextSpeech.setLanguage(Locale.ENGLISH);
        if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
          --不支持中文和英文
          print("您的手机不支持语音播报功能。");
         else
          --不支持中文但支持英文
          --语调,1.0默认
          mTextSpeech.setPitch(1);
          --语速,1.0默认
          mTextSpeech.setSpeechRate(1);
          mTextSpeech.speak("Hello,World!", TextToSpeech.QUEUE_FLUSH, nil);
        end
       else
        --支持中文
        --语调,1.0默认
        mTextSpeech.setPitch(1);
        --语速,1.0默认
        mTextSpeech.setSpeechRate(1);
        mTextSpeech.speak("你好，世界！", TextToSpeech.QUEUE_FLUSH, nil);
      end
    end
  end
})]=]},
{"关于 TextView 的字体大小",[[activity.setContentView(loadlayout({
  LinearLayout,
  orientation="vertical",
  {
    TextView,
    text="关于textSize与TextSize的单位问题",
    layout_height="56dp",
    textSize="18dp";
    gravity="center";
    paddingLeft="18dp";
    textColor=文字色;
    maxLines=1;
  },
  {
    ScrollView,
    layout_width="fill",
    layout_height="fill",
    {
      LinearLayout,
      orientation="vertical",
      layout_width="fill",
      layout_height="fill",
      padding="8dp";
      {
        TextView,
        text="textSize 14dp Hello World",
        textColor=文字色;
        textSize="14dp";
      },
      {
        TextView,
        text="textSize 14sp Hello World",
        textColor=文字色;
        textSize="14sp";
      },
      {
        TextView,
        text="textSize 14 Hello World",
        textColor=文字色;
        textSize=14;
      },
      {
        TextView,
        text="TextSize 14dp Hello World",
        textColor=文字色;
        TextSize="14dp";
      },
      {
        TextView,
        text="TextSize 14sp Hello World",
        textColor=文字色;
        TextSize="14sp";
      },
      {
        TextView,
        text="TextSize 14 Hello World",
        textColor=文字色;
        TextSize=14;
      },
      {
        TextView,
        text="\n通过上面的对比我们可以看到，当使用textSize时,dp、sp和无单位的显示效果是相同的；当使用TextSize时,dp和sp会变成特大，而不带单位则和上面的textSize显示效果相同。\n\n在我们的工程中最好使用textSize+dp，这样在大部分机型都不会出现布局错位及字体特大的情况。",
        textColor=文字色;
        textSize=14;
      },
    },
  };
}))]]},
{"获取字符串 MD5",[[string.md5("wow")]]},
{"适配异形屏的全屏",[[local function fullscreen()
  local window = activity.getWindow()
  window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN)
  window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
  return pcall(function()
    lp = window.getAttributes()
    lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES--Android P
    window.setAttributes(lp)
  end)
end
--使用该代码可能需要隐藏ActionBar]]},
{"跳转悬浮窗权限设置页面",[[import "android.net.Uri"
import "android.content.Intent"
import "android.provider.Settings"

function toFloatWindowPermission()
  local intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION)
  intent.setData(Uri.parse("package:" .. activity.getPackageName()))
  activity.startActivityForResult(intent, 0);
end]]},
{"获取是否允许了悬浮窗权限",[[import "android.provider.Settings"

local function canDrawOverlays()
  if (Build.VERSION.SDK_INT >= 23 and not Settings.canDrawOverlays(this)) then
    return false
   elseif Build.VERSION.SDK_INT < 23 then
    return nil
   else
    return true
  end
end]]},
{"获取与设置 cookie",[[import "android.webkit.CookieSyncManager"
import "android.webkit.CookieManager"

function 设置Cookie(context,url,content)
  CookieSyncManager.createInstance(context)
  local cookieManager = CookieManager.getInstance()
  cookieManager.setAcceptCookie(true)
  cookieManager.removeSessionCookie()
  cookieManager.removeAllCookie()
  cookieManager.setCookie(url, content)
  CookieSyncManager.getInstance().sync()
end

function 获取Cookie(url)
  local cookieManager = CookieManager.getInstance();
  return cookieManager.getCookie(url);
end

--示例
--获取https://www.baidu.com的cookie并打印
print(获取Cookie("https://www.baidu.com"))
--设置https://www.baidu.com的cookie为This is cookie
设置Cookie(activity,"https://www.baidu.com","This is cookie")
--获取https://www.baidu.com的cookie并打印
print(获取Cookie("https://www.baidu.com"))]]},
{"获取储存空间",[[--内置存储剩余空间
 local function GetSurplusSpace()
 local fs =  StatFs(Environment.getDataDirectory().getPath())
 return Formatter.formatFileSize(activity, (fs.getAvailableBytes()))
 end

 --内置存储总空间
 local function GetTotalSpace()
 local path = Environment.getExternalStorageDirectory()
 local stat = StatFs(path.getPath())
 local blockSize,totalBlocks = stat.getBlockSize(),stat.getBlockCount()
 return Formatter.formatFileSize(activity, blockSize * totalBlocks)
 end]]},
{"获取视频第一帧",[[import "android.media.MediaMetadataRetriever"

local function GetVideoFrame(path)
  local media = MediaMetadataRetriever()
  media.setDataSource(tostring(path))
  return media.getFrameAtTime()--不传入时间参数时默认返回第一帧的bitmap
end]]},
{"文件选择模块",[[import "android.widget.ArrayAdapter"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "java.io.File"
import "android.widget.ListView"
import "android.app.AlertDialog"

local function ChoiceFile(StartPath,callback)--第一个参数为初始化路径,第二个为回调函数
  --创建ListView作为文件列表
  lv=ListView(activity).setFastScrollEnabled(true)
  --创建路径标签
  cp=TextView(activity)
  lay=LinearLayout(activity).setOrientation(1).addView(cp).addView(lv)
  ChoiceFile_dialog=AlertDialog.Builder(activity)--创建对话框
  .setTitle("选择文件")
  .setView(lay)
  .show()
  adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
  lv.setAdapter(adp)
  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    cp.Text=tostring(path)--设置当前路径
    if path~="/" then--不是根目录则加上../
      adp.add("../")
    end
    ls=File(path).listFiles()
    if ls~=nil then
      ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
      table.sort(ls,function(a,b)
        return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
      end)
    else
      ls={}
    end
    for index,c in ipairs(ls) do
      if c.isDirectory() then--如果是文件夹则
        adp.add(c.Name.."/")
      else--如果是文件则
        adp.add(c.Name)
      end
    end
  end
  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Text)
    if tostring(cp.Text)=="/" then
      路径=ls[p+1]
    else
      路径=ls[p]
    end

    if 项目=="../" then
      SetItem(File(cp.Text).getParentFile())
    elseif 路径.isDirectory() then
      SetItem(路径)
    elseif 路径.isFile() then
      callback(tostring(路径))
      ChoiceFile_dialog.hide()
    end

  end

  SetItem(StartPath)
end

--ChoiceFile(StartPath,callback)]]},
{"路径选择模块",[=[import "android.widget.ArrayAdapter"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "java.io.File"
import "android.widget.ListView"
import "android.app.AlertDialog"

local function ChoicePath(StartPath,callback)--第一个参数为初始化路径,第二个为回调函数
  --创建ListView作为文件列表
  lv=ListView(activity).setFastScrollEnabled(true)
  --创建路径标签
  cp=TextView(activity)
  lay=LinearLayout(activity).setOrientation(1).addView(cp).addView(lv)
  ChoiceFile_dialog=AlertDialog.Builder(activity)--创建对话框
  .setTitle("选择路径")
  .setPositiveButton("OK",{
  onClick=function()
  callback(tostring(cp.Text))
  end})
.setNegativeButton("Canel",nil)
  .setView(lay)
  .show()
  adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
  lv.setAdapter(adp)
  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    cp.Text=tostring(path)--设置当前路径
    if path~="/" then--不是根目录则加上../
      adp.add("../")
    end
    ls=File(path).listFiles()
    if ls~=nil then
      ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
      table.sort(ls,function(a,b)
        return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
      end)
    else
      ls={}
    end
    for index,c in ipairs(ls) do
      if c.isDirectory() then--如果是文件夹则
        adp.add(c.Name.."/")
      end
    end
  end
  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Text)
    if tostring(cp.Text)=="/" then
      路径=ls[p+1]
    else
      路径=ls[p]
    end

    if 项目=="../" then
      SetItem(File(cp.Text).getParentFile())
    elseif 路径.isDirectory() then
      SetItem(路径)
    elseif 路径.isFile() then
      callback(tostring(路径))
      ChoiceFile_dialog.hide()
    end

  end

  SetItem(StartPath)
end

--[[import "android.os.*"
ChoicePath(Environment.getExternalStorageDirectory().toString(),
function(path)
print(path)
end)]]]=]},
{"获取视图中所有文本",[[local function GetAllText(view)
local textTable={}
local function GetText(Parent)
local number=Parent.getChildCount()
for i=0,number do
local view,textview=Parent.getChildAt(i),TextView(activity)
if pcall(function() view.addView(textview) end) then--判断是否viewgroup
view.removeView(textview)
GetText(view)
elseif pcall(function() view.getText() end) then
table.insert(textTable,tostring(view.Text))
end
end
end
GetText(view)
return textTable
end

--print(table.unpack(GetAllText(Parent)))]]},
{"获取控件图片",[[local function getViewBitmap(view)
  local lp = view.getLayoutParams()
  local w,h=lp.width,lp.height
  view.setDrawingCacheEnabled(true)
  view.layout(0,0,vw,vh)
  return view.getDrawingCache()
end

--getViewBitmap(id)]]},
{"控件圆角",[[import "android.graphics.drawable.GradientDrawable"

local function CircleButton(view,InsideColor,radiu)
  local drawable = GradientDrawable() 
  .setShape(GradientDrawable.RECTANGLE) 
  .setColor(InsideColor)
  .setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu})
  --可通过 GradientDrawable 的其他方法实现其他效果
  pcall(function() view.setBackgroundDrawable(drawable) end)
  return drawable
end

--CircleButton(控件id,0xFF00B1FF,50)]]},
{"高斯模糊",[[import "android.renderscript.Element"
import "android.renderscript.Allocation"
import "android.renderscript.RenderScript"
import "android.graphics.Bitmap"
import "android.renderscript.ScriptIntrinsicBlur"
import "android.graphics.Matrix"

function doBlur(bitamp,radius,scale)
    local w = bitmap.getWidth()
    local h = bitmap.getHeight()
    local matrix = Matrix()
    matrix.postScale(scale, scale)--设置缩放
    local bitmap = Bitmap.createBitmap(bitmap, 0, 0, w, h, matrix, false)
    local renderScript = RenderScript.create(context)
    local blurScript = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript))
    local inAllocation = Allocation.createFromBitmap(renderScript, bitmap)
    local outAllocation = Allocation.createTyped(renderScript, inAllocation.getType())
    blurScript.setRadius(blurRadius)--设置模糊半径,范围1~25
    blurScript.setInput(inAllocation)
    blurScript.forEach(outAllocation)
    outAllocation.copyTo(bitmap)
    inAllocation.destroy()
    outAllocation.destroy()
    renderScript.destroy()
    blurScript.destroy()
    return bitmap
end]]},
{"匹配字符串中的中文内容",[[local function filter_spec_chars(s)
	local ss = {}
	for k = 1, #s do
		local c = string.byte(s,k)
		if not c then break end
		if (c>=48 and c<=57) or (c>= 65 and c<=90) or (c>=97 and c<=122) then
			if not string.char(c):find("%w") then
   table.insert(ss, string.char(c))
	end
 	elseif c>=228 and c<=233 then
			local c1 = string.byte(s,k+1)
			local c2 = string.byte(s,k+2)
			if c1 and c2 then
				local a1,a2,a3,a4 = 128,191,128,191
				if c == 228 then a1 = 184
				elseif c == 233 then a2,a4 = 190,c1 ~= 190 and 191 or 165
				end
				if c1>=a1 and c1<=a2 and c2>=a3 and c2<=a4 then
					k = k + 2
					table.insert(ss, string.char(c,c1,c2))
				end
			end
		end
	end
	return table.concat(ss)
end
print(filter_spec_chars("A1B2汉C3D4字E5F6,,,"))
--来源网络,加了个if过滤掉英文与数字,使其只捕获中文]]},
{"json 与 table 互相转换",[[local js=import "cjson"

--json
local json_str=[==[
[
    {
		"title": "第一本书",
		"bookId": "book_1"
	},
	{
		"title": "第二本书",
		"bookId": "book_2"
	}
]
]==]
--解析成lua table
local json_table=js.decode(json_str)
print(dump(json_table))

--lua table
local lua_table={
"hello, world!",
{"table in table"},
key="value",
}
--解析成json
local json_table=js.encode(json_str)
print(json_table)]]},
{"播放音视频",[[import "android.media.MediaPlayer"
local mediaPlayer =  MediaPlayer()

--设置播放资源
mediaPlayer.setDataSource("storage/sdcard0/a.mp3")

--开始缓冲资源
mediaPlayer.prepare()

--是否循环播放该资源
mediaPlayer.setLooping(true)

--缓冲完成的监听
mediaPlayer.setOnPreparedListener(MediaPlayer.OnPreparedListener{
    onPrepared=function(mediaPlayer)
        mediaPlayer.start()
   end})

--是否在播放
mediaPlayer.isPlaying()

--暂停播放
mediaPlayer.pause()

--从30位置开始播放
mediaPlayer.seekTo(30)

--停止播放
mediaPlayer.stop()

--播放视频
--视频的播放与音乐播放过程一样：

--先创建一个媒体对象
import "android.media.MediaPlayer"
local mediaPlayer =  MediaPlayer()

--设置播放资源
mediaPlayer.setDataSource("storage/sdcard0/a.mp4")

--拿到显示的SurfaceView
local sh = surfaceView.getHolder()
sh.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS)

--设置显示SurfaceView
mediaPlayer.setDisplay(sh)

--设置音频流格式
mediaPlayer.setAudioStreamType(AudioManager.Stream_Music)

--开始缓冲资源
mediaPlayer.prepare()

--缓冲完成的监听
mediaPlayer.setOnPreparedListener(MediaPlayer.OnPreparedListener{
   onPrepared=function(mediaPlayer)
		--开始播放
        mediaPlayer.start()
   end})

--重置
mediaPlayer.reset()

--释放播放器
mediaPlayer.release()]]},
{"获取系统SDK，Android版本及设备型号",[[import "android.os.Build"
device_model = Build.MODEL --设备型号 
version_sdk = Build.VERSION.SDK --安卓SDK版本 
version_release = Build.VERSION.RELEASE --安卓系统版本]]},
{"控件颜色修改",[[import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"

--按钮
button.getBackground().setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP));--第二个参数为绘制模式

--编辑框
edittext.getBackground().setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP));

--Switch
switch.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP));
switch.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP))

--ProgressBar
progressbar.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP))

--SeekBar滑条
seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP))
--SeekBar滑块
seekbar.Thumb.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP))]]},
{"查询本地所有视频、图片",[[import "android.provider.MediaStore"
local cursor = activity.ContentResolver

local function QueryAllVideo()
local mImageUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
local mCursor = cursor.query(mImageUri,nil,nil,nil,MediaStore.Video.Media.DATE_TAKEN)
mCursor.moveToLast()
local VideoTable={}
while mCursor.moveToPrevious() do
   local path = mCursor.getString(mCursor.getColumnIndex(MediaStore.Video.Media.DATA))
   table.insert(VideoTable,tostring(path))
end
mCursor.close()
return VideoTable--返回储存路径的表
end

local function QueryAllImage()
local mImageUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
localmCursor = cursor.query(mImageUri,nil,nil,nil,MediaStore.Images.Media.DATE_TAKEN)
mCursor.moveToLast()
localimageTable={}
while mCursor.moveToPrevious() do
   localpath = mCursor.getString(mCursor.getColumnIndex(MediaStore.Images.Media.DATA))
   table.insert(imageTable,tostring(path))
end
mCursor.close()
return imageTable--返回储存路径的表
end]]},
{"遍历查找文件",[[function outPath(ret) 
for i,p in pairs(luajava.astable(ret)) do
print(p)
end
end
function find(catalog,name)
 local n=0
 local t=os.clock()
 local ret={}
 require "import"
 import "java.io.File" 
 import "java.lang.String"
 function FindFile(catalog,name)
   local name=tostring(name)
   local ls=catalog.listFiles() or File{}
   for 次数=0,#ls-1 do
     --local 目录=tostring(ls[次数])
     local f=ls[次数]
     if f.isDirectory() then--如果是文件夹则继续匹配
       FindFile(f,name)
     else--如果是文件则
       n=n+1
       if n%1000==0 then
         print(n,os.clock()-t)
       end
      local nm=f.Name
       if string.find(nm,name) then
         --thread(insert,目录)
         table.insert(ret,tostring(f))
       end
     end
   luajava.clear(f)
   end
 end
 FindFile(catalog,name)
 call("outPath",ret)
end

import "java.io.File"
thread(find,File("/sdcard/AndroLua"),".j?pn?g")]]},
{"Environment 获取储存路径",[[import "android.os.Environment"
local sdcard=Environment.getExternalStorageDirectory().getPath()--SD卡
local data=Environment.getDataDirectory().getPath()--根目录下的数据路径
local root=Environment.getRootDirectory().getPath()--根目录
local down=Environment.getDownloadCacheDirectory().getPath()--SD卡目录下的系统下载目录
--未列出所有方法,请自行查看 android.os.Environment 类]]},
{"获取已安装应用的信息",[[
import "android.content.pm.PackageManager"
import "android.content.pm.ApplicationInfo"
local pm = activity.getPackageManager()

--获取基本信息
local function GetApkBaseInfo(archiveFilePath)
local info = pm.getPackageArchiveInfo(archiveFilePath, PackageManager.GET_ACTIVITIES)
if info then
  local appInfo,data = info.applicationInfo,{}
  data.appName = tostring(pm.getApplicationLabel(appInfo))--APP名称
  data.packageName = appInfo.packageName --包名
  data.versionName=info.versionName --版本信息
  data.versionCode=info.versionCode --版本信息 
  data.icon = pm.getApplicationIcon(appInfo)--图标
  return data
end
end

--获取更多信息(包含上面函数的内容)
import "java.util.Calendar"
function GetAppInfo(包名)
  local 包名,data=tostring(包名),{}
  local ai = pm.getApplicationInfo(包名,0)
  data.icon=ai.loadIcon(pm);
  local pkg = pm.getPackageInfo(包名,0)
  data.appName= ai.loadLabel(pm)
  data.versionName= pkg.versionName
  data.versionCode=pkg.versionCode
  local 最后更新时间 = pkg.lastUpdateTime--获取的是数字,需要转换
  local cal = Calendar.getInstance().setTimeInMillis(最后更新时间);
  data.lastUpdate = cal.getTime().toLocaleString()--转换为可读日期
  return data
end]]},
{"判断应用是否安装",[[local function isAppInstalled(packName)
return pcall(function() activity.getPackageManager().getPackageInfo(packName,0) end)
end]]},
{"设置 TextView 字体风格",[[import "android.graphics.Paint"
--删除线
id.getPaint().setFlags(Paint.STRIKE_THRU_TEXT_FLAG)
--下划线
id.getPaint().setFlags(Paint.UNDERLINE_TEXT_FLAG )
--加粗
id.getPaint().setFakeBoldText(true)
--倾斜
id.getPaint().setTextSkewX(0.2)--可左右倾斜,数值越大倾斜程度越大

--设置字型
import "android.graphics.Typeface"
id.getPaint().setTypeface(Typeface tf)
--可选字型
Typeface.DEFAULT -- 默认
Typeface.DEFAULT_BOLD --加粗
Typeface.MONOSPACE --等宽
Typeface.SANS_SERIF --无衬线字体
Typeface.SERIF --衬线字体
--除默认与加粗外,其他字型在更换系统字体后可能无效

--除此之外,可加载本地ttf/otf
Typeface.createFromFile(File("字体文件路径"))
--在更换系统字体后可能无效]]},
{"位图缩放",[[import "android.graphics.Matrix"
import "android.graphics.Bitmap"

local function rotateToFit(bm,degrees)
  local width = bm.getWidth()
  local height = bm.getHeight()
  local matrix = Matrix()
  matrix.postRotate(degrees)
  return Bitmap.createBitmap(bm, 0, 0, width, height, matrix, true)
end

--rotateToFit(BitMap,缩放)]]},
{"Drawable 着色",[[local function TintDrawableColor(drawable,color,mode)--传入drawable,颜色与绘制模式
   --Bitamp可使用BitampDrawable(Bitmap bm)来转换为drawable
   drawable.setColorFilter(PorterDuffColorFilter(color or 0,mode or PorterDuff.Mode.SRC_ATOP))
   return drawable
end]]},
{"保存 Bitmap 到本地",[[import "java.io.FileOutputStream"
import "java.io.File"
import "android.graphics.Bitmap"

local function SavePicture(path,bm)
if bm and path then
local out = FileOutputStream(File(tostring(path)))--文件输出流
bm.compress(Bitmap.CompressFormat.PNG,100,out)--压缩格式,图像品质,输出流
out.flush().close()--写入到内存并关闭
return true
else
return false
end
end]]},
{"调用应用商店搜索应用",[[import "android.content.Intent"
import "android.net.Uri"

local intent = Intent("android.intent.action.VIEW")
intent.setData(Uri.parse( "market://details?id="..activity.getPackageName()))--更改包名来查看其他应用
this.startActivity(intent)]]},
{"分享文字内容与文件",[[import "android.webkit.MimeTypeMap"
import "android.content.Intent"
import "android.content.FileProvider"
import "android.net.Uri"
import "java.io.File"

--分享文件
local function shareFile(path)
  local file=File(tostring(path))
  --获取文件后缀,获取MimeType
  local ExtensionName=file.Name:match("%.(.+)") or ""--如果文件名有多个.则无法正确获取后缀名,请自行修改
  local Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  local intent = Intent(Intent.ACTION_SEND)
  intent.setType(Mime)--mimetype会影响选择器的选项
  --local uri = Uri.fromFile(File(path))
  --从安卓7.0起,不允许直接传入文件路径,将路径暴露给其他应用,请使用以下的FileProvider。
  local uri = FileProvider.getUriForFile(this,this.getPackageNmae(),file)
  intent.putExtra(Intent.EXTRA_STREAM,uri).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(Intent.createChooser(intent, "分享文件"))--选择器的标题可随意更改
end

--分享文字
local function shareText(t)
intent=Intent(Intent.ACTION_SEND)
.setType("text/plain")
.putExtra(Intent.EXTRA_TEXT, t)
.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
activity.startActivity(Intent.createChooser(intent,"分享文字"))
end]]},
{"调用其它程序打开文件",[[import "android.webkit.MimeTypeMap"
import "android.content.Intent"
import "android.net.Uri"
import "android.content.FileProvider"
import "java.io.File"

local function OpenFile(path)
  local file=File(tostring(path))
  local Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(file.Name:match("%.(.+)"))--获取MimeType
  if Mime then 
    local uri = FileProvider.getUriForFile(this,this.getPackageNmae(),file)
    local intent = Intent(Intent.ACTION_VIEW)
    .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    .setDataAndType(uri, Mime)
    activity.startActivity(intent)
  else
    print("找不到可以用来打开此文件的程序")
  end
end]]},
{"Bitmap 圆角",[[import "android.graphics.PorterDuffXfermode"
import "android.graphics.Paint"
import "android.graphics.RectF"
import "android.graphics.Bitmap"
import "android.graphics.PorterDuff$Mode"
import "android.graphics.Rect"
import "android.graphics.Canvas"
import "android.graphics.Bitmap$Config"

local function GetRoundedCornerBitmap(bitmap,roundPx) 
  local width,height=bitmap.getWidth(),bitmap.getHeight()--获取位图高宽
  local output=Bitmap.createBitmap(width,height,Bitmap.Config.ARGB_8888)--创建一个与位图大小一致的新位图
  local canvas=Canvas(output)--画布与笔,用作绘制圆角
  local paint=Paint()
  local rect=Rect(0, 0, width,height)--创建矩形
  local rectF=RectF(rect)
  paint.setAntiAlias(true)--抗锯齿
  canvas.drawRoundRect(rectF, roundPx, roundPx, paint)--绘制一个圆角矩形
  paint.setXfermode(PorterDuffXfermode(Mode.SRC_IN))--设置绘图模式
  canvas.drawBitmap(bitmap, rect, rect, paint)--最后将原bitmap画到画布中
  return output
end

--GetRoundedCornerBitmap(bitmap,角度)]]},
{"跳转QQ群与聊天界面",[[import "android.net.Uri"
import "android.content.Intent"

--网址中的uin参数为群号或Q号
--加群
url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin=383792635&card_type=group&source=qrcode"
activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))

--聊天
url="mqqwpa://im/chat?chat_type=wpa&uin=2113075983"
activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))]]},
{"发送短信",[[import "android.content.Intent"
import "android.net.Uri"
import "android.telephony.SmsManager"

--后台发送短信,不打开短信应用
SmsManager.getDefault().sendTextMessage("号码", nil,"内容", nil, nil)

--调用系统短信应用发送短信
local intent = Intent(Intent.ACTION_SENDTO, Uri.parse("smsto:".."号码")).putExtra("sms_body","内容")
activity.startActivity(intent)]]},
{"判断数组中是否存在某个值",[[--查找value
local function isValueExistsFromTable(table,value)
for k,v in pairs(table) do
if v==value then
return true
end
end
end

--查找key
local function isKeyExistsFromTable(table,value)
for k,v in pairs(table) do
if k==value then
return true
end
end
end]]},
{"剪切板操作",[[import "android.content.Context"
local clip=activity.getSystemService(Context.CLIPBOARD_SERVICE)

local content=clip.getText() --获取剪贴板 

clip.setText("内容") --写入剪贴板]]},
{"Shell执行",[[local function exec(cmd)
local p=io.popen(string.format('%s',cmd))
local s=p:read("*a")
p:close()
return s
end

print(exec("echo  ...."))

部分常用命令:
--删除文件或文件夹
rm -r /路径

--复制文件或文件夹
cp -r inpath outpath

--移动文件,文件夹
mv -r inpath outpath

--挂载系统目录
mount -o remount,rw path

--修改系统文件权限
chmod 755 /system/build.prop

--重启
reboot  

--关机
reboot -p

--重启至recovery
reboot recovery]]},
},
{"网络操作",
{"TrafficStats 类",[==[import "android.net.TrafficStats"

--[[
getMobileRxBytes()  --获取通过Mobile连接收到的字节总数，不包含WiFi
getMobileRxPackets()  --获取Mobile连接收到的数据包总数
getMobileTxBytes()  --Mobile发送的总字节数
getMobileTxPackets()  --Mobile发送的总数据包数
getTotalRxBytes()  --获取总的接受字节数，包含Mobile和WiFi等
getTotalRxPackets()  --总的接受数据包数，包含Mobile和WiFi等
getTotalTxBytes()  --总的发送字节数，包含Mobile和WiFi等
getTotalTxPackets()  --发送的总数据包数，包含Mobile和WiFi等
getUidRxBytes(int uid)  --获取某个网络UID的接受字节数
getUidTxBytes(int uid) --获取某个网络UID的发送字节数
]]

--例:
print(TrafficStats.getTotalRxBytes())]==]},
{"开启关闭 WiFi",[[import "android.content.Context"

local wifi = activity.getSystemService(Context.WIFI_SERVICE)
wifi.setWifiEnabled(true)]]},
{"断开网络",[[import "android.content.Context"

local wifi = activity.getSystemService(Context.WIFI_SERVICE)
wifi.disconnect()]]},
{"WiFi 是否打开",[[import "android.content.Context"

local wifi = activity.getSystemService(Context.WIFI_SERVICE)
local enabled = wifi.isWifiEnabled()
print(enabled)]]},
{"数据网络是否连接",[[import "android.content.Context"

local manager = activity.getSystemService(Context.CONNECTIVITY_SERVICE)
local gprs = manager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE).getState()
local isMobileData=tostring(gprs)=="CONNECTED"
print(isMobileData)]]},
{"获取 WiFi 信息",[[import "android.content.Context"

local wifi = activity.getSystemService(Context.WIFI_SERVICE)
local config=wifi.getConfiguredNetworks()
print(config)]]},
{"获取 WiFi 状态",[[import "android.content.Context"

local wifi = activity.getSystemService(Context.WIFI_SERVICE)
local state=wifi.getWifiState()
print(state)]]},
{"获取 IP 地址",[[import "java.net.InetAddress"
--查看某网站IP地址
local webIp=InetAddress.getByName("www.10010.com");
print(webIp)

--查看本机IP地址
local localhost=InetAddress.getLocalHost();
print(localhost)

--查看IP地址
import "android.text.format.Formatter"
import "android.content.Context"

local hdcp = activity.getSystemService(Context.WIFI_SERVICE).getDhcpInfo()
local ipAddress=Formatter.formatIpAddress(hdcp.ipAddress)
print(ipAddress)]]},
{"获取 DNS",[[import "android.content.Context"
import "android.text.format.Formatter"

local hdcp = activity.getSystemService(Context.WIFI_SERVICE).getDhcpInfo()
local DNS1=Formatter.formatIpAddress(hdcp.dns1)
local DNS2 = Formatter.formatIpAddress(hdcp.dns2)
print(DNS1,DNS2)]]},
{"获取网络名称",[[import "android.content.Context"

local wifiManager=activity.getSystemService(Context.WIFI_SERVICE);
local wifiInfo=wifiManager.getConnectionInfo();
local ssid=wifiInfo.getSSID()
print(ssid)]]},
{"获取 WiFi 加密类型",[[import "android.content.Context"
import "android.net.wifi.WifiConfiguration$KeyMgmt"--密钥管理方案类

local config = activity.getSystemService(Context.WIFI_SERVICE).getConfiguredNetworks()--返回一个arraylist
local wifi=config[0]--获取某个WiFi配置数据,index 从 0 开始
local wifi=wifi.allowedKeyManagement--获取密钥管理

local function getKeyMgmt(wifi)--判断加密类型
  if wifi.get(KeyMgmt.WPA_PSK) then
    return KeyMgmt.WPA_PSK
   elseif wifi.get(KeyMgmt.WPA_EAP) then
    return KeyMgmt.WPA_EAP
   elseif wifi.get(KeyMgmt.IEEE8021X) then
    return KeyMgmt.IEEE8021X
   else
    return KeyMgmt.NONE--无加密
  end
end

print(getKeyMgmt(wifi))]]},
{"获取网络信号强度",[[import "android.content.Context"

local wifiManager=activity.getSystemService(Context.WIFI_SERVICE)
local wifiInfo=wifiManager.getConnectionInfo()
local rssi=wifiInfo.getRssi()
print(rssi)]]},
{"获取隐藏 SSID",[[import "android.content.Context"

local wifiManager=activity.getSystemService(Context.WIFI_SERVICE)
local wifiInfo=wifiManager.getConnectionInfo()
print(wifiInfo.getHiddenSSID())]]},
{"获取Mac地址",[[import "android.content.Context"

local wifiManager=activity.getSystemService(Context.WIFI_SERVICE)
local wifiInfo=wifiManager.getConnectionInfo()
print( wifiInfo.getMacAddress())]]},
},
{
"文件操作",
{"新建文件",[[import "java.io.File"--File类
File("文件路径").createNewFile()

--Lua io库
io.open("文件路径", 'w')]]},
{"新建文件夹",[[import "java.io.File"--File类
File("文件夹路径").mkdir()

--创建多级文件夹
File("文件夹路径").mkdirs()

--Shell 命令
os.execute("mkdir 文件夹路径")]]},
{"重命名与移动文件",[[--Shell 命令
os.execute("mv "..oldname.." "..newname)

--Lua os库
os.rename (oldname, newname)

import "java.io.File"--File类
File(旧).renameTo(File(新))]]},
{"追加更新文件",[[io.open(文件路径,"a+"):write("更新的内容"):close()]]},
{"更新文件",[[io.open(文件路径,"w+"):write("更新的内容"):close()]]},
{"写入文件",[[io.open(文件路径,"w"):write("内容"):close()]]},
{"写入文件(自动创建父文件夹)",[[import "java.io.File"

local function 写入文件(路径,内容)
  local f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w"):write(tostring(内容)):close()
end]]},
{"读取文件",[[io.open(文件路径):read("*a")]]},
{"按行读取文件",[[for c in io.lines(文件路径) do
print(c)
end]]},
{"删除文件或文件夹",[[import "java.io.File"--File类
File("文件路径").delete()

--Lua os
os.remove (filename)]]},
{"复制文件",[[import "com.androlua.LuaUtil"

LuaUtil.copyDir("源路径","目标路径")]]},
{"递归删除文件夹或文件",[[import "com.androlua.LuaUtil"
LuaUtil.rmDir(路径)

--Shell 命令
os.execute("rm -r 路径")]]},
{"替换文件内字符串",[[local function replace(路径,要替换的字符串,替换成的字符串)
  local 路径=tostring(路径)
  local 内容=io.open(路径):read("*a")
  io.open(路径,"w+"):write(tostring(内容:gsub(要替换的字符串,替换成的字符串))):close()
  --建议先用string.gfind再替换,否则gsub("g","ggg")这类替换会导致程序卡死
end]]},
{"获取文件列表",[[import "java.io.File"--File类
luajava.astable(File("文件夹路径").listFiles())]]},
{"获取文件名称",[[import "java.io.File"--File类
File(路径).Name]]},
{"获取文件大小",[[import "java.io.File"
import "android.text.format.Formatter"

local function getFileSize(path)
  local size=File(tostring(path)).length()
  return Formatter.formatFileSize(activity, size)
end]]},
{"获取文件或文件夹最后修改时间",[[import "java.io.File"
import "java.util.Calendar"

local function getFileLastUpdateTime(path)
  local time = File(tostring(path)).lastModified()
  local cal = Calendar.getInstance();.setTimeInMillis(time)
  return cal.getTime().toLocaleString()--转换可读日期
end]]},
{"获取文件父文件夹路径",[[import "java.io.File"--File类

File("path").getParentFile()]]},
{"获取文件 MimeType",[[import "android.webkit.MimeTypeMap"

local function GetFileMime(name)
return tostring(MimeTypeMap.getSingleton().getMimeTypeFromExtension(tostring(name):match("%.(.+)")))
end

print(GetFileMime("/sdcard/a.png"))]]},
{"判断路径是不是文件夹",[[import "java.io.File"--File类

File("路径").isDirectory()--也可用来判断文件夹存不存在]]},
{"判断文件或文件夹存不存在",[[import "java.io.File"--File类
File("路径").exists()]]},
{"判断是不是隐藏文件",[[import "java.io.File"--File类
File("路径").isHidden()]]},
},
{
"用户界面",
{"标题栏(ActionBar)",[[--部分常用API
show:显示
hide:隐藏
Elevation:设置阴影
BgroundDrawable:设置背景
DisplayHomeAsUpEnabled(boolean):设置是否显示返回图标

--设置标题
activity.ActionBar.setTitle('大标题')
activity.ActionBar.setSubTitle("小标题")

--设置ActionBar背景颜色
import "android.graphics.drawable.ColorDrawable"
activity.ActionBar.setBackgroundDrawable(ColorDrawable(Color))

--自定义ActionBar标题颜色
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
sp = SpannableString("标题")
sp.setSpan(ForegroundColorSpan(0xff1DA6DD),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.ActionBar.setTitle(sp)

--自定义ActionBar布局
DisplayShowCustomEnabled(true)
CustomView(loadlayout(layout))

--ActionBar返回按钮
activity.ActionBar.setDisplayHomeAsUpEnabled(true)
--自定义返回按钮图标
activity.ActionBar.setHomeAsUpIndicator(drawable)

--菜单
function onCreateOptionsMenu(menu)
  menu.add("菜单1")
  menu.add("菜单2")
  menu.add("菜单3")
end
function onOptionsItemSelected(item)
  print("你选择了:"..item.Title)
end

--Tab导航使用
import "android.app.ActionBar$TabListener"
actionBar=activity.ActionBar
actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);
tab = actionBar.newTab().setText("Tab1").setTabListener(TabListener({
  onTabSelected=function()
    print"Tab1"
  end}))
tab2=actionBar.newTab().setText("Tab2").setTabListener(TabListener({
  onTabSelected=function()
    print"Tab2"
  end}))
actionBar.addTab(tab)
actionBar.addTab(tab2)]]},
{"五大布局",[==[--Android中常用的5大布局方式有以下几种：
--线性布局（LinearLayout）：按照垂直或者水平方向布局的组件。
--帧布局（FrameLayout）：组件从屏幕左上方布局组件。
--表格布局（TableLayout）：按照行列方式布局组件。
--相对布局（RelativeLayout）：相对其它组件的布局方式。
--绝对布局（AbsoluteLayout）：按照绝对坐标来布局组件。

1.线性布局(LinearLayout)
线性布局是Android开发中最常见的一种布局方式，它是按照垂直或者水平方向来布局，通过orientation属性可以设置线性布局的方向。属性值有垂直（vertical）和水平（horizontal）两种。
常用的属性：
orientation：可以设置布局的方向
gravity:用来控制组件的对齐方式
layout_weight控制各个控件在布局中的相对大小,layout_weight的属性是一个非负整数值。  
线性布局会根据该控件layout_weight值与其所处布局中所有控件layout_weight值之和的比值为该控件分配占用的区域
--[[例如，在水平布局的LinearLayout中有两个Button，这两个Button的layout_weight属性值都为1,那么这两个按钮都会被拉伸到整个屏幕宽度的一半。如果layout_weight指为0，控件会按原大小显示，不会被拉伸.
对于其余layout_weight属性值大于0的控件，系统将会减去layout_weight属性值为0的控件的宽度或者高度,再用剩余的宽度或高度按相应的比例来分配每一个控件显示的宽度或高度]]

2.帧布局(FrameLayout)
帧布局是从屏幕的左上角（0,0）坐标开始布局，多个组件层叠排列，第一个添加的组件放到最底层，最后添加到框架中的视图显示在最上面。上一层的会覆盖下一层的控件。

3.表格布局（TableLayout）
表格布局是一个ViewGroup以表格显示它的子视图（view）元素，即行和列标识一个视图的位置。
表格布局常用的属性如下：
collapseColumns：隐藏指定的列
shrinkColumns：收缩指定的列以适合屏幕，不会挤出屏幕
stretchColumns：尽量把指定的列填充空白部分
layout_column:控件放在指定的列
layout_span:该控件所跨越的列数

4.相对布局（RelativeLayout）
相对布局是按照组件之间的相对位置来布局，比如在某个组件的左边，右边，上面和下面等。

5.绝对布局(AbsoluteLayout)
采用坐标轴的方式定位组件，左上角是（0，0）点，往右x轴递增，往下Y轴递增,组件定位属性为layout_x 和layout_y来确定坐标。]==]},
{"Widget(普通控件)",[[--Button(按钮控件)、TextView(文本控件)、EditText(编辑框控件)

常用API:
id.setText("文本")--设置控件文本
id.getText()--获取控件文本
id.setWidth(300)--设置控件宽度
id.setHeight(300)--设置控件高度

--点击事件
id.onClick=function()
print"你触发了点击事件"
end

--长按事件
id.onLongClick=function()
print"你触发了长按事件"
end

--图片控件(ImageView与ImageButton)
--设置图片
--布局表中用src属性就可以，如:src=图片路径,

--动态设置
id.setImageBitmap(loadbitmap(图片路径))
--设置Drawable对象
import "android.graphics.drawable.BitmapDrawable"
id.setImageDrawable(BitmapDrawable(loadbitmap(图片路径)))

--缩放，scaleType
--字段
CENTER    --按原来size居中显示，长/宽超过View的长/宽，截取图片的居中部分显示 
CENTER_CROP    --按比例扩大图片的size居中显示，使图片长(宽)等于或大于View的长(宽) 
CENTER_INSIDE  --完整居中显示，按比例缩小使图片长/宽等于或小于View的长/宽 
FIT_CENTER     --按比例扩大/缩小到View的宽度，居中显示 
FIT_END        --按比例扩大/缩小到View的宽度，显示在View的下部分位置 
FIT_START      --按比例扩大/缩小到View的宽度，显示在View的上部分位置 
FIT_XY         --不按比例扩大/缩小到View的大小显示 
MATRIX         --用矩阵来绘制，动态缩小放大图片来显示。 

--点击与长按事件同上]]},
{"Check View(检查控件)",[[--CheckBox(复选框),Switch(开关控件),ToggleButton(切换按钮)
--直接判断是否选中然后执行相应事件即可
--判断API
check.isSelected()--返回布尔值

--RadioButton(单选按钮)与RadioGroup
--将RadioButton的父布局设定为RadioGroup然后绑定下面的监听即可
rp.setOnCheckedChangeListener{
  onCheckedChanged=function(g,c)
  l=g.findViewById(c)
  print(l.Text)
  end}]]},
{"SeekBar(拖动条)",[[--绑定监听
seekbar.setOnSeekBarChangeListener{
onStartTrackingTouch=function()
--开始拖动
end,
onStopTrackingTouch=function()
--停止拖动
end,
onProgressChanged=function()
--状态改变
end}

--部分API
Progress--当前进度
Max--最大进度]]},
{"ProgressBar(进度条)",[[--超大号圆形风格
style="?android:attr/progressBarStyleLarge"
--小号风格
style="?android:attr/progressBarStyleSmall"
--标题型风格
style="?android:attr/progressBarStyleSmallTitle"
--长形进度条
style="?android:attr/progressBarStyleHorizontal"

--部分API
max --最大进度值
progress --设置进度值
secondaryProgress="70" --初始化的底层第二个进度值

id.incrementProgressBy(5)
--ProgressBar进度值增加5
id.incrementProgressBy(-5)
--ProgressBar进度值减少5
id.incrementSecondaryProgressBy(5)
--ProgressBar背后的第二个进度条 进度值增加5
id.incrementSecondaryProgressBy(-5)
--ProgressBar背后的第二个进度条 进度值减少5 ]]},
{"Adapter View(适配器控件)",[[--适配器控件主要包括(ListView,GridView,Spinner,ExpandableList等)

--想要动态为此类控件添加项目就必须得要依靠适配器！
--适配器使用
--AarrayAdapter(简单适配器)
--创建项目数组
数据={}
--添加项目数组
for i=1,100 do
table.insert(数据,tostring(i))
end
--创建适配器
array_adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1,String(数据))
--设置适配器
lv.setAdapter(array_adp)

--LuaAdapter(Lua适配器)
--创建自定义项目视图
local item={
  LinearLayout,
  orientation="vertical",
    layout_width="fill",
   {
    TextView,
    id="text",
    layout_margin="15dp",
    layout_width="fill"
  },
}
--创建项目数组
local data={}
--创建适配器
local adp=LuaAdapter(activity,data,item)
--添加数据
for n=1,100 do
  table.insert(data,{text=tostring(n)})
end
--设置适配器
lv.Adapter=adp

--以上的适配器ListView、Spinner与GridView等控件通用
--那么ExpandableListView(折叠列表)怎么办呢？
--别怕，安卓系统还提供了一个ArrayExpandableListAdapter来给我们使用，可以简单的适配ExpandableListView，下面给出实例

local ns={
  "Widget","Check view","Adapter view","Advanced Widget","Layout","Advanced Layout",
}

local wds={
  {"Button","EditText","TextView",
    "ImageButton","ImageView"},
  {"CheckBox","RadioButton","ToggleButton","Switch"},
  {"ListView","ExpandableListView","Spinner"},
  {"SeekBar","ProgressBar","RatingBar",
    "DatePicker","TimePicker","NumberPicker"},
  {"LinearLayout","AbsoluteLayout","FrameLayout"},
  {"RadioGroup","GridLayout",
    "ScrollView","HorizontalScrollView"},
}


local mAdapter=ArrayExpandableListAdapter(activity)
for k,v in ipairs(ns) do
  mAdapter.add(v,wds[k])
end
el.setAdapter(mAdapter)
--这样就实现ExpandableListView项目的适配了


--当然AdapterView的事件响应也是与普通控件不同的。

--ListView与GridView的单击与长按事件
--项目被单击
id.onItemClick=function(l,v,p,i)
print(v.Text)
return true
end
--项目被长按
id.onItemLongClick=function(l,v,p,i)
print(v.Text)
return true
end

--Spinner的项目单击事件
id.onItemSelected=function(l,v,p,i) 
print(v.Text)
end

--ExpandableListView的父项目与子项目单击事件
id.onGroupClick=function(l,v,p,s)
print(v.Text..":GroupClick")
end

id.onChildClick=function(l,v,g,c)
print(v.Text..":ChildClick")
end]]},
{"LuaWebView(浏览器控件)",[[--常用API
id.loadUrl("http://www.androlua.cn")--加载网页
id.loadUrl("file:///storage/sdcard0/index.html")--加载本地文件
id.getTitle()--获取网页标题
id.getUrl()--获取当前Url
id.requestFocusFromTouch()--设置支持获取手势焦点
id.getSettings().setJavaScriptEnabled(true)--设置支持JS
id.setPluginsEnabled(true)--支持插件
id.setUseWideViewPort(false)--调整图片自适应
id.getSettings().setSupportZoom(true)--支持缩放
id.getSettings().setLayoutAlgorithm(LayoutAlgorithm.SINGLE_COLUMN)--支持重新布局
id.supportMultipleWindows()--设置多窗口,需要设置WebChromeClient事件
id.stopLoading()--停止加载
id.getSettings().setUserAgentString("浏览器UA")--设置UA

--状态监听
id.setWebViewClient{
shouldOverrideUrlLoading=function(view,url)
--Url即将跳转
 end,
onPageStarted=function(view,url,favicon)
--网页加载
end,
onPageFinished=function(view,url)
--网页加载完成
end}

--WebChromeClient
id.setWebChromeClient{
  onReceivedTitle=function(view, title)
    --接收到新标题
  end,
  onReceivedIcon=function(view, icon)
    --接收到网站的favicon
  end,
  onProgressChanged=function(view, newProgress)
    --进度改变事件
  end,
  onJsAlert=function(view, url, message, result)
    --prompt是用来提示信息的
    --请务必在处理完事件后调用result.confirm()
    --return true来拦截原有事件
  end,
  onJsConfirm=function(view, url, message, result)
    --confirm是用来让用户确认信息的
    --请务必在处理完事件后调用result.confirm()或result.cancel()
    --return true来拦截原有事件
  end,
  onJsPrompt=function(view, url, message, defaultValue, result) 
    --prompt是用来让用户输入信息的,defaultValue是输入框的默认值
    --请务必在处理完事件后调用result.confirm()或result.cancel()
    --return true来拦截原有事件
  end,
  onConsoleMessage=function(consoleMessage)
    --打印控制台信息
  end}]]},
{"AutoCompleteTextView(自动补全文本框)",[[--适配数据
arr={"Rain","Rain1","Rain2"};
arrayAdapter=LuaArrayAdapter(activity,{TextView,padding="10dp",textSize="18sp",layout_width="fill",textColor="#ff000000"}, String(arr))
actw.setAdapter(arrayAdapter)

Threshold=1--设置输入几个字符后才能出现提示]]},
{"TimePicker(时间选择器)",[[--时间改变监听器
import "android.widget.TimePicker$OnTimeChangedListener"
id.setOnTimeChangedListener{
  onTimeChanged=function(view,时,分)
    print(时,分)
  end}

--部分API
时=id.getCurrentHour()--获取小时
分=id.getCurrentMinute()--获取分钟
id.setIs24HourView(Boolean(true))--设置24小时制]]},
{"DatePicker(日期选择器)",[[getDayOfMonth()--获取选择的天数
getMonth ()--获取选择的月份
getYear()--获取选择的年份
updateDate(2016,1,1)--更新日期]]},
{"NemberPicker(数值选择器)",[[setMinValue(0)--设置最小值
setMaxValue(100)--设置最大值
setValue(50)--设置当前值
getValue()--获取选择的值
OnValueChangedListener--数值改变监听器]]},
{"AlertDialog(对话框)",[[--常用API
.setTitle("标题")--设置标题
.setMessage("设置消息")--设置消息
.setView(loadlayout(layout))--设置自定义视图
.setPositiveButton("积极",{onClick=function() end})--设置积极按钮
.setNeutralButton("中立",nil)--设置中立按钮
.setNegativeButton("否认",nil)--设置否认按钮

--普通对话框
AlertDialog.Builder(this)
.setTitle("标题")
.setMessage("消息")
.setPositiveButton("积极",{onClick=function(v) print"点击了积极按钮"end})
.setNeutralButton("中立",nil)
.setNegativeButton("否认",nil)
.show()

--输入对话框
local InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    TextView;
    id="Prompt",
    textSize="15sp",
    layout_marginTop="10dp";
    layout_marginLeft="3dp",
    layout_width="80%w";
    layout_gravity="center",
    text="输入:";
  };
  {
    EditText;
    hint="输入";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit";
  };
};

AlertDialog.Builder(this)
.setTitle("标题")
.setView(loadlayout(InputLayout))
.setPositiveButton("确定",{onClick=function(v) print(edit.Text)end})
.setNegativeButton("取消",nil)
.show()
import "android.view.View$OnFocusChangeListener"
edit.setOnFocusChangeListener(OnFocusChangeListener{ 
 onFocusChange=function(v,hasFocus)
if hasFocus then
Prompt.setTextColor(0xFD009688)
end
end})

--下载文件对话框
local Download_layout={
  LinearLayout;
  orientation="vertical";
  id="Download_father_layout",
  {
    TextView;
    id="linkhint",
    layout_marginTop="10dp";
    text="下载链接",
    layout_width="80%w";
    textColor=WidgetColors,
    layout_gravity="center";
  };
  {
    EditText;
    id="linkedit",
    layout_width="80%w";
    layout_gravity="center";   
  };
  {
    TextView;
    id="pathhint",
    text="下载路径",
    layout_width="80%w";
    textColor=WidgetColors,
    layout_marginTop="10dp";
    layout_gravity="center";
  };
  {
    EditText;
    id="pathedit",
    layout_width="80%w";
    layout_gravity="center";
  };
};

AlertDialog.Builder(this)
.setTitle("下载文件")
.setView(loadlayout(Download_layout))
.setPositiveButton("下载",{onClick=function(v)
  end})
.setNegativeButton("取消",nil)
.show()

--列表对话框
local items={}
for i=1,5 do
table.insert(items,"项目"..tostring(i))
end
AlertDialog.Builder(this)
.setTitle("列表对话框")
.setItems(items,{onClick=function(l,v) print(items[v+1])end})
.show()

--单选对话框
local 单选列表={}
for i=1,5 do
table.insert(单选列表,"单选项目"..tostring(i))
end
local 单选对话框=AlertDialog.Builder(this)
.setTitle("列表对话框")
.setSingleChoiceItems(单选列表,-1,{onClick=function(v,p)print(单选列表[p+1])end})
单选对话框.show()

--多选对话框
local items={}
for i=1,5 do
table.insert(items,"多选项目"..tostring(i))
end
local 多选对话框=AlertDialog.Builder(this)
.setTitle("多选框")
.setMultiChoiceItems(items, nil,{ onClick=function(v,p)print(items[p+1])end})
多选对话框.show()]]},
{"InputMethodManager(输入法管理器)",[[在Android的开发中，有时候会遇到软键盘弹出时挡住输入框的情况。
这时候可以设置下软键盘的模式就可以了。
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)
有时候需要软键盘不要把我们的布局整体推上去，这时候可以这样：
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN)

模式常量：

软输入区域是否可见。
SOFT_INPUT_MASK_STATE = 0x0f

未指定状态。
SOFT_INPUT_STATE_UNSPECIFIED = 0

不要修改软输入法区域的状态
SOFT_INPUT_STATE_UNCHANGED = 1

隐藏输入法区域（当用户进入窗口时
SOFT_INPUT_STATE_HIDDEN = 2

当窗口获得焦点时，隐藏输入法区域
SOFT_INPUT_STATE_ALWAYS_HIDDEN = 3

显示输入法区域（当用户进入窗口时）
SOFT_INPUT_STATE_VISIBLE = 4

当窗口获得焦点时，显示输入法区域
SOFT_INPUT_STATE_ALWAYS_VISIBLE = 5

窗口应当主动调整，以适应软输入窗口。
SOFT_INPUT_MASK_ADJUST = 0

窗口应当主动调整，以适应软输入窗口。
SOFT_INPUT_MASK_ADJUST = 0xf0

未指定状态，系统将根据窗口内容尝试选择一个输入法样式。
SOFT_INPUT_ADJUST_UNSPECIFIED = 0x00

当输入法显示时，允许窗口重新计算尺寸，使内容不被输入法所覆盖。
不可与SOFT_INPUT_ADJUSP_PAN混合使用；如果两个都没有设置，系统将根据窗口内容自动设置一个选项。
SOFT_INPUT_ADJUST_RESIZE = 0x10

输入法显示时平移窗口。它不需要处理尺寸变化，框架能够移动窗口以确保输入焦点可见。
不可与SOFT_INPUT_ADJUST_RESIZE混合使用；如果两个都没有设置，系统将根据窗口内容自动设置一个选项。
SOFT_INPUT_ADJUST_PAN = 0x20

当用户转至此窗口时，由系统自动设置，所以你不要设置它。
当窗口显示之后该标志自动清除。
SOFT_INPUT_IS_FORWARD_NAVIGATION = 0x100


其它Api参考:
import "android.view.inputmethod.InputMethodManager"
 

调用显示系统默认的输入法
imm =  activity.getSystemService(Context.INPUT_METHOD_SERVICE)
imm.showSoftInput(m_receiverView(接受软键盘输入的视图(View)),InputMethodManager.SHOW_FORCED(提供当前操作的标记，SHOW_FORCED表示强制显示))

如果输入法关闭则打开，如果输入法打开则关闭
imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
imm.toggleSoftInput(0,InputMethodManager.HIDE_NOT_ALWAYS)

获取软键盘是否打开
imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
isOpen=imm.isActive()
--返回一个布尔值

隐藏软键盘
activity.getSystemService(INPUT_METHOD_SERVICE)).hideSoftInputFromWindow(WidgetSearchActivity.this.getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS)

显示软键盘
activity.getSystemService(INPUT_METHOD_SERVICE)).showSoftInput(控件ID, 0)]]},
{"PopupMenu(弹出式菜单)",[[local pop=PopupMenu(activity,view)
menu=pop.Menu
menu.add("项目1").onMenuItemClick=function(a)

end
menu.add("项目2").onMenuItemClick=function(a)

end
pop.show()--显示]]},
{"PopupWindow(弹出式窗口)",[[local pop=PopupWindow(activity)--创建PopWindow
pop.setContentView(布局)--设置布局
pop.setWidth(activity.width)--设置宽度
pop.setHeight(activity.height)--设置高度
pop.setTouchable(true)--设置可触摸
pop.setOutsideTouchable(false)--设置点击外部区域是否可以消失

--设置可弹出输入法
import "android.view.WindowManager"
pop.setFocusable(true)--设置可获得焦点
pop.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)
pop.setInputMethodMode(PopupWindow.INPUT_METHOD_NEEDED)

--显示
pop.showAsDropDown(view,x,y)
pop.showAtLocation(view,gravity,x,y)
--x,y是指以view和gravity为参照的位置偏移]]},
{"Toast(提示)",[[--编写项目时,提示用户的内容不要使用print哦
--默认Toast
Toast.makeText(activity, "内容",Toast.LENGTH_SHORT).show()

--自定义位置Toast
Toast.makeText(activity,"自定义位置Toast", Toast.LENGTH_LONG).setGravity(Gravity.CENTER, 0, 0).show()

--带图片Toast
local 图片=loadbitmap("icon.png")
local toast = Toast.makeText(activity,"带图片的Toast", Toast.LENGTH_LONG)
local toastView = toast.getView()--获取Toast的原视图
local img = ImageView(activity)
img.setImageBitmap(图片)
toastView.addView(img, 0)
toast.show()

--自定义布局Toast
local 布局=loadlayout(layout)
local toast=Toast.makeText(activity,"提示",Toast.LENGTH_SHORT)
toast.setView(布局).show()]]},
{"控件常用属性",[[--EditText(输入框)
singleLine=true--设置单行输入
Error="错误的输入"--设置用户输入了错误的信息时的提醒
MaxLines=5--设置最大输入行数
MaxEms=5--设置每行最大宽度为五个字符的宽度
InputType="number"--设置只可输入数字
Hint="请输入"--设置编辑框为空时的提示文字
text--指定控件当中显示的文字
textSize--指定控件当中字体的大小
hintTextColor--设置编辑框为空时的提示文字的文字颜色

--TextView
sigleLine--如果设置为真的话，则控件的内容在同一行中进行显示
singleLine=true--设置单行输入
MaxLines=5--设置最大输入行数
MaxEms=5--设置每行最大宽度为五个字符的宽度
ellipsize="end"--设置内容超出控件大小时显示...
text--指定控件当中显示的文字
textSize--指定控件当中字体的大小

--ImageView(图片视图)
src="a.png"--设置控件图片资源
ColorFilter=Color.BLUE--设置图片着色
scaleType
控制图片如何resized/moved来匹对ImageView的size。ImageView.ScaleType / scaleType值的意义区别：
CENTER /center 按图片的原来size居中显示，当图片长/宽超过View的长/宽，则截取图片的居中部分显示
CENTER_CROP / centerCrop 按比例扩大图片的size居中显示，使得图片长(宽)等于或大于View的长(宽)
CENTER_INSIDE / centerInside 将图片的内容完整居中显示，通过按比例缩小或原来的size使得图片长/宽等于或小于View的长/宽
FIT_CENTER / fitCenter 把图片按比例扩大/缩小到View的宽度，居中显示
FIT_END / fitEnd 把图片按比例扩大/缩小到View的宽度，显示在View的下部分位置
FIT_START / fitStart 把图片按比例扩大/缩小到View的宽度，显示在View的上部分位置
FIT_XY / fitXY 把图片不按比例扩大/缩小到View的大小显示
MATRIX / matrix 用矩阵来绘制，动态缩小放大图片来显示。

--ListView(列表视图)
Items={"item1","item2","item3"}--设置列表项目,但只能在布局表设置,动态添加项目请看Adapter View详解。
DividerHeight=0--设置无隔断线
fastScrollEnabled=true--设置是否显示快速滑块

--部分通用属性
layout_marginBottom--离某元素底边缘的距离
layout_marginLeft--离某元素左边缘的距离
layout_marginRight--离某元素右边缘的距离
layout_marginTop--离某元素上边缘的距离
gravity--属性是对该view 内容的限定．比如一个button 上面的text. 你可以设置该text 在view的靠左，靠右等位置．以button为例，gravity="right"则button上面的文字靠右
layout_gravity--是用来设置该view相对与起父view 的位置．比如一个button 在linearlayout里，你想把该button放在靠左、靠右等位置就可以通过该属性设置．以button为例，layout_gravity="right"则button靠右
id--为控件指定相应的ID
background--指定该控件所使用的背景色
width--指定控件的宽度
height--指定控件的高度
layout_width--指定Container组件的宽度
layout_height--指定Container组件的高度
layout_weight--View中很重要的属性，按比例划分空间
padding--指定控件的内边距，也就是说控件当中的内容]]},
{"Animation(动画)",[[--动画主要包括以下几种
Alpha:渐变透明度动画效果
Scale:渐变尺寸伸缩动画效果
Translate:画面转换位置移动动画效果
Rotate:画面转换位置移动动画效果

--共有的属性有
Duration --属性为动画持续时间 时间以毫秒为单位
fillAfter --当设置为true,该动画转化在动画结束后被应用
fillBefore --当设置为true,该动画转化在动画开始前被应用
repeatCount--动画的重复次数 
repeatMode --定义重复的行为 
startOffset --动画之间的时间间隔，从上次动画停多少时间开始执行下个动画
id.startAnimation(Animation)--设置控件开始应用这个动画

--动画状态监听
import "android.view.animation.Animation$AnimationListener"
动画.setAnimationListener(AnimationListener{
  onAnimationStart=function()
    print"动画开始"
  end,
onAnimationEnd=function()
  print"动画结束"
  end,
onAnimationRepeat=function()
  print"动画重复"
  end})

--实例
--控件向右旋转180度
Rotate_right=RotateAnimation(180, 0,
Animation.RELATIVE_TO_SELF, 0.5, 
Animation.RELATIVE_TO_SELF, 0.5)
Rotate_right.setDuration(440)
Rotate_right.setFillAfter(true)

--控件向左旋转180度
Rotate_left=RotateAnimation(0, 180,
Animation.RELATIVE_TO_SELF, 0.5, 
Animation.RELATIVE_TO_SELF, 0.5)
Rotate_left.setDuration(440)
Rotate_left.setFillAfter(true)

--动画设置___从上往下平移动画
Translate_up_down=TranslateAnimation(0, 0, 55, 0)
Translate_up_down.setDuration(800)
Translate_up_down.setFillAfter(true)

--动画设置___透明动画
Alpha=AlphaAnimation(0,1)
Alpha.setDuration(800)

--动画参数值
--AlphaAnimation(透明动画)
AlphaAnimation(float fromStart,float fromEnd)
float fromStart 动画起始透明值
float fromEnd 动画结束透明值

--ScaleAnimation(缩放动画)
ScaleAnimation(float fromX, float toX, float fromY, float toY,int pivotXType, float pivotXValue, int pivotYType, float pivotYValue) 
float fromX 动画起始时 X坐标上的伸缩尺寸 
float toX 动画结束时 X坐标上的伸缩尺寸 
float fromY 动画起始时Y坐标上的伸缩尺寸 
float toY 动画结束时Y坐标上的伸缩尺寸 
int pivotXType 动画在X轴相对于物件位置类型 
float pivotXValue 动画相对于物件的X坐标的开始位置 
int pivotYType 动画在Y轴相对于物件位置类型 
float pivotYValue 动画相对于物件的Y坐标的开始位置 

--TranslateAnimation(位移动画)
TranslateAnimation(float fromXDelta, float toXDelta, float fromYDelta, float toYDelta)
float fromXDelta 动画开始的点离当前View X坐标上的差值 
float toXDelta 动画结束的点离当前View X坐标上的差值 
float fromYDelta 动画开始的点离当前View Y坐标上的差值 
float toYDelta 动画结束的点离当前View Y坐标上的差值 

--RotateAnimation(旋转动画)
RotateAnimation(float fromDegrees, float toDegrees, int pivotXType, float pivotXValue, int pivotYType, float pivotYValue) 
float fromDegrees：旋转的开始角度.
float toDegrees：旋转的结束角度.
int pivotXType：X轴的伸缩模式，可以取值为ABSOLUTE、RELATIVE_TO_SELF、RELATIVE_TO_PARENT.
float pivotXValue：X坐标的伸缩值
int pivotYType：Y轴的伸缩模式，可以取值为ABSOLUTE、RELATIVE_TO_SELF、RELATIVE_TO_PARENT.
float pivotYValue：Y坐标的伸缩值.]]},
{"LayoutAnimationController(布局动画控制器)",[[--LayoutAnimationController可以控制一组控件按照规定显示 

--导入类
import "android.view.animation.AnimationUtils"
import "android.view.animation.LayoutAnimationController"

--创建一个Animation对象
animation = AnimationUtils.loadAnimation(activity,android.R.anim.slide_in_left)

--得到对象
lac = LayoutAnimationController(animation)

--设置控件显示的顺序
lac.setOrder(LayoutAnimationController.ORDER_NORMAL)
--LayoutAnimationController.ORDER_NORMAL   顺序显示
--LayoutAnimationController.ORDER_REVERSE 反显示
--LayoutAnimationController.ORDER_RANDOM 随机显示

--设置控件显示间隔时间
lac.setDelay(time)

--设置组件应用
view.setLayoutAnimation(lac)]]},
{"ObjectAnimator(属性动画)",[==[
ObjectAnimator(对象动画)
--属性动画概念：
所谓属性动画：
改变一切能改变的对象的属性值，不同于补间动画
只能改变 alpha，scale，rotate，translate
听着有点抽象，举例子说明。

补间动画能实现的:
1.alpha(透明)
--第一个参数为 view对象,第二个参数为 动画改变的类型,第三,第四个参数依次是开始透明度和结束透明度。
alpha = ObjectAnimator.ofFloat(text, "alpha", 0, 1)
alpha.setDuration(2000)--设置动画时间
alpha.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
alpha.setRepeatCount(-1)--设置动画重复次数，这里-1代表无限
alpha.setRepeatMode(Animation.REVERSE)--设置动画循环模式。
alpha.start()--启动动画。

2.scale(缩放)
animatorSet =  AnimatorSet()--组合动画
scaleX = ObjectAnimator.ofFloat(text, "scaleX", 1, 0)
scaleY = ObjectAnimator.ofFloat(text, "scaleY", 1, 0)
animatorSet.setDuration(2000)
animatorSet.setInterpolator(DecelerateInterpolator());
animatorSet.play(scaleX).with(scaleY)--两个动画同时开始
animatorSet.start();

3.translate(平移)
translationUp = ObjectAnimator.ofFloat(button, "Y",button.getY(), 0)
translationUp.setInterpolator(DecelerateInterpolator())
translationUp.setDuration(1500)
translationUp.start()

4. rotate(旋转)
set =  AnimatorSet()
anim = ObjectAnimator .ofFloat(phone, "rotationX", 0, 180)
anim.setDuration(2000)
anim2 = ObjectAnimator .ofFloat(phone, "rotationX", 180, 0)
anim2.setDuration(2000)
anim3 = ObjectAnimator .ofFloat(phone, "rotationY", 0, 180)
anim3.setDuration(2000)
anim4 = ObjectAnimator .ofFloat(phone, "rotationY", 180, 0)
anim4.setDuration(2000)
set.play(anim).before(anim2)--先执行anim动画之后在执行anim2
set.play(anim3).before(anim4)
set.start()

补间动画不能实现的:
5.android 改变背景颜色的动画实现如下
translationUp = ObjectAnimator.ofInt(button,"backgroundColor",{Color.RED, Color.BLUE, Color.GRAY,Color.GREEN})
translationUp.setInterpolator(DecelerateInterpolator())
translationUp.setDuration(1500)
translationUp.setRepeatCount(-1)
translationUp.setRepeatMode(Animation.REVERSE)
translationUp.setEvaluator(ArgbEvaluator())
translationUp.start()
--[[
ArgbEvaluator：这种评估者可以用来执行类型之间的插值整数值代表ARGB颜色。
FloatEvaluator：这种评估者可以用来执行浮点值之间的插值。
IntEvaluator：这种评估者可以用来执行类型int值之间的插值。
RectEvaluator：这种评估者可以用来执行类型之间的插值矩形值。

由于本例是改变View的backgroundColor属性的背景颜色所以此处使用ArgbEvaluator
]]]==]},
{"overridePendingTransition(窗口切换动画)",[[activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)]]},
},
{"Intent 类",
{"Intent 类介绍",[[Intent（意图）主要是解决Android应用的各项组件之间的通讯。
Intent负责对应用中一次操作的动作、动作涉及数据、附加数据进行描述.
Android则根据此Intent的描述，负责找到对应的组件，将 Intent传递给调用的组件，并完成组件的调用。

因此，Intent在这里起着一个媒体中介的作用
专门提供组件互相调用的相关信息
实现调用者与被调用者之间的解耦。

例如，在一个联系人维护的应用中，当我们在一个联系人列表屏幕(假设对应的Activity为listActivity)上
点击某个联系人后，希望能够跳出此联系人的详细信息屏幕(假设对应的Activity为detailActivity)
为了实现这个目的，listActivity需要构造一个 Intent
这个Intent用于告诉系统，我们要做“查看”动作，此动作对应的查看对象是“某联系人”
然后调用startActivity (Intent intent)，将构造的Intent传入

系统会根据此Intent中的描述到ManiFest中找到满足此Intent要求的Activity，系统会调用找到的 Activity，即为detailActivity，最终传入Intent，detailActivity则会根据此Intent中的描述，执行相应的操作。]]},
{"调用浏览器搜索关键字",[[import "android.content.Intent"
import "android.app.SearchManager"

local intent =  Intent()
intent.setAction(Intent.ACTION_WEB_SEARCH)
intent.putExtra(SearchManager.QUERY,"AndroLua")    
activity.startActivity(intent)]]},
{"调用浏览器打开网页",[[import "android.content.Intent"
import "android.net.Uri"

local url="http://www.lua.org"
local viewIntent =  Intent("android.intent.action.VIEW",Uri.parse(url))
activity.startActivity(viewIntent)]]},
{"打开其它程序",[[import "android.content.Intent"
import "android.content.pm.PackageManager"

local manager = activity.getPackageManager()
local open = manager.getLaunchIntentForPackage("包名")
this.startActivity(open)]]},
{"安装其它程序",[[import "android.content.Intent"
import "android.net.Uri"

local intent = Intent(Intent.ACTION_VIEW)
intent.setDataAndType(Uri.parse("file://安装包路径"), "application/vnd.android.package-archive") 
intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
activity.startActivity(intent)]]},
{"卸载其它程序",[[import "android.net.Uri"
import "android.content.Intent"

local intent =  Intent(Intent.ACTION_DELETE,Uri.parse("package:包名"))
activity.startActivity(intent)]]},
{"播放Mp4",[[import "android.content.Intent"
import "android.net.Uri"

local intent =  Intent(Intent.ACTION_VIEW)
intent.setDataAndType(Uri.parse("file://mp4路径") , "video/mp4")
activity.startActivity(intent)]]},
{"播放Mp3",[[import "android.content.Intent"
import "android.net.Uri"

local intent =  Intent(Intent.ACTION_VIEW)
intent.setDataAndType(Uri.parse("file://mp3路径"), "audio/mp3")
this.startActivity(intent)]]},
{"搜索应用",[[import "android.content.Intent"
import "android.net.Uri"

local intent = Intent("android.intent.action.VIEW")
intent .setData(Uri.parse( "market://details?id="..activity.getPackageName()))
this.startActivity(intent)]]},
{"调用系统设置",[[import "android.content.Intent"
import "android.provider.Settings"

local intent = Intent(Settings.ACTION_SETTINGS)
this.startActivity(intent)

字段列表:
ACTION_SETTINGS	系统设置
CTION_APN_SETTINGS APN设置
ACTION_LOCATION_SOURCE_SETTINGS 位置和访问信息
ACTION_WIRELESS_SETTINGS 网络设置
ACTION_AIRPLANE_MODE_SETTINGS 无线和网络热点设置
ACTION_SECURITY_SETTINGS 位置和安全设置
ACTION_WIFI_SETTINGS 无线网WIFI设置
ACTION_WIFI_IP_SETTINGS 无线网IP设置
ACTION_BLUETOOTH_SETTINGS 蓝牙设置
ACTION_DATE_SETTINGS 时间和日期设置
ACTION_SOUND_SETTINGS 声音设置
ACTION_DISPLAY_SETTINGS 显示设置——字体大小等
ACTION_LOCALE_SETTINGS 语言设置
ACTION_INPUT_METHOD_SETTINGS 输入法设置
ACTION_USER_DICTIONARY_SETTINGS 用户词典
ACTION_APPLICATION_SETTINGS 应用程序设置
ACTION_APPLICATION_DEVELOPMENT_SETTINGS 应用程序设置
ACTION_QUICK_LAUNCH_SETTINGS 快速启动设置
ACTION_MANAGE_APPLICATIONS_SETTINGS 已下载（安装）软件列表
ACTION_SYNC_SETTINGS 应用程序数据同步设置
ACTION_NETWORK_OPERATOR_SETTINGS 可用网络搜索
ACTION_DATA_ROAMING_SETTINGS 移动网络设置
ACTION_INTERNAL_STORAGE_SETTINGS 手机存储设置]]},
{"调用系统打开文件",[[local function OpenFile(path)
  import "android.webkit.MimeTypeMap"
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.io.File"
  local Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(tostring(File(path).Name):match("%.(.+)"))
  if Mime then 
    local intent = Intent(Intent.ACTION_VIEW)
    .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    .setDataAndType(Uri.fromFile(File(path)), Mime)
    activity.startActivity(intent)
return true
  else
    return false
  end
end]]},
{"调用图库选择图片",[[
import "android.provider.MediaStore"
import "android.content.Intent"

 local intent= Intent(Intent.ACTION_PICK)
  intent.setType("image/*")
  this.startActivityForResult(intent, 1)

--回调
function onActivityResult(requestCode,resultCode,intent)
  if intent then
    local cursor =this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
    cursor.moveToFirst()
    local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
    local selectedPath = cursor.getString(idx)
  end
end]]},
{"调用文件管理器选择文件",[[import "android.content.Intent"
import "android.net.Uri"
import "java.net.URLDecoder"
import "java.io.File"

local function ChooseFile()
local intent = Intent(Intent.ACTION_GET_CONTENT)
.setType("*/")
.addCategory(Intent.CATEGORY_OPENABLE)
activity.startActivityForResult(intent,1)
function onActivityResult(requestCode,resultCode,data)
  if resultCode == Activity.RESULT_OK then
  local str = data.getData().toString()
  local decodeStr = URLDecoder.decode(str,"UTF-8")
  print(decodeStr)
  end
end
end]]},
{"分享文件",[[import "android.webkit.MimeTypeMap"
import "android.content.Intent"
import "android.net.Uri"
import "java.io.File"

local function Sharing(path)
  local Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(tostring(File(path).Name):match("%.(.+)"))
  local intent = Intent(Intent.ACTION_SEND)
  .setType(Mime)
  .putExtra(Intent.EXTRA_STREAM,Uri.fromFile(File(path)))
  .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(Intent.createChooser(intent, "分享到:"))
end)]]},
{"发送短信",[[import "android.net.Uri"
import "android.content.Intent"

local intent = Intent(Intent.ACTION_SENDTO,Uri.parse("smsto:10010"))
intent.putExtra("sms_body","消息内容") 
activity.startActivity(intent)]]},
{"发送彩信",[[import "android.net.Uri"
import "android.content.Intent"

local intent= Intent(Intent.ACTION_SEND)
.putExtra("address",mobile) --邮件地址
.putExtra("sms_body",content) --邮件内容
.putExtra(Intent.EXTRA_STREAM,Uri.parse("file://文件路径"))
.setType("image/png") --设置类型
this.startActivity(intent)]]},
{"拨打电话",[[import "android.net.Uri"
import "android.content.Intent"

local intent = Intent(Intent.ACTION_CALL, Uri.parse("tel:10010"))
activity.startActivity(intent)]]},
},
{"笔记(来自烧风)",
{"沉浸状态栏",[[import "android.view.WindowManager"

local window=activity.getWindow()
if Build.VERSION.SDK_INT >= 21 then
window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff4285f4);
elseif Build.VERSION.SDK_INT >= 19 then
window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
end]]},
{"activity 跳转动画",[[android.R.anim.accelerate_decelerate_interpolator
android.R.anim.accelerate_interpolator
android.R.anim.anticipate_interpolator
android.R.anim.anticipate_overshoot_interpolator
android.R.anim.bounce_interpolator
android.R.anim.cycle_interpolator
android.R.anim.decelerate_interpolator
android.R.anim.fade_in
android.R.anim.fade_out
android.R.anim.linear_interpolator
android.R.anim.overshoot_interpolator
android.R.anim.slide_in_left
android.R.anim.slide_out_right]]},
{"延迟",[[--2000是延迟的时间,单位为毫秒
--这个会卡进程，配合线程使用
Thread.sleep(2000)

--这个不会卡进程
task(2000‚function()
--do something
end)

--也可以使用Handler
import "android.os.Handler"
import "java.lang.Runnable"
Handler().postDelayed(Runnable({
  run=function()
    --do something
  end,
}),2000)]]},
{"定时器",[[--timer定时器
local t=timer(function() 
--事件
end,延迟,间隔,初始化)
--暂停timer定时器
t.Enable=false
--启动timer定时器
t.Enable=true

--Ticker定时器
local ti=Ticker()
ti.Period=间隔
ti.onTick=function() 
--事件
end
--启动Ticker定时器
ti.start()
--停止Ticker定时器
ti.stop()]]},
{"获取本地时间",[==[--格式化的时间
os.date()
os.date("%Y-%m-%d %H:%M:%S")--返回一个按format格式化日期、时间的字串或表。
--[=[os.date ([format [, time]])
可以省略第二个参数也可以省略两个参数，只省略第二个参数函数会使用当前时间作为第二个参数，如果两个参数都省略则按当前系统的设置返回格式化的字符串，做以下等价替换 os.date() <=> os.date("%c")。

如果format以“！”开头，则按格林尼治时间进行格式化。

如果format是一个“*t”，将返一个带year(4位)，month(1-12)， day (1--31)， hour (0-23)， min (0-59)，sec (0-61)，wday (星期几， 星期天为1)， yday (年内天数)和isdst (是否为日光节约时间true/false)的带键名的表;

如果format不是“*t”，os.date会将日期格式化为一个字符串，具体如下

格式符   释义           示例
%a	一星期中天数的简写	(Fri)
%A	一星期中天数的全称	(Wednesday)
%b	月份的简写	(Sep)
%B	月份的全称	(May)
%c	日期和时间	(09/16/98 23:48:10)
%d	一个月中的第几天	(28)[0 - 31]
%H	24小时制中的小时数	(18)[00 - 23]
%I	12小时制中的小时数	(10)[01 - 12]
%j	一年中的第几天	(209)[01 - 366]
%M	分钟数	(48)[00 - 59]
%m	月份数	(09)[01 - 12]
%P	上午或下午	(pm)[am - pm]
%S	一分钟之内秒数	(10)[00 - 59]
%w	一星期中的第几天	(3)[0 - 6 = 星期天 - 星期六]
%W	一年中的第几个星期	(2)0 - 52
%x	日期	(09/16/98)
%X	时间	(23:48:10)
%y	两位数的年份	(16)[00 - 99]
%Y	完整的年份	(2016)
%%	字符串'%'	(%)
]=]

--本地时间
os.clock()--返回一个程序使用CPU时间的一个近似值。

os.time()--返回的是1970-01-01到现在相距的秒数
os.time({year=2008,month=1,day=1,hour=8,min=0,sec=0,isdst=false})--按table的内容返回一个时间值(数字)，若不带参数则么使用当前时间作为table内容，其中table中可以包含的字段有：year, month, day, hour, min, sec, isdst，其他字段将会被忽略。
--参数中年月日必填,isdst指的是夏令时
]==]},
{"设置控件高宽",[[local linearParams = 控件ID.getLayoutParams()
linearParams.width =宽度
linearParams.height =高度
控件ID.setLayoutParams(linearParams)]]},
{"activity 传入参数",[[activity.newActivity("窗口名",{参数})--可以有多个参数

--渐变动画效果的，中间是安卓跳转动画代码
activity.newActivity("窗口名",android.R.anim.fade_in,android.R.anim.fade_out,{参数})]]},
{"按两次返回键退出",[[local 参数=0
function onKeyDown(k) 
if k==4 then 
if 参数 > 0 then 
activity.finish()
else
print("再按一次返回键退出")
参数=参数=1
end
return true 
end
end]]},
{"support v4包的下拉刷新",[[--设置下拉刷新监听事件
swipeRefreshLayout.setOnRefreshListener({
  onRefresh=function()

  end,
});
--设置进度条的颜色
swipeRefreshLayout.setColorSchemeColors(int{Color.RED, Color.BLUE, Color.GREEN});
--设置圆形进度条大小
swipeRefreshLayout.setSize(SwipeRefreshLayout.LARGE);
--设置进度条背景颜色
swipeRefreshLayout.setProgressBackgroundColorSchemeColor(Color.DKGRAY);
--设置下拉多少距离之后开始刷新数据
swipeRefreshLayout.setDistanceToTriggerSync(50);]]},
{"设置横屏竖屏",[[--横屏
activity.setRequestedOrientation(0)
--竖屏
activity.setRequestedOrientation(1)]]},
{"动态设置 ImageView 图片",[[ID.setImageBitmap(loadbitmap("图片.png"))
setImageDrawable]]},
{"隐藏滑动条",[[--横向
horizontalScrollBarEnabled=false
--竖向
VerticalScrollBarEnabled=false]]},
{"振动",[[import "android.content.Context" 

--获取系统服务
local vibrator = activity.getSystemService(Context.VIBRATOR_SERVICE)

--判断设备是否有振动器
local hasVib=vibrator.hasVibrator()

--震动的两个方法
local vib=vibrator.vibrate(600)
--控制手机振动指定毫秒,只振动一次

local vib=vibrator.vibrate(int{100,800},-1) 
--参数一:震动参数{等待时间,振动时间,等待时间,振动时间,...,...,...}
--参数二:震动次数,-1振动一次,0一直振动

--停止所有震动
vibrator.cancel()

--别忘了申明权限
--<uses-permission android:name="android.permission.VIBRATE"/>]]},
{"EditText 只能输入数字",[[import "android.text.InputType"
控件ID.setInputType(InputType.TYPE_CLASS_NUMBER)

import "android.text.method.DigitsKeyListener"
控件ID.setKeyListener(DigitsKeyListener.getInstance("0123456789"))]]},
{"窗口全屏",[[import "android.view.WindowManager"
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)]]},
{"控件点击波纹效果",[[--5.0或以上可以实现点击水波纹效果
--在布局加入：
style="?android:attr/buttonBarButtonStyle";

--或设置background/foreground
import "android.content.res.ColorStateList"
import "android.graphics.drawable.RippleDrawable"

function 波纹(波纹颜色) 
  return RippleDrawable(ColorStateList(int[0].class{int{}},int{波纹颜色}),nil,nil)
end]]},
{"设置 acticity 背景",[[local function setActivityBackground(drawable)
  activity.getWindow().setBackgroundDrawable(drawable)
end]]},
{"关于输入法影响布局的问题",[[import "android.view.WindowManager"
--使弹出的输入法不影响布局
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
--使弹出的输入法影响布局
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);]]},
{"强制结束自身并清除自身数据",[[os.execute("pm clear "..activity.getPackageName())]]},
{"获取ListView垂直坐标",[[local function getScrollY(ls)--ListView id
local c = ls.getChildAt(0);
local firstVisiblePosition = ls.getFirstVisiblePosition();
local top = c.getTop();
return -top + firstVisiblePosition * c.getHeight() ;
end]]},
{"申请root权限",[[--shell命令
os.execute("su")]]},
{"传感器",[[import "android.hardware.SensorManager"
import "android.hardware.SensorEventListener"
import "android.content.Context"
import "android.hardware.Sensor"

local 传感器 = activity.getSystemService(Context.SENSOR_SERVICE)

local 加速度传感器 = 传感器.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
x轴 = event.values[0]
y轴 = event.values[1]
z轴 = event.values[2]
end,nil}), 加速度传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 光线传感器 = 传感器.getDefaultSensor(Sensor.TYPE_LIGHT)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
光线 = event.values[0]
end,nil}), 光线传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 距离传感器 = 传感器.getDefaultSensor(Sensor.TYPE_PROXIMITY)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
距离 = event.values[0]
end,nil}), 距离传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 磁场传感器 = 传感器.getDefaultSensor(Sensor.TYPE_ORIENTATION)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
磁场 = event.values[0]
end,nil}), 磁场传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 温度传感器 = 传感器.getDefaultSensor(Sensor.TYPE_TEMPERATURE)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
温度 = event.values[0]
end,nil}), 温度传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 陀螺仪传感器 = 传感器.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
陀螺仪 = event.values[0]
end,nil}), 陀螺仪传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 重力传感器 = 传感器.getDefaultSensor(Sensor.TYPE_GRAVITY)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
重力 = event.values[0]
end,nil}), 重力传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 压力传感器 = 传感器.getDefaultSensor(Sensor.TYPE_PRESSURE)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
压力 = event.values[0]
end,nil}), 压力传感器, SensorManager.SENSOR_DELAY_NORMAL)]]},
{"获取控件宽高",[[local function getwh(view)
local v=view.measure(0,0)
return v.getMeasuredWidth(),v.getMeasuredHeight()
end]]},
{"控件旋转",[[--Z轴上的旋转角度
View.getRotation()

--X轴上的旋转角度
View.getRotationX()

--Y轴上的旋转角度
View.getRotationY()

--设置Z轴上的旋转角度
View.setRotation(r)

--设置X轴上的旋转角度
View.setRotationX(r)

--设置Y轴上的旋转角度
View.setRotationY(r)

--设置旋转中心点的X坐标
View.setPivotX(p)

--设置旋转中心点的Y坐标
View.setPivotX(p)

--设置摄像机的与旋转目标在Z轴上距离
View.setCameraDistance(d)]]},
},

}