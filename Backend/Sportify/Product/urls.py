from django.urls import path
from . import views

urlpatterns = [
    path('', views.list_products, name='list_products'),
    path('<int:product_id>/', views.get_product, name='get_product'),
    path('create-order/', views.create_order, name='create_order'),
    path('my-orders/', views.get_user_orders, name='get_user_orders'),
    path('my-orders/<int:order_id>/', views.get_order_detail, name='get_order_detail'),

]
