require("jquery-ui")
$( document ).ready(function(){

   $('.datepicker').datepicker({dateFormat: "yy-mm-dd"});
   
   $('#btn_add_new_user_in_loan').click(function(){ 
      if( $('#add_new_user').val() == "true" ){
         $('#add_new_user').val("false");
         $(this).text($(this).data('tmptxt'));
      }else{
         $('#add_new_user').val("true");
         $(this).data('tmptxt', $(this).text() );
         $(this).text('\u02C4');
      }
   });
   
   //Auto calculate
   $('#payment_amount').change(function(){
       $('#payment_payment_to_borrowed').val( parseFloat($(this).val()) -  parseFloat($('#payment_profit').val()) ).fadeOut('slow').fadeIn(100).fadeOut('slow').fadeIn(100);
   });
   $('#payment_payment_to_borrowed').change(function(){
       $('#payment_amount').val( parseFloat($(this).val()) +  parseFloat($('#payment_profit').val()) ).fadeOut('slow').fadeIn(100).fadeOut('slow').fadeIn(100);
   });
});