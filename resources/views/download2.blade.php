<!DOCTYPE html>

<html lang="ar">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="{{ $global->favicon_url }}">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="{{ $global->favicon_url }}">
    <meta name="theme-color" content="#ffffff">

    <title>{{ $invoice->invoice_number }}</title>
    <!-- Bootstrap Core CSS -->
    <link href="{{ asset('plugins/bootstrap/dist/css/bootstrap.min.css') }}" rel="stylesheet"  media='all'>
    <link rel='stylesheet prefetch'
          href='https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/css/flag-icon.min.css'  media='all'>
    <link rel='stylesheet prefetch'
          href='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/css/bootstrap-select.min.css'  media='all'>

    <!-- This is Sidebar menu CSS -->
    <link href="{{ asset('plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css') }}" rel="stylesheet"  media='all'>

    <link href="{{ asset('plugins/bower_components/toast-master/css/jquery.toast.css') }}"   rel="stylesheet"  media='all'>
    <link href="{{ asset('plugins/bower_components/sweetalert/sweetalert.css') }}"   rel="stylesheet"  media='all'>

    <!-- This is a Animation CSS -->
    <link href="{{ asset('css/animate.css') }}" rel="stylesheet"  media='all'>

@stack('head-script')

<!-- This is a Custom CSS -->
    <link href="{{ asset('css/style.css') }}" rel="stylesheet"  media='all'>
    <!-- color CSS you can use different color css from css/colors folder -->
    <!-- We have chosen the skin-blue (default.css) for this starter
       page. However, you can choose any other skin from folder css / colors .
       -->
    <link href="{{ asset('css/colors/default.css') }}" id="theme"  rel="stylesheet"  media='all'>
    <link href="{{ asset('plugins/froiden-helper/helper.css') }}"   rel="stylesheet"  media='all'>
    <link href="{{ asset('css/custom-new.css') }}"   rel="stylesheet"  media='all'>
    <link href="{{ asset('css/rounded.css') }}"   rel="stylesheet"  media='all'>


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>

    <![endif]-->

    <style>
        .sidebar .notify  {
            margin: 0 !important;
        }
        .sidebar .notify .heartbit {
            top: -23px !important;
            right: -15px !important;
        }
        .sidebar .notify .point {
            top: -13px !important;
        }

        .admin-logo {
            max-height: 40px;
        }

        .ribbon {
            top: 12px !important;
            left: 0px;
        }
        
        .rightdiv { 
            width:100%; height: 200px;
                font-family: "Times New Roman", Times, serif;
                font-size: 1.1em;
                font:bold;
                overflow:hidden;
                margin-left:auto;
                margin-right:auto;
                text-align:right;
                padding-left:4px;
                  resize: none;
                  border:none;
                padding-top:60px;    /*HERE*/
                display:none;
    }
    
        body {
    direction: rtl;
    text-align: right;
    margin: 10px;
}

 header {
                /*position: fixed;*/
                top: 0cm;
                left: 0cm;
                right: 0cm;
                height: 3cm;
            }

            /** Define the footer rules **/
            footer {
                position: fixed; 
                bottom: 0cm; 
                left: 0cm; 
                right: 0cm;
            }

.col-md-offset-2 {
    margin-right: 16.66666667%;
}   
.col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-xs-1, .col-xs-10, .col-xs-11, .col-xs-12, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7, .col-xs-8, .col-xs-9
{
    float: right;
}
.pull-left {
    float: right !important;
}
.pull-right {
    float: left !important;
}
th {
    text-align: right;
}
p{
    font-weight:bold;
}
td{
    font-weight:bold;
}
/* @media print {
  @page { margin: 0;}
  body { margin: 0; }
  body,html,.container,.row,.col-md-12,.col-lg-12,.col-xs-12
  {
      width:100%;
  }
  .rightdiv{
      display:block;
  }
  
} */

    </style>
