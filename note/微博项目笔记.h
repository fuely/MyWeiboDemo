/*
 
 一、LaunchScreen
 LaunchScreen产生原因:代替之前的启动图片
 好处：
 1.可以展示更多的东西
 2.可以只需要出一个尺寸的图片。
 
 启动图片的优先级
 启动图片 < LaunchScreen.stroyboard

 模拟器尺寸不对
 程序中碰见模拟器尺寸不对，马上去找启动图片，默认模拟器的尺寸由启动图片决定。
 
二、程序启动原理
1.创建UIApplication对象
2.创建AppDelegate对象，并且成为UIApplication对象代理属性
3.开启主允许循环：目的让程序一直跑起来
4.加载info.plist文件，判断下info.plist文件里面有木有指定main.storyboard，如果指定，就会去加载main.storyboard
 
main.storyboard底层实现
1.初始化窗口
2.加载storyboard文件,并且创建箭头指向的控制器
3.把新创建的控制器作为窗口的跟控制器，让窗口现实

三、如何加载storyboard文件
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
 
 // instantiateInitialViewController:默认加载箭头指向的控制器
 
[storyboard instantiateInitialViewController];
 
 四、思想
 封装思想：如果以后项目中，有相同的功能，抽取一个类，封装好
 如何封装类：做到自己的事情全部交给自己管理。
 抽方法：一般一个功能就抽一个方法，以后开发中如果有相同的功能，找到对应的类就能找到功能
 
五、苹果模型
Item:就是苹果的模型命名规范
tabBarItem:决定着tabBars上按钮的内容
如果通过模型设置控件的文字颜色，只能通过文本属性（富文本：颜色，字体，空心，阴影，图文混排）
 
六、在ios7之后，默认会把UITabBar上面的按钮图片渲染成蓝色，一般需要告诉图片保持最原始的图片，或者在image.xcassest里面设置render模式

七、类的加载和初始化
 什么时候调用：程序一启动的时候就会把所有的类加载进内存
 作用：加载类的时候调用
+ (void)load
{

}
 
// 什么调用：当第一次使用这个类或者子类的时候调用
// 作用：初始化类
 + (void)initialize
{
 
}
 
八、appearance方法
appearance只要一个类遵守UIAppearance，就能获取全局的外观，UIView都可以获取所有的外观
 
获取所有的tabBarItem外观标识
UITabBarItem *item = [UITabBarItem appearance];
 
self -> CZTabBarController
获取当前这个类下面的所有tabBarItem
UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil]
 
九、利用KVC可以把系统readonly的属性修改
 
十、UITabBar的items属性
 self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
 
十一：sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
 
十二：模型设计思想
 id：能调用任何对象的get,set方法，不能帮我们检查错误
 类方法：需要使用self创建对象
十三:Oauth授权:让数据更加安全. 
  流程:有数据提供商提供一个登陆网站,显示在第三方客户端上面,
  Oauth授权:1.需要获取第三方数据
           2.第三方登入
           3.第三方分享
  注意:并不是任何软件都能OAuth授权,必须成为第三方开发者,才能Oauth授权
 
 Oauth授权步骤:
 1.进入登入界面
 2.获取Request Token,(点击授权,进入回调界面,获取Code)
 3.用Code换取accessToken
 
 开发步骤:
 1.先搭建界面
 2.展示数据
 3.处理对应的业务逻辑
 
 跟服务器打交道步骤:
 1.向服务器发送请求->一般公司会提供接口文档,参照接口文档跟服务器打交道,接口文档(1.请求的url 2.发送的什么样的请求(GET,POST)
 3.返回的数据格式)
 2.服务器响应数据->解析数据,参照接口文档设计模型 -> 返回的数据转换成模型
 3.把数据展示到界面,刷新数据
 
*********************
 AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
 
 NSMutableDictionary *params = [NSMutableDictionary dictionary];
 params[@"access_token"] = [HJAccountTool account].access_token;
 
 
 [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 //把字典数组转换成模型数组
 NSArray *dictArr = responseObject[@"statuses"];
 self.statusFrameArr = (NSMutableArray *)[HJStatus objectArrayWithKeyValuesArray:dictArr];
 [self.tableView reloadData];
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 }];

 
 static NSString *ID = @"cell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
 }
 
 //获取模型
 HJStatus *status = self.statusFrameArr[indexPath.row];
 
 //用户昵称
 cell.textLabel.text = status.user.name;
 [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
 cell.detailTextLabel.text = status.text;


 十四:SDWebImage:好处
  1.异步下载,避免卡死主线程(界面)
  2.做好图片的缓存
  3.解决循环利用的问题
 
  主要:很容易造成内存警告
     解决:收到警告时候调用applicationDidReceiveMemoryWaring{}
          停止所有下载  
          [[SDWebImageManager sharedManager] cancelAll];
          删除所有缓存
          [[SDWebImageManager sharedManager].imageChache clearMemory];
 十五:请求数据常规开发步骤:
     1.查看接口文档
     2.依据参数列表,设置参数模型
     3.依据结果列表,设置结果模型
     4.直接拿到对应的工具类请求.
 十六:导航条的图片:64点 @2x 128  @3x 192
      TabBar的图片: 49
     一般导航条和TabBar上面的小控件的图片 35
 十七:复杂的界面开发步骤:
     1.按照业务逻辑划分界面结果(原创,转发,工具条)
     2.每个一个结构,都自定义控件
     3.在控件上先把所有划分的结果界面都添加上去
     4.计算每个控件的位置,如果以后碰见控件的内容是根据模型决定,马上就搞个Viewmodel(模型+控件Frame)
     5.模型转视图模型
     6.给控件赋值视图模型
     7.调节界面(文字大小和颜色)
     8.一个结构一个结构处理
 
 十八:什么时候用代理,block,通知
     代理:一般封装控件的时候用代理,方便通知外界做很多事情,以后控件的扩展,以后只要有新的事件需要通知外界,只需要添加一个协议方法.
     block:一般用来数据传递,回传
     通知:让两个没有关系的东西,产生联系,就用通知,也就是谁也拿不到谁的时候.
     一对多,发出一个通知,多个对象处理.
 
 十九:循环利用问题
     如果一个控件,经常循环利用,就不能在给这个控件赋值属性的时候,添加它的子控件,应该在初始化这个控件的时候就把所有的子控件添加上去.
     注意在循环利用中,只要有if,就必须加上else, else一般做什么事情,把之前的状态清空,其实就是还原最开始的状态.
 
 二十:如何从零开始写一个项目
     1.观察原型图
     2.找相同的界面,目的是抽出一个基类控制器,只要我写好这个控制器,其他的全部写好.
     3.判断是用纯代码还是storyboard搭建这个模块,如果界面的控件位置都是固定,用storyboard.
 
 二十一:什么时候用静态单元格:
     1.如果界面的cell跟系统自带的cell完全差不多,就可以选择静态单元格.
     2.如果不相似:
       1.判断其他cell是否全部差不多的界面,如果全部差不多,就可以使用静态单元格.
       2.如果界面差别很大,就不使用静态单元格,就要代码.

 二十二:为什么跳转控制器用Class
      如果用NSString,
      1.没有提示
      2.还需要多做一步操作,把字符串转成Class
      3.写错了控制器的名字,也不好报错 
 
 */