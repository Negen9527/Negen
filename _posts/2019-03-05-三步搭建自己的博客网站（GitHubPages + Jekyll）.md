#### 一、创建 github 仓库
创建一个 github 仓库命名为你的账户名。例如，我的账户名是 Negen9527 ，那么就创建一个名为 Negen9527 的仓库，如下：  
![创建仓库.png](https://upload-images.jianshu.io/upload_images/16432686-7af6bb67d09e2173.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

创建完成后复制下面的地址，将仓库 clone 到本地
![image.png](https://upload-images.jianshu.io/upload_images/16432686-6ac416e6013979a6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

#### 二、选择 jekyll 主题（模板）
到 [jekyll主题官网](http://jekyllthemes.org/) 选择一个自己喜欢的主题，下载到本地.  

主页如下：
![jekyll 主页.png](https://upload-images.jianshu.io/upload_images/16432686-51f07433903e1931.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

我选择了这个 [jekyll-clean-dark](http://jekyllthemes.org/themes/jekyll-clean-dark/) 作为我的博客页面。  
点击 [download](download) 直接下载到本地
![jekyll-clean-dark.png](https://upload-images.jianshu.io/upload_images/16432686-30a79e5693eed77c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

将下载下来的主题解压到 github 仓库下面，解压后的仓库文件结构如下：
![文件目录.png](https://upload-images.jianshu.io/upload_images/16432686-f0c2b103189db575.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### 三、修改配置文件
修改配置文件（\_config.yml）  
个人认为比较主要的配置修改如下：
![修改配置.png](https://upload-images.jianshu.io/upload_images/16432686-62c3ea9710024664.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
还有更多的配置操作，请访问[jekyll官网](https://www.jekyll.com.cn/)

#### 四、上传到 github 仓库
将修改后的主题 push 到 github 上面  
在仓库根目录下打开gitBash，执行以下语句
+ git add .
+ git commit -m "[init]初始化博客"
+ git push
看到以下提示说明上传成功：  
![上传成功提示.png](https://upload-images.jianshu.io/upload_images/16432686-0c79062ec0c706e2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  
上传成功后到 github 仓库点击 Settings
![点击Settings.png](https://upload-images.jianshu.io/upload_images/16432686-fd90b466a44f75ff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

再找到如下位置选在master，等待页面自动刷新，出现一个url即是你的博客地址：
![点击master.png](https://upload-images.jianshu.io/upload_images/16432686-05c23462c7e82930.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 五、测试
点击博客地址即可进入到博客主页，效果如下:
![博客主页.png](https://upload-images.jianshu.io/upload_images/16432686-b05c66e94c987353.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

[测试地址](https://negen9527.github.io/Negen9527/)：https://negen9527.github.io/Negen9527/

#### 六、发布第一篇博客
发布的博客都在文件夹（\_post）下面：  
![post文件夹.png](https://upload-images.jianshu.io/upload_images/16432686-6da3e23e7a7ba588.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
md文件命名格式：年-月-日-标题.md  

文件里面的内容就是正常的markdown文件格式。
编辑完成就可以 将更新的内容 push 到 github 上面了。刷新博客主页，查看上传是否成功。
