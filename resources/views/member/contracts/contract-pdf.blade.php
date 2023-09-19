<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <title>{{$contract->id }}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
    <link rel='stylesheet prefetch'
          href='https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/css/flag-icon.min.css'  media='all'>
    <link rel='stylesheet prefetch'
          href='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/css/bootstrap-select.min.css'  media='all'>


    <!-- This is a Animation CSS -->

@stack('head-script')


    <style>

.table thead tr{
    background-color:lavender;
    border: 2px solid #ddd;
     direction: rtl;
      font-size: 14px;
       text-align: center;
    
}

.table tbody tr{
    background-color:lavender;
    border: 2px solid #ddd;
     direction: rtl;
      font-size: 14px;
       text-align: center;
    
}
 th{
  border: 2px solid #ddd;
  direction: rtl;
  font-size: 14px;
  text-align: center;
}


.table {
    border: 2px solid #ddd;
    text-align: center;
    font-size: 14px;
    cursor: pointer;
    direction: rtl;
}

.table tbody tr td{
  border: 2px solid #ddd;
   font-size: 14px;
    text-align: center;
}

.table tbody tr th{
  border: 2px solid #ddd;
   font-size: 14px;
    text-align: center;
}
    </style>
</head>
<body onload="window.print()">
<div id="wrapper">
    <div id="page-wrapper" style="margin-left: 0px !important;">
      <div class="container-fluid">
        <div class="row"> 
        <header>
            <img style="float:left" src="{{ url('user-uploads/header/'.$global->header) }}" width="200PX" height="100PX"/>
        </header>
         </div>
    <div class="row">    
    <div class="col-md-12">
    <h6 style="text-align:center;">بسم الله الرحمن الرحيم</h6>    
     <h1 style="text-align:center; color:red;"> عقد شراكة استراتيجية</h1>
     <p style="text-align:right; font-size:18px;font-weight:bold;font-family: -webkit-body;">الحمد لله والصلاة والسلام على رسول الله تم بعون الله إبرام هذا ("العقد") في يوم الثلاثاء الموافق 27/09/ 2022م -01/03/1444 ، في مدينة جدة بين كلاً من</p>
    </div>
    <div class="col-md-12">
    <h2 style="direction: rtl;text-align: right;background-color: sandybrown;">۱.	شركة باديا لتقنية المعلومات </h2>
    <p style="direction: rtl;text-align: right;font-size:16px;">
        سجل تجاري رقم (4030415412) الرقم الضريبي (311186972300003) وعنوانها مدينة جدة، حي السلامة، ص ب 23524 جدة ويمثلها الأستاذة/ مها نايف الحارثي - رقم الجوال (0555261422)، البريد الإلكتروني: info@tecbadia.com ، بصفتها المدير التنفيذي – القطاع الإداري والمالي ، (ويشار إليها فيما بعد بـ "الطرف الأول")
    </p>
    </div>
    <div class="col-md-12">
       <h2 style="direction: rtl;text-align: right;background-color: sandybrown;">۲. {{$contract->client->client_details->company_name}}</h2>
       <p style="direction: rtl;text-align: right;font-size:16px;">
                سجل تجاري رقم (4030008182) الرقم الضريبي ({{$contract->client->client_details->gst_number}}) وعنوانها مدينة {{$contract->client->client_details->city}}، الرمز البريدي {{$contract->client->client_details->postal_code}} ويمثله الأستاذ/ {{$contract->client->name}} - رقم الجوال ({{$contract->client->mobile}})، البريد الإلكتروني: {{$contract->client->email}} ، (ويشار إليه فيما بعد بـ "الطرف الثاني")      </p>
    </div>
</div>
    <div class="col-md-12">
    <h3 style="background-color: lavender;text-align:center;font-size:16px;font-weight:bold;">تمهيد</h3>
     <p style="direction: rtl;text-align:right; font-size:14px;">
لما للطرف الأول من خبرات في تصميم وتقديم البرامج الالكترونية والاستشارات الفنية والدعم الفني للغير، ولرغبة الطرف الثاني الاستفادة من منتجات وخدمات الطرف الأول، فقد اتفق الطرفين وهما بكامل الأهلية المعتبرة شرعاً لوضع الأحكام والشروط التي ستعمل على أساسها الشراكة في إطار واضح ومحدد وفقاً للبنود الآتية   : -
     </p>
    </div>
    <div class="col-md-12">
    <h5 style="background-color: lavender;direction: rtl;text-align:right;font-size:18px;font-weight:bold;">۱.	تضمين التمهيد</h5>
     <p style="direction: rtl;text-align:right; font-size:16px;">
يعتبر التمهيد السابق جزءً لا يتجزأ من هذه العقد، ويفسر تبعاً لذلك.
     </p>
    </div>
    <div class="col-md-12">
    <h5 style="background-color: lavender;direction: rtl;text-align:right;font-size:18px;font-weight:bold;">۲.	موضوع العقد والغرض منه</h5>
     <p style="direction: rtl;text-align:right; font-size:16px;">
من خلال هذا العقد، يقوم الطرف الأول بتصميم و اطلاق برنامج {{$contract->contract_type->name}} والذي شمل مميزات سيتم شرحها في ملحق للعقد بعد التوقيع 
     </p>
    </div>
