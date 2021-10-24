from django.urls import path
from .views import * # ดึงมาทุกฟังก์ชัน views.py

urlpatterns = [
  path('', Home),
  path('api/get-alltodolist', all_todolist),
  path('api/post-alltodolist', post_todolist),
  path('api/update-alltodolist/<int:TID>', put_todolist),
  path('api/delete-alltodolist/<int:TID>', delete_todolist),
]