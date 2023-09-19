<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="icon" type="image/png" sizes="16x16" href="{{ $global->favicon_url }}">
    <meta name="msapplication-TileColor" content="#ffffff">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
    <meta name="msapplication-TileImage" content="{{ $global->favicon_url }}">
    <meta name="theme-color" content="#ffffff"> 
    <title>{{ (is_null($estimate->estimate_number)) ? '#'.$estimate->id : $estimate->estimate_number }}</title>
    <style>

        * {
             font-family: 'Cairo', sans-serif !important;
        }
        .clearfix:after {
            content: "";
            display: table;
            clear: both;
        }

        a {
            color: #0087C3;
            text-decoration: none;
        }

        body {
            position: relative;
            width: 100%;
            height: auto;
            margin: 0 auto;
            color: #555555;
            background: #FFFFFF;
            font-size: 14px;
             font-family: 'Cairo', sans-serif !important;
        }

        h2 {
            font-weight:normal;
             font-family: 'Cairo', sans-serif !important;
        }

        header {
                 top: 0cm;
                left: 0cm;
                right: 0cm;
                height: 3cm;
        }
        footer{
            top: 20cm;
            bottom: 0cm;
            left: 0cm;
            right: 0cm;
            height: 3cm;
            width: 100%;
            position: absolute;
            padding: 8px 0;
            text-align: center;
        }

        #logo {
            float: right;
            margin-top: 11px;
        }

        #logo img {
            height: 55px;
            margin-bottom: 15px;
        }

        #company {

        }

        #details {
            margin-bottom: 50px;
        }

        #client {
            padding-left: 6px;
            float: left;
        }

        #client .to {
            color: #777777;
        }

        h2.name {
            font-size: 1.2em;
            font-weight: normal;
            margin: 0;
        }

        #invoice {

        }

        #invoice h1 {
            color: #0087C3;
            font-size: 2.4em;
            line-height: 1em;
            font-weight: normal;
            margin: 0 0 10px 0;
        }

        #invoice .date {
            font-size: 1.1em;
            color: #777777;
        }

        table {
            width: 100%;
            border-spacing: 0;
            margin-bottom: 20px;
        }

        table th,
        table td {
            padding: 5px 10px 7px 10px;
            background: #EEEEEE;
            text-align: center;
            border-bottom: 1px solid #FFFFFF;
        }

        table th {
            white-space: nowrap;
            font-weight: normal;
        }

        table td {
            text-align: right;
        }

        table td h3 {
            color: #767676;
            font-size: 1.2em;
            font-weight: normal;
            margin: 0 0 0 0;
        }

        table .no {
            color: #FFFFFF;
            font-size: 1.6em;
            background: #767676;
            width: 10%;
        }

        table .desc {
            text-align: left;
        }

        table .unit {
            background: #DDDDDD;
        }


        table .total {
            background: #767676;
            color: #FFFFFF;
        }

        table td.unit,
        table td.qty,
        table td.total
        {
            font-size: 1.2em;
            text-align: center;
        }

        table td.unit{
            width: 35%;
        }

        table td.desc{
            width: 45%;
        }

        table td.qty{
            width: 5%;
        }

        .status {
            margin-top: 15px;
            padding: 1px 8px 5px;
            font-size: 1.3em;
            width: 80px;
            color: #fff;
            float: right;
            text-align: center;
            display: inline-block;
        }

        .status.unpaid {
            background-color: #E7505A;
        }
        .status.paid {
            background-color: #26C281;
        }
        .status.cancelled {
            background-color: #95A5A6;
        }
        .status.error {
            background-color: #F4D03F;
        }

        table tr.tax .desc {
            text-align: right;
            color: #1BA39C;
        }
        table tr.discount .desc {
            text-align: right;
            color: #E43A45;
        }
        table tr.subtotal .desc {
            text-align: right;
            color: #1d0707;
        }
        table tbody tr:last-child td {
            border: none;
        }

        table tfoot td {
            padding: 10px 10px 20px 10px;
            background: #FFFFFF;
            border-bottom: none;
            font-size: 1.2em;
            white-space: nowrap;
            border-bottom: 1px solid #AAAAAA;
        }

        table tfoot tr:first-child td {
            border-top: none;
        }

        table tfoot tr td:first-child {
            border: none;
        }

        #thanks {
            font-size: 2em;
            margin-bottom: 50px;
        }

        #notices {
            padding-left: 6px;
            border-left: 6px solid #0087C3;
        }

        #notices .notice {
            font-size: 1.2em;
        } 


       
        table.billing td {
            background-color: #fff;
        }

        table td div#invoiced_to {
            text-align: left;
        }

        #notes{
            color: #767676;
            font-size: 14px;
            text-align:right;
            margin-right:3px;
        }

        .item-summary{
            font-size: 12px;
        }

        .logo {
            text-align: right;
        }
        .logo img {
            max-width: 150px !important;
        }
    
    </style>
   

