from django.shortcuts import render
from django.core.paginator import Paginator
from django.conf import settings
from sqlapp.models import *
from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.http import JsonResponse
from django.shortcuts import render, redirect, HttpResponse
from utils.pay import AliPay
import json
import time
black=None
import os
static=settings.STATICFILES_DIRS[0]
# Create your views here.
def main(request):
    return  render(request,"main.html")
def Login(request):
    global black
    Cookie = request.COOKIES
    username = Cookie.get("NXusername")
    password = Cookie.get("NXpassword")
    # 如果有
    # 直接到welcome，并且要把这个用户的username传过去
    if username != None and password != None:
        print(black)
        black = username
        print(black)
        return render(request, 'best.html', {"black": black})
    # 如果没有
    else:

        return render(request,"Login.html",{"black":black})
def Loginout(request):
        response = HttpResponseRedirect('/sqlapp/Login/')
        response.delete_cookie("NXusername")
        response.delete_cookie("NXpassword")
        return response
def check(request):
    #接值
    global black
    username=request.GET.get("name")
    password=request.GET.get("pwd")
    password1=password[0:-1]
    print(username)
    user1 = ce.objects.filter(username__exact=username).values()
    print(user1)
    if len(user1) == 0:
        return HttpResponse("用户名不存在")
    else:
        pwd1 = ce.objects.filter(username__exact=username).values("password")
        pwd2 = pwd1[0]["password"]
        if pwd2!=password1:
            return HttpResponse("密码不正确")
        else:
            black = username

        #将用户的username和password放入cookie，这样下次别人就不用登录了
            res=render(request, 'best.html', {"black": black})
            res.set_cookie("NXusername",username,max_age=60000)
            res.set_cookie("NXpassword",pwd2,max_age=60000)
            return res
def list(request):
    username=request.GET.get('name')
    password=request.GET.get('pwd')
    password1=password[0:-1]
    user=ce.objects.filter(username__exact=username).values()
    if len(user)!=0:
        return HttpResponse("用户名已存在")
    else:
        ce(username=username,password=password1).save()
        return render(request,"Login.html")
def insert(request):
    return  render(request,"insert.html")
def stuinsert(request):
    stuname = request.POST.get("stuname")
    stuage = int(request.POST.get("stuage"))
    stusex = request.POST.get('stusex')
    stuhome = request.POST.get('stuhome')
    stuschool = request.POST.get('stuschool')
    stunumber =int(request.POST.get('stunumber'))
    stuyz = int(request.POST.get('stuyz'))
    stuaddress = request.POST.get('stuaddress')
    stugrjs = request.POST.get('stugrjs')
    # 放入数据库
    stu(stuname=stuname, stuage=stuage,
       stusex=stusex, stuhome=stuhome,
       stuschool=stuschool,stunumber=stunumber,
       stuyz=stuyz,stuaddress=stuaddress,
       stugrjs=stugrjs,bnum="/").save()
    f = request.FILES["upimage"]
    f2 = open(os.path.join(os.path.join(static,"jl"), str(stunumber)), "wb")
    f2.write(f.read())
    f2.close()
    return HttpResponse("简历上传成功")
def stulist(request,pagenum):
    albumname = os.listdir(os.path.join(static,"jl"))
    stulist=[]
    for name in albumname:
        stulist.append(os.path.join(os.path.join(static,"jl"),name))
    pi=Paginator(stulist,3)
    pnums=pi.num_pages #总页数
    page=pi.page(pagenum)
    pnum=page.number #当前页
    sslist=page.object_list
    return  render(request,'stulist.html',{'sslist':sslist,'pnum':pnum,'pnums':pnums,"pagenum":pagenum,"black":black})
def jianli(request):
    st = request.GET.get('name')
    stu2 = st[55:]
    print(stu2)
    stu4 = st[29:]
    print("stu4="+stu4)
    stu3 = stu.objects.filter(stunumber__exact=stu2).values()
    return render(request, 'jianli.html', {"stu3": stu3, "stu4": stu4,"black":black})
def best(request,username):
    black=username
    print("black"+black)
    return render(request,"best.html",{'username':username,"black":black})
def find(request,mess):
    word=["java","c++","c","bigdata","大数据","web","python"]
    mess=str(mess).split("/").pop()
    for keys  in word:
        if keys in mess:
            if keys == "大数据":
                newmess = Message.objects.filter(title="bigdata")
                return render(request, "find.html", {"newmess": newmess})
            newmess=Message.objects.filter(title=keys)
            return render(request,"find.html",{"newmess":newmess,"black":black})
    else:
        mess = Message.objects.all()
        if len(mess) > 9:
            mess = mess[0:9]
        return render(request, "first.html", {"mess": mess,"back":"抱歉，我们未找到符合您意向的工作！"})
def first(request, ):
        mess = Message.objects.all()
        if len(mess) > 9:
            mess = mess[0:9]
        return render(request, "first.html", {"mess": mess,"black":black})
def bossproduction(request):
    return render(request,"bossproduction.html")
def bossproductioncheck(request):
    phone=request.POST.get("phone")
    title=request.POST.get("work")
    salarytreatment=request.POST.get("salarytreatment")
    demand=request.POST.get("demand")
    conpanyname=request.POST.get("conpanyname")
    Message(number=phone,title=title,salarytreatment=salarytreatment,demand=demand,conpanyname=conpanyname,snum="/").save()
    return render(request, "best.html",{"black":black})
