# 招聘网

运行方法：python manage.py runserver

使用到的技术: django框架 python mysql

作者：陈宇

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

### 6.安装 Nginx

##### 1.通过 yum 安装 Nginx

`yum install nginx -y`

##### 2.启动 Nginx 服务

`systemctl start nginx`

访问下面的链接，可以看到 nginx 的欢迎界面
<http://119.29.60.230/>

### 7.安装 uwsgi

##### 1.安装 uwsgi

pip install uwsgi

### 8.让 Nginx，uwsgi，Django 协同工作

##### 1.修改 Nginx 配置文件

- 编辑 /etc/nginx/nginx.conf

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

```
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
        include uwsgi_params;
        uwsgi_pass 127.0.0.1:8000;
    }

    error_page 404 /404.html;
        location = /40x.html {
    }

    error_page 500 502 503 504 /50x.html;
        location = /50x.html {
    }
}
```

}



##### 2.重启 Nginx

`/usr/sbin/nginx -s reload`

##### 3.创建 uwsgi 配置文件

请在 `/data/mysite` 目录下创建 uwsgi.ini，参考下面的内容。

uwsgi.ini文件里的内容如下

[uwsgi]
socket = 127.0.0.1:8000
chdir = /data/mysite
wsgi-file = mysite/wsgi.py
processes = 4
threads = 2
stats = 127.0.0.1:9191
uid = nobody
gid = nobody
master = true
harakiri = 30
daemonize = /data/mysite/uwsgi.log
plugins = python



##### 4.启动 uwsgi

`uwsgi uwsgi.ini`



