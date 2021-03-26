require("jquery-ui")

$(function(){
   $('.select_type').click(function(){
      
      $('#loan_description').val( $(this).data("description") );
      $('#loan_payment_frequency_days').val( $(this).data("payment_frequency_days") );
      $('#loan_number_of_payments').val( $(this).data("number_of_payments") );
      $('#loan_profit_by_payment').val( $(this).data("profit_by_payment") );
      $('#loan_is_profit_balane').prop( "checked", $(this).data("is_profit_balane") );
      calculate_monto();
   });


   $('#loan_payment_frequency_days').on( "change", calculate_monto );
   $('#loan_number_of_payments').on( "change", calculate_monto );
   $('#loan_profit_by_payment').on( "change", calculate_monto );
   $('#loan_is_profit_balane').on( "change", calculate_monto );
   $('#loan_amount_borrowed').on( "change", calculate_monto );

   function calculate_monto(){
      if ( ! Number.isNaN( $('#loan_amount_borrowed').val() ) ){
         monto = Number($('#loan_amount_borrowed').val());
         if( monto > 0){
            isprofit = $('#loan_is_profit_balane').is(":checked");
            f = Number($('#loan_payment_frequency_days').val());
            n = Number($('#loan_number_of_payments').val());
            p = Number($('#loan_profit_by_payment').val());
            $('#loan_payment_frequency_days').val(f);
            $('#loan_number_of_payments').val(n);
            $('#loan_profit_by_payment').val(p);
            
            if(p >= 0 && n>0 ){
               if (isprofit){
                  mp = monto * p/100;
                  $('.monto_pago').text( "$" + mp.toFixed(2) );
                  return;
               }
               else{
                  mp = (monto * (p/100*n + 1) )/n;
                  $('.monto_pago').text( "$" + mp.toFixed(2) );
                  return;
               }
            }
         }
      }

      $('.monto_pago').text('-');
   }

   //Runs at load
   calculate_monto();
});