def shouren(request):
    boss= request.POST.get('boss')
    xiaobing=request.POST.get("xiaobing")
    stu6=stu.objects.filter(stunumber__exact=xiaobing).values("bnum")
    stu7 = stu6[0]["bnum"]
    stu10 = Message.manage.numbera()
    if boss in stu7:
        return JsonResponse({"datas":"不能重复收人","status":"error"})
    elif boss not in stu10:
        return JsonResponse({"datas":"你没有发布自己的招聘信息不能收人","status":"error"})
    else:
        stu8 = Message.objects.filter(number__exact=boss).values("snum")
        stu9 = stu8[0]["snum"]
        stu.objects.filter(stunumber__exact=xiaobing).update(bnum=boss +"/"+ stu7)
        Message.objects.filter(number__exact=boss).update(snum=stu9+xiaobing+"/")
        return JsonResponse({"datas":"收人成功","status":"success"})
def join(request):
    boss = request.POST.get('boss')
    xiaobing = request.POST.get("xiaobing")
    print("boss="+boss)
    print("xiaobing="+xiaobing)
    stu8 = Message.objects.filter(number__exact=boss).values("snum")
    stu9 = stu8[0]["snum"]
    stu10 = stu.manage.number()
    print(stu10)
    if xiaobing in stu9:
        return JsonResponse({"datas":"不能重复加入一个公司!","status":"error"})
    elif black  not in stu10:
        return JsonResponse({"datas":"你没有自己的简历不能加入公司!","status":"error"})
    else:
        stu6 = stu.objects.filter(stunumber__exact=xiaobing).values("bnum")
        print(stu6)
        stu7 = stu6[0]["bnum"]
        Message.objects.filter(number__exact=boss).update(snum=stu9+xiaobing+"/")
        stu.objects.filter(stunumber__exact=xiaobing).update(bnum=boss + "/" + stu7)
        return JsonResponse({"datas":"加入成功!","status":"success"})
def myjianli(request):
    stu4=os.path.join(os.path.join(static, "jl"), black)
    my = stu.manage.filter(stunumber__exact=black).values()
    if len(my)==0:
        return HttpResponse("不好意思,您没有发布简历！")
    else:
        return render(request, 'myjianli.html', {"my": my, "stu4": stu4})
def myboss(request):
    mess = Message.objects.filter(number__exact=black).values()
    if len(mess)==0:
        return HttpResponse("不好意思，您没有发布招聘信息！")
    else:
        return render(request, 'myboss.html', {"mess": mess })
def get_ali_object():
    # 沙箱环境地址：https://openhome.alipay.com/platform/appDaily.htm?tab=info
    app_id = "2016092100563667"  #  APPID （沙箱应用）

    # 支付完成后，支付偷偷向这里地址发送一个post请求，识别公网IP,如果是 192.168.20.13局域网IP ,支付宝找不到，def page2() 接收不到这个请求
    notify_url = "http://127.0.0.1:8000/page2/"

    # 支付完成后，跳转的地址。
    return_url = "http://127.0.0.1:8000/page2/"

    merchant_private_key_path = "keys/app_private_2048.txt" # 应用私钥
    alipay_public_key_path = "keys/alipay_public_2048.txt"  # 支付宝公钥

    alipay = AliPay(
        appid=app_id,
        app_notify_url=notify_url,
        return_url=return_url,
        app_private_key_path=merchant_private_key_path,
        alipay_public_key_path=alipay_public_key_path,  # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥
        debug=True,  # 默认False,
    )
    return alipay

def index(request):
    return render(request,'index.html')

def page1(request):
    # 根据当前用户的配置，生成URL，并跳转。
    money = float(request.POST.get('money'))

    alipay = get_ali_object()

    # 生成支付的url
    query_params = alipay.direct_pay(
        subject="贵族皇帝(页面可自动播放歌曲)",  # 商品简单描述
        out_trade_no="x2" + str(time.time()),  # 用户购买的商品订单号（每次不一样） 20180301073422891
        total_amount=money,  # 交易金额(单位: 元 保留俩位小数)
    )

    pay_url = "https://openapi.alipaydev.com/gateway.do?{0}".format(query_params)  # 支付宝网关地址（沙箱应用）

    return redirect(pay_url)


def page2(request):
    alipay = get_ali_object()
    if request.method == "POST":
        # 检测是否支付成功
        # 去请求体中获取所有返回的数据：状态/订单号
        from urllib.parse import parse_qs
        # name&age=123....
        body_str = request.body.decode('utf-8')
        post_data = parse_qs(body_str)

        post_dict = {}
        for k, v in post_data.items():
            post_dict[k] = v[0]

        # post_dict有10key： 9 ，1
        sign = post_dict.pop('sign', None)
        status = alipay.verify(post_dict, sign)
        print('------------------开始------------------')
        print('POST验证', status)
        print(post_dict)
        out_trade_no = post_dict['out_trade_no']

        # 修改订单状态
        # models.Order.objects.filter(trade_no=out_trade_no).update(status=2)
        print('------------------结束------------------')
        # 修改订单状态：获取订单号
        return HttpResponse('POST返回')

    else:
        params = request.GET.dict()
        sign = params.pop('sign', None)
        status = alipay.verify(params, sign)
        print('==================开始==================')
        print('GET验证', status)
        print('==================结束==================')

        v=1
        return render(request,"best.html",{"black":black,"v":v})