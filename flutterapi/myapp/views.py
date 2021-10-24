import re
from django.shortcuts import render
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import serializers, status
from .serializers import TodolistSerializer
from .models import Todolist
# Create your views here.

# GET DATA
@api_view(['GET'])
def all_todolist(request):
    allTodolist = Todolist.objects.all() #ดึงข้อมูลจาก MODEL TODOLIST
    serializer = TodolistSerializer(allTodolist, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

# POST DATA
@api_view(['POST'])
def post_todolist(request):
    if request.method=='POST':
        serializer = TodolistSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

# UPDATE DATA
@api_view(['PUT'])
def put_todolist(request, TID) :
    todo_models = Todolist.objects.get(id=TID)

    if request.method == 'PUT':
        data = {}
        serializer = TodolistSerializer(todo_models, data=request.data)
        if serializer.is_valid():
            serializer.save()
            data['status'] = 'update'
            return Response(data=data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

# DELETE DATA
@api_view(['DELETE'])
def delete_todolist(request, TID):
    todo_models = Todolist.objects.get(id=TID)

    if request.method == 'DELETE' :
        delete = todo_models.delete()
        data = {}
        if delete:
            data['status'] = 'deleted success'
            statuscode = status.HTTP_200_OK
        else :
            data['status'] = 'failed'
            statuscode = status.HTTP_400_BAD_REQUEST
        
        return Response(data=data , status=statuscode)

     

data = [
    {
        "title": "Fake News คือ",
        "subtitle": "ข่าวปลอม หรือ ข่าวลวง เป็นการหนังสือพิมพ์เหลือง (yellow journalism) หรือการโฆษณาชวนเชื่อซึ่งประกอบด้วย...",
        "img_url": "https://raw.githubusercontent.com/NattawutSmansin/BootCampBasicAPI/main/Image%20Upload/soldier-1682561_960_720.jpg",
        "detail":"ข้อมูลเป็นเท็จที่นำเสนอเป็นข่าวโดยมีความประสงค์เพื่อชักนำบุคคลในทางที่ผิด เพื่อสร้างความเสียหายต่อหน่วยงาน นิติบุคคลหรือบุคคล หรือเพื่อให้ได้ผลประโยชน์ทางการเงินหรือเพื่อชักจูงการเมือง ผู้สร้างข่าวปลอม หรือ Fake News มักใช้ข้อความพาดหัวในลักษณะเร้าอารมณ์ หลอกลวง หรือกุขึ้นทั้งหมดเพื่อเพิ่มยอดผู้อ่าน การแบ่งปันออนไลน์ และรายได้จากคลิกอินเทอร์เน็ต ซึ่งในกรณีหลัง คล้ายกับพาดหัว คลิกเบต ออนไลน์เร้าอารมณ์และอาศัยรายได้จากการโฆษณาโดยไม่สนใจว่าเรื่องที่พิมพ์นั้นจะถูกต้องหรือไม่"
    },
    {
        "title": "What is RAM?",
        "subtitle": "Ram (Random-access memory) หรือ แรม เป็นหน่วยความจำหลักของคอมพิวเตอร์...",
        "img_url": "https://raw.githubusercontent.com/NattawutSmansin/BootCampBasicAPI/main/Image%20Upload/Elixir_M2U51264DS8HC3G-5T_20060320.jpg",
        "detail":"Ram (Random-access memory) หรือ แรม เป็นหน่วยความจำหลักของคอมพิวเตอร์ ซึ่งเป็นองค์ประกอบสำคัญที่มีผลต่อประสิทธิภาพการทำงานโดยรวม ทั้งยังส่งผลต่อความเร็วในการทำงานของระบบคอมพิวเตอร์ ไม่ว่าอุปกรณ์ชนิดนั้นจะเป็นสมาร์ทโฟน, แท็บเล็ต, คอมพิวเตอร์ หรืออุปกรณ์ใดๆ ที่จำเป็นต้องอ่านและเขียนคำสั่งไปยังหน่วยความจำRAM จัดว่าเป็นหน่วยความจำชั่วคราว (Short-Term Memory) โดยการทำงานของมันนั้นจะเป็นการเขียนหรือบันทึกข้อมูลแบบสุ่ม ซึ่งหน่วยความจำชนิดนี้จะสามารถบันทึกข้อมูลลงในตำแหน่งต่างๆ ได้อย่างอิสระ ทั้งนี้ก็เพื่อเพิ่มความเร็วในการบันทึกและอ่านข้อมูล จึงเป็นที่มาของคำว่า Random access ขณะเดียวกันก็ทำให้มันแตกต่างจากหน่วยความจำประเภทอื่นๆ อย่างสิ้นเชิง เมื่อเทียบกับฮาร์ดไดร์ฟ (Hard Drive) หรือ SSD (ที่รู้จักกันในนามของ Direct Access Memory) สิ่งที่ทำให้มันแตกต่างจากหน่วยความจำที่เข้าถึงได้โดยตรงนั่นก็คือ เมื่อมีการตัดกระแสไฟฟ้าหรือปิดคอมพิวเตอร์ ข้อมูลที่อยู่ภายใน Ram ก็จะหายไปอย่างสมบูรณ์ เนื่องจากลักษณะเฉพาะของมัน ข้อมูลที่ถูกจัดการโดย RAM จึงมีการเปลี่ยนแปลงหรือผันผวนอยู่ตลอดเวลา และมีการประมวลผลที่เกิดขึ้นเฉพาะในช่วงเวลาที่กำหนดเท่านั้น ปัจจุบัน โมดูล Ram รูปแบบใหม่กำลังได้รับการพัฒนาอย่างต่อเนื่อง เพื่อให้สามารถจัดเก็บงาน (Task) อื่นๆ ซึ่งหมายถึงการดำเนินการบางอย่าง เช่น การเริ่มต้นระบบ (System Start Up) ที่อาจเกิดได้เร็วขึ้นกว่าเดิมเนื่องจากการกระทำเหล่านั้นได้มีการเตรียมพร้อมสำหรับเรียกใช้"
    },
    {
        "title": "What is FRONTEND?",
        "subtitle": "front-end  หมายถึง โปรแกรมหนึ่งโปรแกรมใด...",
        "img_url": "https://raw.githubusercontent.com/NattawutSmansin/BootCampBasicAPI/main/Image%20Upload/1_OaQpmkPzetUvWAB5sO9ZVg.png",
        "detail":"front-end  หมายถึง โปรแกรมหนึ่งโปรแกรมใด หรือคอมพิวเตอร์เครื่องหนึ่งเครื่องใดที่ซ่อนรายละเอียดของการเข้าถึงข้อมูลเอาไว้ สรุปง่าย ๆ ได้ว่า ตัวโปรแกรมนั้นเองที่มีตัวเสริมหน้า เป็นตัวกันมิให้ใครเข้าถึงข้อมูลได้ นอกจากจะรู้จักคำสั่งต่าง ๆ จะเรียกกันสั้นๆว่า หน้าบ้าน หรือเป็นส่วนติดต่อผู้ใช้ (User interface) ไม่ว่าจะเป็น หน้าโฮม หน้าเว็บเพจ เนื้อหาต่างๆ รูปภาพ ลิงก์ เป็นต้น เป็นส่วนที่ user ทั่วไปสามารถเห็นและเข้ามาใช้งานได้ของเว็บไซต์ ส่วนนี้จะแสดงหน้าตาของเว็บไซต์ให้ผู้เข้าชมเห็น การออกแบบก็เป็นส่วนที่ช่วยดึงดูดและทำให้ผู้อื่นสนใจเว็บไซต์ ทั้งความสวยงาม การใช้งานเว็บไซต์ที่เข้าใจง่าย สะดวก และทำให้ผู้เข้าชมเห็นว่าเว็บไซต์มีการพัฒนาอยู่ตลอด"
    },
    {
        "title": "Dart คือ",
        "subtitle": "Dart ภาษา...",
        "img_url": "https://raw.githubusercontent.com/NattawutSmansin/BootCampBasicAPI/main/Image%20Upload/1_OaQpmkPzetUvWAB5sO9ZVg.png",
        "detail":"คือ Dart นั้นเป็นภาษาโปรแกรมที่เอาไว้สำหรับสร้างแอพพลิเคชันบนแพลตฟอร์มที่หลากหลายโดยได้ทั้ง mobile, desktop, server และก็ web สิ่งที่เป็นที่นิยมที่สุดที่ทำให้คนสนใจมาเรียนภาษา Dart กันก็คือเพื่อที่จะเอาไปใช้ร่วมกับ Flutter ที่เป็นเครื่องมือช่วยสร้าง UI ของ Google ซึ่งใช้ได้ทั้งกับ Android และ iOS หรือจะเป็นใน Desktop กับ Web ก็ยังได้ CD. https://www.borntodev.com/2020/04/11/%E0%B9%80%E0%B8%A3%E0%B8%B5%E0%B8%A2%E0%B8%99-dart-%E0%B9%81%E0%B8%9A%E0%B8%9A%E0%B8%81%E0%B9%89%E0%B8%B2%E0%B8%A7%E0%B8%81%E0%B8%A3%E0%B8%B0%E0%B9%82%E0%B8%94%E0%B8%94/" 
    }
]

def Home(request):
    return JsonResponse(data=data ,safe=False, json_dumps_params={'ensure_ascii': False})