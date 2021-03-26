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

   $('#search_users').autocomplete({
      source: "/client/search.json",
      minLength: 2,
      response: function(event,ui){
         if( ui.content.length == 0){
            $('#search_users').addClass('is-invalid');
            $('#loan_user_id').val('');
         }
      },
      select: function(event,ui){
         $('#loan_user_id').val( ui.item.id ); 
         $('#search_users').removeClass('is-invalid');
         //alert('Value: '+ui.item.value);
         //alert('Id: '+ui.item.id);
      }
   });
   
   //Auto calculate
   $('#payment_amount').change(function(){
       if ( $('#autocalculate').is(":checked")){
         p_total   = parseFloat($(this).val())
         p_interes = parseFloat($('#payment_profit').data("original"));
         p_capital = p_total -  p_interes  ;
         if( p_capital < 0){ 
            //es negativo, pasa a 0 y se cambia el interes
            p_interes = p_total
            p_capital = 0
         }
         $('#payment_payment_to_borrowed').val( p_capital ).fadeOut('slow').fadeIn(100).fadeOut('slow').fadeIn(100);
         $('#payment_profit').val( p_interes ).fadeOut('slow').fadeIn(100).fadeOut('slow').fadeIn(100);
       }
         
   });
   $('#payment_payment_to_borrowed').change(function(){
       if ( $('#autocalculate').is(":checked")){
         p_total = parseFloat($(this).val()) +  parseFloat($('#payment_profit').val())
         $('#payment_amount').val( p_total ).fadeOut('slow').fadeIn(100).fadeOut('slow').fadeIn(100);
       }
   });
   $('#payment_profit').change(function(){
       if ( $('#autocalculate').is(":checked")){
         p_capital = parseFloat( parseFloat($('#payment_amount').val() - $(this).val()) )
         $('#payment_payment_to_borrowed').val( p_capital ).fadeOut('slow').fadeIn(100).fadeOut('slow').fadeIn(100);
       }
   });

});