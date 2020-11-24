require("jquery-ui")

$(function(){
   $('tr').click (function() {
       path = $(this).data("loanpath") + '.json'
       $.get( path , function(data) {
         $('#dialog_addpayment').html(data).dialog();
         //alert("response:" + data)
       } , "text");
       //alert('Aqui' + this + ": path "+path); 
   });
});
