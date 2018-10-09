from django.conf.urls import url
from sqlapp import  views

urlpatterns = [
    url(r"^Login/$", views.Login),
    url(r"^Loginout/$", views.Loginout),
    url(r'^list/',views.list),
    url(r'^check/',views.check),
    url(r'^insert/',views.insert),
    url(r'^stuinsert/$',views.stuinsert),
    url(r'^jianli/', views.jianli),
    url(r'^stulist/(\d+)/$',views.stulist),
    url(r'^best/(\d*)/$',views.best),
    url(r'^find/(.*)', views.find),
    url(r'^first/', views.first),
    url(r'^bossproductioncheck/', views.bossproductioncheck),
    url(r'^bossproduction/', views.bossproduction),
    url(r'^shouren/', views.shouren),
    url(r'^join/', views.join),
    url(r'^main/', views.main),
    url(r'^myjianli/',views.myjianli),
    url(r'^myboss/',views.myboss),
]