</head>
<body class="fix-sidebar" onload="window.print()" class="{{Lang::locale()}}">
<div id="wrapper">


<!-- Left navbar-header end -->
    <!-- Page Content -->
    

    <div id="page-wrapper" style="margin-left: 0px !important;">
        <div class="container-fluid">
        <header>
          
            <img src="{{ url('user-uploads/header/'.$global->header) }}" width="100%" height="100%"/>
          
        </header>
        <!-- .row -->
            <div class="row">

                <div class="col-md-12 ">
                    <div class="card">
                        <div class="card-body">


                    <div class="white-box printableArea ribbon-wrapper" style="background: #ffffff !important;">
                        <div class="ribbon-content p-20" id="invoice_container">
                            @php
                                $project_number = \DB::table('custom_fields_data')
                                                    ->where('model', 'App\Project')
                                                    ->where('model_id', $invoice->project_id)
                                                    ->where('custom_field_id', '4')
                                                    ->first()->value ?? '' ;
                                $client_ref_number =  \DB::table('custom_fields_data')
                                                    ->where('model', 'App\Project')
                                                    ->where('model_id', $invoice->project_id)
                                                    ->where('custom_field_id', '3')
                                                    ->first()->value ?? '';
                            @endphp
                            <h3 class="text-right"><b>{{ $invoice->invoice_number }}</b></h3>
                            <hr>
                            <div class="row">
                                    
                                <div class="col-md-6">
                                                            <?php /* <img src="{{ $global->logo_url }}" alt="home" class="admin-logo"/> */ ?>

                                    <address>
                                        <h3> من: &nbsp;<b class="text-danger">{{ ucwords($global->company_name) }}</b></h3>
                                        
                                        


                                            @if(!is_null($settings))
                                                <p class=" m-l-5">{!! nl2br($global->address) !!}</p>
                                            @endif
                                                            <p class="m-l-5"><b>@lang('app.phone')
                                                        :</b>{{ $global->company_phone }}</p>
                                                            <p class=" m-l-5"><b>@lang('app.email')
                                                        :</b>{{ $global->company_email }}</p>

                                            @if($invoiceSetting->show_gst == 'yes' && !is_null($invoiceSetting->gst_number))
                                                <p class="m-l-5"><b>@lang('app.tax_number')
                                                        :</b>{{ $invoiceSetting->gst_number }}</p>
                                            @endif
                                            
                                
                                        </address>
                                        
                                        <p>رقم المشروع : {{ $project_number }}</p>
                                    </div>
                                
                                    <div class="col-md-6 text-right" style="float: left;">
                                        <address>
                                            @if(!is_null($invoice->project_id) && !is_null($invoice->project->client))
                                                <h3>الى: <b> {{ ucwords($invoice->project->project_name) }} </b> </h3>
                                                 <h4>عناية: <b> {{ ucwords($invoice->project->client->name) }}  </b> </h4>

                                                <p class="m-l-30">
                                                    <b>@lang('app.address') :</b>
                                                    <span class="">
                                                        {!! nl2br($invoice->project->client->client_details->address) !!}
                                                    </span>
                                                </p>
                                                @if($invoice->show_shipping_address === 'yes')
                                                    <p class="m-t-5">
                                                        <b>@lang('app.shippingAddress') :</b>
                                                        <span class="">
                                                            {!! nl2br($invoice->project->client->client_details->shipping_address) !!}
                                                        </span>
                                                    </p>
                                                @endif
                                                    <p class="m-t-5"><b>@lang('app.phone')
                                                            :</b>  {{ $invoice->project->client->mobile }}
                                                    </p>
                                                    @if($invoiceSetting->show_gst == 'yes' && !is_null($invoice->clientdetails) && !is_null($invoice->clientdetails->gst_number))
                                                    <p class="m-t-5"><b>@lang('app.customer_gstNumber')
                                                            :</b>  {{ $invoice->clientdetails->gst_number }}
                                                    </p>
                                                @endif
                                            @elseif(!is_null($invoice->client_id))
                                                <h3>@lang('modules.invoices.to'),</h3>
                                                <h4 class="font-bold">{{ ucwords($invoice->client->name) }}</h4>
                                                <p class="m-l-5">
                                                    <b>@lang('app.address') :</b>
                                                    <span class="">
                                                        {!! nl2br($invoice->clientdetails->address) !!}
                                                @endif

                                        <p class="m-t-5"><b>@lang('modules.invoices.invoiceDate') :</b> <i
                                                    class="fa fa-calendar"></i> {{ $invoice->issue_date->format($global->date_format) }}
                                        </p>

                                        <p><b>@lang('modules.dashboard.dueDate') :</b> <i
                                                    class="fa fa-calendar"></i> {{ $invoice->due_date->format($global->date_format) }}
                                        </p>
                                        @if($invoice->recurring == 'yes')
                                            <p><b class="text-danger">@lang('modules.invoices.billingFrequency') : </b> {{ $invoice->billing_interval . ' '. ucfirst($invoice->billing_frequency) }} ({{ ucfirst($invoice->billing_cycle) }} cycles)</p>
                                        @endif
                                    </address>
                                    
                                    <p>الرقم المرجعي للعميل :  {{ $client_ref_number }}</p>
                                </div>
                                    
                                <div class="col-md-12">
                                    <div class="table-responsive m-t-40" style="clear: both;">
                                        <table class="table table-hover">
                                            <thead>
                                            <tr>
                                                <th class="text-center">#</th>
                                                <th>@lang("modules.invoices.item")</th>
                                                <th class="text-right">@lang("modules.invoices.qty")</th>
                                                <th class="text-right">@lang("modules.invoices.unitPrice")</th>
                                                <th class="text-right">@lang("modules.invoices.totalPrice")</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php $count = 0; ?>
                                            @foreach($invoice->items as $item)
                                                @if($item->type == 'item')
                                                    <tr>
                                                        <td class="text-center">{{ ++$count }}</td>
                                                        <td>{{ ucfirst($item->item_name) }}
                                                            @if(!is_null($item->item_summary))
                                                                <p class="font-12">{{ $item->item_summary }}</p>
                                                            @endif
                                                        </td>
                                                <td class="text-right">{{ $item->quantity }}</td>
                                                        <td class="text-right"> {!! htmlentities($invoice->currency->currency_symbol)  !!}{{ $item->unit_price }} </td>
                                                        <td class="text-right"> {!! htmlentities($invoice->currency->currency_symbol)  !!}{{ $item->amount }} </td>
                                                    </tr>
                                                @endif
                                            @endforeach
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix clear-fix"></div>
                            <div class="row">
                                                                        <?php 
                                                                        
                                                                        $tax = ($invoice->sub_total * 15) / 100;
                                                                        $total = $invoice->sub_total + $tax;
                                                                        ?>
                                      
                                        

                                        @php
                                        $array_tag = [$global->company_name,$invoiceSetting->gst_number,$invoice->issue_date,$total,$tax];
                                        $index=1;
                                        $tlv_string = "";
                                        foreach($array_tag as $tag_val){
                                            $tlv_string.=pack("H*", sprintf("%02X",(string) "$index")).
                                                         pack("H*", sprintf("%02X",strlen((string) "$tag_val"))).
                                                         (string) "$tag_val";
                                            $index++;                              
                                        }      
                                        $result = base64_encode($tlv_string);
                                        
                                        @endphp

                                    <div class="col-md-6 m-t-30 text-right">
                                        <img src="https://chart.googleapis.com/chart?chs=170x170&cht=qr&chl={{ $result }}&choe=UTF-8" >
                                    </div>
                                    <div class="col-md-6 m-t-30 text-right">
                                        <p>@lang("modules.invoices.subTotal")
                                            : {!! htmlentities($invoice->currency->currency_symbol)  !!}{{ $invoice->sub_total }}</p>

                                        @if ($discount > 0)
                                            <p>@lang("modules.invoices.discount")
                                            : {!! htmlentities($invoice->currency->currency_symbol)  !!}{{ $discount }} </p>
                                        @endif
                                       
                                        <p class="m-t-30"><b>@lang('modules.invoices.vat') :</b> {!! htmlentities($invoice->currency->currency_symbol)  !!} {{ $tax }}
                                        </p>
                                        <hr>
                                        <h3><b>@lang("modules.invoices.totalAfterTaxes")
                                                :</b> {!! htmlentities($invoice->currency->currency_symbol)  !!} {{ $tax + $invoice->sub_total }}
                                        </h3>
                                        <hr>
                                        @if ($invoice->credit_notes()->count() > 0)
                                            <p>
                                                @lang('modules.invoices.appliedCredits'): {{ $invoice->currency->currency_symbol.''.$invoice->appliedCredits() }}
                                            </p>
                                        @endif
                                    </div>

                                    @if(!is_null($invoice->note))
                                        <div class="col-md-12">
                                            <p><strong>@lang('app.note')</strong>: {{ $invoice->note }}</p>
                                        </div>
                                    @endif
                                  
                            </div>
                        </div>
                    </div>
                        </div>
                    </div>
                </div>


            </div>

        </div>
        
        
        <footer>
                    <textarea class="rightdiv" name='comments' disabled style="font-size:1.3em">{!! $invoiceSetting->invoice_terms !!}</textarea>
                    <textarea class="rightdiv" name='comments' style="font-size:1.2em;margin-right:100px" disabled >
                      المركز الرئيسي – جدة – شارع فلسطين ص.ب 2843 الرمز البريدي 23223 هاتف 01266170335
                     فرع الرياض – شارع الأمير عبدالعزيز بن مساعد هاتف – 0555733721 الموقع WWW.SDECGROUP.COM
                    </textarea>
                    
                    <!--<img class="rightdiv" src="{{ url('user-uploads/footer/'.$global->footer) }}" width="100%" height="100%"/>-->
    </footer>
        <!-- /.container-fluid -->

    </div>
