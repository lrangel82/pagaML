require("jquery-ui")
require("custom/jquery.dataTables")

function init_events_for_creditors(){
  /*$('#loanslisttable tr').click (function() {
       f = $(this).data("dialogpath")
       if( f ){
          f = f + '.json'
          $('#exampleModalCenter div.modal-body').load(f, function(){
            $('#launchModalBtn').click();
          });
       }else{
          f = $(this).data("loanpath")
          document.location = f;
       }
       //alert('Aqui' + this + ": path "+path); 
   });*/

   $('.datepicker').datepicker({dateFormat: "yy-mm-dd"});
   

   var table = $('#loanslisttable').DataTable( {
         paging: false
        //orderCellsTop: true,
        //fixedHeader: true
    } );

   $('.searchloantable').click(function(){    table.search($(this).data("searchtext")).draw();  });

   $('.user_loans_item').click(function(){
      if ( $(this).hasClass("col-12") ) return true;
      u='/creditors/' + $(this).data("lender") + '/user_loans/' + $(this).data("user");
      //clear
      $('.user_loans_item.col-12').find(".loans_detail").html("");
      $('.user_loans_item.col-12').attr("class","user_loans_item col-xs-4 col-md-3 col-lg-2 col-xl");

      //load
      $(this).attr("class", "user_loans_item col-12");
      $(this).find(".loans_detail").load( u +'.json', function(){ init_events_for_creditors(); });
      
   });

   $('.add_payment').click(function(event){
      f = $(this).data("dialogpath")
      if(f.length > 0){
          f = f + '.json'
          $('#exampleModalCenter div.modal-body').load(f, function(){
            $('#launchModalBtn').click();
          });
      }
      event.preventDefault();
      return false;
   });

   $('.show_detail_loan').click(function(event){
      f = $(this).data("loanpath")
      document.location = f;
      event.preventDefault();
   });
}

$(function(){
   init_events_for_creditors();
});
