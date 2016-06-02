# MyWeiboDemo

###1.学习目的:######架构思想,封装思想,优化代码(重构)思想,代码维护思想,把代码按照功能业务逻辑全部抽出来,保证每个功能处理一个业务逻辑。
###2.项目介绍
######1.本项目按照模仿新浪微博编写,请求数据也是从新浪微博开发者平台获取.项目中涉及多种模式以及继承,封装等思想,框架搭建,自定义控件,全部代码编写.

######2.主界面分有:Home,Discover,Message,Profile,Compose.五大模块.主要实现了Home中数据浏览,cell循环利用,转发,评论,点赞等功能,主界面搭建比较完善.其他界面模块功能后续继续添加.

###3.在编写项目中
#####按MVC思想构建程序框架,没一部分都把Controller,View,Model分的清楚;
#####期间都会做一些项目的头脑风暴流程图,帮助直接梳理程序的框架搭建,及其问题怎么产生,如何去决解,从需求出发,一个一个一步一步解决问题;
#####更多的流程在note中的微博项目头脑风暴流程图中,如果需要可以下载来看看;

###4.Demo演示

######1.发送微博的界面,实现发送功能upload数据.
![](https://github.com/fuely/MyWeiboDemo/raw/master/screenshots/sent.gif)

#####2.发现与我的界面
![](https://github.com/fuely/MyWeiboDemo/raw/master/screenshots/discover.gif)

#####3.设置界面里设置字体的大小,以及用户字体选择逻辑判断.
![](https://github.com/fuely/MyWeiboDemo/raw/master/screenshots/fontSize.gif)

#####4.上拉添加更多旧的数据.
![](https://github.com/fuely/MyWeiboDemo/raw/master/screenshots/moreData.gif)

#####5.下来刷新新的数据.实现小label提示栏.
![](https://github.com/fuely/MyWeiboDemo/raw/master/screenshots/newData.gif)

#####6.点击用户昵称,弹出pop标签栏.
![](https://github.com/fuely/MyWeiboDemo/raw/master/screenshots/popView.gif)