## KANBAN TASK APP

## Introduction

Flutter bloc ve statemanagement solution olarak GetX kullanıldı. 
Uygulama : 

UI/Views   =>   Blocs  =>    Repositories  =>    APİ      mimarisinde çalışmaktaır. Dosya yapısı aşağıda görselleştirilmiştir. 
           <=          <=                  <=
          
         
```
.
└── lib
  ├── data
  │   ├── local
  │   │   └── MySharedPrefHelper
      └── Models
      └── Repos
  ├── Ui
  │   ├── views
  │   │   └── home
  │   │   └── splash
  │   │   └── description
  │   │   └── login
  │   ├── blocs
  │   └── services
      └── utils
  ├── Routes
 
```

Uygulamada kullanılan paket ve teknolojiler :

=> Dio
=> SQlite
=> path
=> Flutter_bloc
=> avatar_stack
=> Sceen_Util

## Uygulamaya Giriş ve çalışma Prensibi


Splash Screen => <img src="https://github.com/burakcetn/rast_mobile_kanban/assets/45536352/595ba352-982a-449a-9eaa-8217f6a27109" width=25% height=25%>

## Uygulama 5 saniye sonra otomatik Login sayfasına yönlendirmekte ve Login servisleri olarak reqres.in kullanıldı. 
## API servisinden dönen error mesajları Custom tanımladığımız Snackbar ile görselleştirildi. Tüm Error kodları için çalışmaktadır.

## Doğru giriş bilgileri   email = eve.holt@reqres.in   Şifre kısmını boş bırakmazsanız yeter. Reqres servisleri sadece email kontrolü üzerinden auth yapmakta.

<img src="https://github.com/burakcetn/rast_mobile_kanban/assets/45536352/6f9ed1de-bc3c-4899-b0f8-2ed6595e7544" width=25% height=25%>  

## SQLite kullanarak default bir task board oluşturdum. Main fonksiyonu içerisinde tanımladığım için her hot restart atıldığında sonradan eklediğiniz verilerin yanında
## default değerler de tekrar oluşturulacaktır.
<img src="https://github.com/burakcetn/rast_mobile_kanban/assets/45536352/66250acb-69a4-4b6b-95e9-524d022007a6" width=25% height=25%>  

## Task Card'larına tıklandığında detay safasına yönlendirirken uzun basmada Drag&Drop özelliği aktif olur ve taşımak istediğiniz Listenin Title'ına bırakıldığında taşınmak istenen Task aktarılır.
Detay sayfasına eklediğim delete butonu ile istenen task direkt database'den silinir.

Detay Sayfası => <img src="https://github.com/burakcetn/rast_mobile_kanban/assets/45536352/e935537c-04e0-4bdc-80cc-97abc36c7d92" width=25% height=25%>  
onDrag => <img src="https://github.com/burakcetn/rast_mobile_kanban/assets/45536352/541f9d8b-cc10-419b-b353-c38ca633d1a0" width=25% height=25%>  
onDrop => <img src="https://github.com/burakcetn/rast_mobile_kanban/assets/45536352/58d31205-b037-4e22-90d3-23c5d6f24344" width=25% height=25%>  

## Yeni Task ekleme ekranı 

Floating action button'a tanımlanan AlertDialog ile dilediğiniz statuste task ekleyebilirsiniz. 

## EKLERKEN status kısmına girilmesi gereken key değerler => backlog , todo , inprogress , done   

<img src="https://github.com/burakcetn/rast_mobile_kanban/assets/45536352/b0c60f01-7a31-4c64-86e1-2de23bbb3fd3" width=25% height=25%>  



