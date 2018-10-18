### 1.linux系统安装python3.6.4

##### 1.安装依赖环境

我个人习惯安装在/usr/local/python3（具体安装位置看个人喜好）
　　创建目录：

​  `mkdir -p /usr/local/python3`

环境

`yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make` 

##### 2.下载Python3

<https://www.python.org/downloads/>

`# wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz`

##### 3.安装python3

　　解压下载好的Python-3.x.x.tgz包(具体包名因你下载的Python具体版本不不同⽽而不不同，如：我下载的是Python3.6.4.那我这里就是Python-3.6.4.tgz)

`tar -zxvf Python-3.6.4.tgz`

##### 4.进入解压后的目录，编译安装。

`cd Python-3.6.4`

`./configure --prefix=/usr/local/python3`

``make && make install`` 

##### 5.建立python3的软链

`ln -s /usr/local/python3/bin/python3 /usr/bin/python3`

##### 6.并将/usr/local/python3/bin加入PATH

输入这行代码` vim ~/.bash_profile`

进入这个文件，下面是内容

` .bash_profile`

` Get the aliases and functions`

``if [ ``-``f ~``/``.bashrc ];`` then

````. ~/.bashrc```` 

` User specific environment and startup programs`

`PATH=$PATH:$HOME/bin:/usr/local/python3/bin`**添加这一行**

`export PATH`

　　按ESC，按shitf+Q 然后输入:wq！回车退出。

　　修改完记得执行行下面的命令，让上一步的修改生效：

`source ~/.bash_profile` 

　　检查Python3及pip3是否正常可用：

`python3 -V`

`Python 3.6.1`

`pip3 -V`

``pip 9.0.1 from /usr/local/python3/lib/python3.6/site-packages (python3.6``)

##### `7.不行的话在创建一下pip3的`软链接(我也不清楚这一步有什么用)

`ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3`

### 2.安装 Django

##### 1.pip软连接

Python3装完后，默认已经安装了pip，此时只要配置下软链接即可使用pip工具： 

`ln -s /usr/local/python3/bin/pip3  /usr/bin/pip` 

##### 2.使用 PIP，安装 Django

`pip install Django==1.11.7`

### 3.安装 Mysql

##### 1.使用安装命令

安装完成却发现Myserver安装缺失，在网上找原因，原来是因为CentOS 7上把MySQL从默认软件列表中移除了，用MariaDB来代替，所以这导致我们必须要去官网上进行下载，找到链接，用wget打开：

a: #wget <http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm> 

b：rpm -ivh mysql-community-release-el7-5.noarch.rpm

c.yum -y install mysql mysql-server mysql-devel，安装成功。再次使用该命令，然后得到以下信息

##### 2.Mysql分为client，server端两个端口，如果想要使用，先打开服务端

service mysqld start

##### 3.接下来进入客户端，作用命令mysql -u root  输入密码，默认为空

mysql -u root 

##### 4.修改root用户密码

```
use mysql;
update user set password=password('new password') where user='root';
flush privileges;
```

##### 5.成功后，输入 exit 命令退出 db

`exit;`

##### 6.查看数据库是否在运行

ps -e | grep mysql

### 4.从GITHUB中导入 Django 项目

##### 1.创建myproject 项目

`mkdir myproject/`

##### 2.创建虚拟环境软连接

`ln -s /usr/local/python3/bin/pyvenv-3.6 /usr/bin/pyvenv`

`pyvenv venv`

`cd venv/`

`ls`

查看是否创建了venv 没有再执行一次`pyvenv venv`操作

##### 3.进入虚拟环境，配置文件

`source venv/bin/activate   (退出虚拟环境的代码是 deactivate)`

 `pip list`
 `which pip`
`pip install Django==1.11.7`

`pip install pymysql`

##### 4.使用GIT克隆GITHUB中已上传的项目

下载git

`yum -y install git`

下载github中的库

`git clone https://github.com/chenyu1st/CE.git`

### 5.把自己电脑的数据库表导入远程服务器中

##### 1.下载winsco-5.13.4版本

在自己的电脑中下载这个软件（不是在服务器中！！！）

https://sourceforge.net/projects/winscp/

##### 2.建立与远程服务器的连接

安装并打开软件后，点击新建回话，如果你的电脑装有putty，它可以自动识别并连接，你只需要输入你的用户名和密码就可以进行连接了

##### 3.数据库表的导出

打开Navicat for MySQL 点击你需要导入的表

右键表 转储sql文件 选中结构和数据

全选文件导出的选择到相同的文件ce

##### 4.传输sql文件

打开winscp然后把ce.sql文件拖到服务器/root/目录下

##### 5.导入sql文件

进入数据库

mysql -uroot -p

密码admin123456

创建数据库

create database ce CHARSET utf8;

use ce;

set names utf8;

迁移文件

source /root/ce.sql

退出

quit

### 6.部署上线

##### 1.进入你的云服务器（以腾讯云为例）

https://console.cloud.tencent.com/cvm/index

查看你的云服务器配置

点击“配置安全组”