</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="{{ asset('plugins/bower_components/jquery/dist/jquery.min.js') }}"></script>
<!-- Bootstrap Core JavaScript -->
<script src="{{ asset('plugins/bootstrap/dist/js/bootstrap.min.js') }}"></script>
<script src='https:{{ asset('js/bootstrap-select.min.js') }}'></script>

<!-- Sidebar menu plugin JavaScript -->
<script src="{{ asset('plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.js') }}"></script>
<!--Slimscroll JavaScript For custom scroll-->
<script src="{{ asset('js/jquery.slimscroll.js') }}"></script>
<!--Wave Effects -->
<script src="{{ asset('js/waves.js') }}"></script>
<!-- Custom Theme JavaScript -->
<script src="{{ asset('plugins/bower_components/sweetalert/sweetalert.min.js') }}"></script>
<script src="{{ asset('js/custom.min.js') }}"></script>
<script src="{{ asset('js/jasny-bootstrap.js') }}"></script>
<script src="{{ asset('plugins/froiden-helper/helper.js') }}"></script>
<script src="{{ asset('plugins/bower_components/toast-master/js/jquery.toast.js') }}"></script>

{{--sticky note script--}}
<script src="{{ asset('js/cbpFWTabs.js') }}"></script>
<script src="{{ asset('plugins/bower_components/icheck/icheck.min.js') }}"></script>
<script src="{{ asset('plugins/bower_components/icheck/icheck.init.js') }}"></script>
<script src="{{ asset('js/jquery-ui.min.js') }}"></script>
<script src="https://js.stripe.com/v3/"></script>

<script>
        //   window.onload = function() { window.print(); }

</script>

</body>
</html>