</head>
<body style="direction:rtl;" class="{{Lang::locale()}}" onload="window.print()">
<div class="container-fluid" style="margin-left:5px;">
<header>
<img src="{{ url('user-uploads/header/'.$global->header) }}" width="200PX" height="100PX"/>
</header>
<div class="row">
    <div class="col-md-12">
            <h6 style="text-align:center;">بسم الله الرحمن الرحيم</h6>  
            <h2 style="text-align:center; color:red;">عرض أسعار البرنامج</h2>
    </div>
</div>

<div class="row mt-5" style="display:flex;">
    <div class="col-md-12">
    <div class="col-md-6" style="text-align:right;width: 50%;float: right;">
    <h2>التاريخ : {{$estimate->created_at}}<h2>
    </div>
     <div class="col-md-6" style="float:left;width: 50%;">
    <h2>رقم عرض السعر : {{$estimate->note}}</h2>
    </div>
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-12">
        <img src="{{ asset('img/12.png') }}" style="margin-left: 15%;margin-top: 200px;" />
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-12  mt-5">
        @if(!is_null($estimate->client))
        <h1 class="mt-5" style="text-align:center;">مقدم إلى :{{ $estimate->client->client_details->company_name}}</h1>
        @endif 
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-12  mt-5">
        @if(!is_null($estimate->client))
        <h1 class="mt-5" style="text-align:center;">@lang("modules.estimates.validTill"): {{ $estimate->valid_till->format($global->date_format) }}</h1>
        @endif 
    </div>
</div><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div class="row mt-5">
    <div class="col-md-12 mt-5">
    <h1 class="mt-5" style="text-align:right;">العرض الفني:</h1>
   @foreach($estimate->items as $item)
   <h2 class="mt-3" style="text-align:right;">{{ ucfirst($item->item_name) }}</h2>
    @if(!is_null($item->item_summary))
        <p style="font-size: 14px;white-space: pre-wrap;text-align: right;font-weight:bold;">{{$item->item_summary }}</p>
    @endif
   @endforeach
</div>
</div>

<div class="row">
<div class="col-md-12 ">
<h1 style="text-align:right;">العرض المالي:</h1>
 <table  class="table table-bordered">
  <thead>
    <tr>
      <th>م</th>
      <th>المنتج</th>
      <th>عدد الفروع</th>
      <th>عدد المستخدمين</th>
      <th>السعر</th>
      <th>الا<جمالي</th>
    </tr>
  </thead>
  <tbody>
   <?php $count = 0; ?>
   @foreach($estimate->items as $item)
    <tr>
      <th>{{ ++$count }}</th>
      <th>{{ ucfirst($item->item_name) }}</th>
      <th>{{ $item->quantity }}</th>
      <th>3</th>
      <th>{{ number_format((float)$item->unit_price, 2, '.', '') }}</th>
      <th>{{ number_format((float)$item->amount, 2, '.', '') }}</th>
    </tr>
    @endforeach
    
  </tbody>
  </table>
</div>
</div>
<div class="row">
    <div class="col-md-12">
    <h1 style="text-align:right;">الخدمات والمزايا الأخرى: </h1>
    <p style="text-align:right;font-weight:bold;font-size: 14px;">
  -   الدعم الفني والاستضافة السنة الأولى مجانًا.<br/>
  -   تجديد الدعم الفني مقابل 10% من قيمة العقد (اختياري)<br/>.
  -  يتم دفع ٣٧٥ريال سعودي سنويا مقابل الاستضافة.<br/>
  - عند إضافة أو تعديل يرغب به العميل في البرنامج سيتم احتساب رسوم إضافية.

    </p>
</div>
</div>
<div class="row">
    <div class="col-md-12">
    <h1 style="text-align:right;">طرق الدفع: إمكانية الدفع نقدًا دفعة واحدة، الدفع على بيانات الحساب التالي:</h1>
  <table  class="table table-bordered">
  <thead>
    <tr>
      <th>اسم الحساب</th>
      <th>البنك</th>
      <th>الايبان</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>شركة باديا لتقنية المعلومات </th>
      <th>بنك البلاد </th>
      <th>SA7315000608134982520001</th>
    </tr>
  </tbody>
</table>
</div>
</div>
</div>
</body>
</html>