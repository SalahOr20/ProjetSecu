from django.urls import path
from . import views

urlpatterns = [
    path('', views.list_products, name='list_products'),
    path('create/', views.create_product, name='create_product'),
    path('<int:product_id>/', views.get_product, name='get_product'),
    path('create-order/', views.create_order, name='create_order'),
    path('my-orders/', views.get_user_orders, name='get_user_orders'),
]