<div class="col-md-12">
    <h5 style="background-color: lavender;direction: rtl;text-align:right;font-size:16px;font-weight:bold;">۳.	مدة العقد</h5>
     <p style="direction: rtl;text-align:right; font-size:16px;">
اتفق الطرفان على أن مده هذا العقد ( اربع اعوام ميلاديه) يبدأ من تاريخ تسليم المنصة. وقبل انتهاء مدة العقد يحق لأحد الطرفين إشعار الطرف الآخر بفسخ العقد أو القيام بأي تعديل على أن يتم الإخطار قبل نهاية العقد بـ 30 يوم 
     </p>
</div>
    
<div class="col-md-12">
    <h5 style="background-color: lavender;direction: rtl;text-align:right;font-size:16px;font-weight:bold;">٤.	قيمة العقد و الخدمات المقدمة </h5>
     <p style="direction: rtl;text-align:right; font-size:16px;">
•	يلتزم الطرف الثاني بأن يدفع للطرف الأول مبلغ وقدره{{$contract->amount}} ريال سعودي وذلك مقابل عمله في بناء و برمجة {{$contract->contract_type->name}} خاص به ويقوم بتحويل المبلغ الى الحساب البنكي في بنك البلاد الايبان  SA 7315000608134982520001
<br/>
•	يلتزم الطرف الثاني بدفع مبلغ وقدره 375 سنويًا مقابل الاستضافة السحابية، بعد السنة الأولى من تاريخ العقد.
<br/>
•	يتم دفع 10% من قيمة العقد لقاء الدعم الفني سنويا بعد السنة الأولى من تاريخ العقد (حسب رغبة العميل).
<br/>
•	يلتزم الطرف الأول بتقديم الدعم الفني للأعطال وعيوب البرنامج وكذلك خدمة الاستضافة السحابية.
<br/>
•	يلتزم الطرف الأول بتفعيل خدمة الربط مع هيئة الزكاة والضريبة والجمارك للطرف الثاني وذلك عند ارسال الطرف الثاني UUID الخاص بالطرف الثاني .
     </p>
</div>
<div class="col-md-12">
    <h5 style="background-color: lavender; direction: rtl;text-align:right;font-size:16px;font-weight:bold;">٥.	السرية  </h5>
    <p style="direction: rtl;text-align:right; font-size:16px;">
    يتعهد كلا من طرفي التعاقد بالحفاظ على سرية المعلومات والبيانات التي يحصل عليها الطرف الآخر بحكم هذا التعاقد وينبغي عدم استخدام هذه المعلومات في غير الأغراض المخصصة لها على أن لا يتعدى تداول هذه المعلومات إلا موظفي الطرفين ووفقا لما تطلبه حاجة العمل.
    </p>
</div>
    
    <div class="col-md-12">
    <h5 style="background-color: lavender;direction: rtl;text-align:right;font-size:18px;font-weight:bold;">٦.	مزايا إضافية  </h5>
     <p style="direction: rtl;text-align:right; font-size:16px;">
    يقر الطرف الثاني بعلمه التام بالمزايا المتوفرة في البرنامج، وعند رغبته في إضافة أي ميزة جديدة يتم احتساب مبلغ مالي مقابل إضافتها يحدده الطرف الأول إطلاق المنصة 
     </p>
</div>
<div class="col-md-12">
    <h5 style="background-color: lavender;direction: rtl;text-align:right;font-size:18px;font-weight:bold;"> ٧.  المنازعات</h5>
     <p style="direction: rtl;text-align:right; font-size:16px;">
على ان تكون المحاكم السعودية هيا المحاكم المختصة في حال حدوث أي نزاع لا سمح الله 
     </p>
</div>    

<div class="col-md-12">
    <h5 style="background-color: lavender;direction: rtl;text-align:right;font-size:18px;font-weight:bold;"> ٨.  الإخطارات </h5>
     <p style="direction: rtl;text-align:right; font-size:16px;">
علي ان يكون الإيميل الرسمي للتواصل info@tecbadia.com ورقم الجوال 0534537573 
     </p>
</div>   
<div class="col-md-12">
    <h5 style="background-color: lavender; direction: rtl;text-align:right;font-size:18px;font-weight:bold;">١٠.  نسخ العقد</h5>
     <p style="direction: rtl;text-align:right; font-size:16px;">
حرر هذا العقد من نسختين أصلية، وقد استلم كل طرف نسخة موقعة حسب الأصول للعمل بموجبها. وإثباتا لما تقدم، تم توقيع هذا العقد في التاريخ المذكور أدناه والله ولي التوفيق،
     </p>
</div>
<div class="col-md-12">
    <table  class="table table-bordered">
  <thead>
    <tr>
      <th></th>
      <th>الطرف الأول</th>
      <th>الطرف الثاني </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>الأسم</th>
      <th></th>
      <td></td>
    </tr>
    <tr>
      <th>التاريخ</th>
      <th></th>
      <td></td>
    </tr>
    <tr>
      <th>التوقيع</th>
      <th></th>
      <td></td>
    </tr>
  </tbody>
</table>
</div>        
</div>
</body>
</html>