新建安全组

##### 2.配置安全组

模版：自定义

名称：Django项目

所属项目：默认项目

点击确定

立即设置规则

##### 3.添加入站规则

类型：自定义

来源：0.0.0.0/0

协议端口: TCP:8000

策略：允许

备注：Django项目

保存

##### 4.进入服务器运行django项目

进入虚拟环境

 source venv/bin/activate

运行

python manage.py runserver 0.0.0:8000

报错可能：1 pip的库没有装 缺什么装什么 2，url没有改，需要把所有的绝对路径的url删除 在templates里的html（例如location="http://127.0.0.1:8000/sqlapp/find/" 需要改成location="/sqlapp/find/"）

然后访问网页

http://123.206.94.211:8000/sqlapp/Login/（123.206.94.211对应你的云服务器ip地址 8000是端口号 sqlapp/Login/是你的网页url）

### 6.安装 Nginx和uwsgi

##### 1.通过 yum 安装 Nginx（用这种方法高效并且系统给你配置了一定的环境）

`yum install -y nginx `

##### 2.安装 uwsgi

`pip install uwsgi`

##### 3.进入项目ce

创建文件夹script

 `mkdir script`

##### 4.(创建)配置uwsgi.ini

`vim script/uwsgi.ini`



```
# myweb_uwsgi.ini file
[uwsgi]

# Django-related settings

socket = 127.0.0.1:8000(不要改成0.0.0.0：8000)
#真实服务的端口

# Django项目根目录 (绝对路径)
chdir           = /root/myproject/CE/ce

# wsgi.py文件在项目中的位置
module          = ce.wsgi

# process-related settings
# master
master          = true
#指定静态文件
static-map=/static=/root/myproject/CE/ce/static
# 启动uwsgi的用户名和用户组
uid=root
gid=root
# 启用主进程
master=true
# 运行的进程数
processes=4
pidfile=/root/myproject/CE/ce/script/uwsgi.pid
enable-threads=true

#disable-logging：不记录请求信息的日志，只记录错误以及uwsgi内部消息到日志中，如果不开启这一项，日志就会出现大量的请求记录 
diable-logging=true
# ... with appropriate permissions - may be needed
chmod-socket    = 664
# clear environment on exit
vacuum          = true
daemonize = /root/myproject/CE/ce/script/uwsgi.log
```

##### 5.保存文件并运行

开启uwsgi服务`uwsgi --ini script/uwsgi.ini`

ps:结束uwsgi服务是 `uwsgi --stop script/uwsgi.pid`

​    重启uwsgi服务是 `uwsgi --reload script/uwsgi.pid`

##### 6.查看uwsgi是否配置成功

`netstat -tlnp`查看8000端口是否有uwsgi

### 7.让 Nginx，uwsgi，Django 协同工作

##### 1.修改 Nginx 配置文件

- `vim /etc/nginx/nginx.conf`
- 修改文件如下:

```
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

    server {
   listen 80;
   server_name 123.206.94.211 itrugod.com;# 我要访问的网站

   location / {
      rewrite ^/(.*) http://www.itrugod.com/$1 permanent;# 重写我要访问的网站 即输入上方的server_name可跳转http://www.itrugod.com
   }
    }


    server {
        listen 80; # 我要监听那个端口
   server_name www.itrugod.com; # 你访问的路径前面的url名称
   charset utf-8; # Nginx编码
   gzip_types text/plain application/x-javascript text/css text/javascript application/x-httpd-php application/json text/json image/jpeg image/gif image/png application/octet-stream; # 支持压缩的类型

   # 指定项目路径uwsgi
   location / { # 这个location就和咱们Django的url(r'^admin/', admin.site.urls),
      include uwsgi_params; # 导入一个Nginx模块他是用来和uWSGI进行通讯的
      uwsgi_connect_timeout 30; # 设置连接uWSGI超时时间
      uwsgi_pass 127.0.0.1:8000;
   }

   # 指定静态文件路径
   location /static/ {
      alias /root/myproject/CE/ce/static/;
      index index.html index.htm;
   }
    }


# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
```

##### 2.验证配置文件是否正确

`nginx -t`

看到显示：nginx.conf syntax is ok

nginx.conf test is successful

即配置文件正确

##### 3.设置root权限

 `chmod o+rx /root`

##### 4.开启（重启）nginx

 `systemctl restart nginx`

##### 5.查看nginx状态

`ps -ef|grep nginx`

### 8.修改django项目中的路径

##### 1.templates里的路径都不能写绝对路径

把所有页面的绝对路径改成相对路径

例如：

```
function boss(){
window.open("http://127.0.0.1:8000/sqlapp/bossproduction")
}
```

改成

```
function boss(){
window.open("/sqlapp/bossproduction")
}
```

##### 2.修改大url（ce里面的url 不是sqlapp里面的）

添加一条url

```
url(r'^$', views.main),
```

作为网页的主页：nginx中的配置

server_name www.itrugod.com;

用正则改出来的url 即www.itrugod.com可以访问main函数跳转到main.html