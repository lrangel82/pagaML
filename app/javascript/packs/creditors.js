require("jquery-ui")
require("custom/jquery.dataTables")

$(document).on('ajax:success', '.filterbtn', function(event, data, status, xhr) {
  //Reload the ajax call for the filters
  init_events_for_creditors();
});
$(document).on('ajax:before', '.filterbtn', function(event, data, status, xhr) {
  $('#user_container_loans').html('<div class="loading mx-auto">Cargando...</div>');
});

function init_events_for_creditors(){
  
   $('.datepicker').datepicker({dateFormat: "yy-mm-dd"});
   

   var table = $('#loanslisttable').DataTable( {
         paging: false
        //orderCellsTop: true,
        //fixedHeader: true
    } );

   $('.searchloantable').off("click");
   $('.searchloantable').click(function(){    table.search($(this).data("searchtext")).draw();  });

   $('.user_loans_item').off("click");
   $('.user_loans_item').click(function(){
      u='/creditors/' + $(this).data("lender") + '/user_loans/' + $(this).data("user");
      only_close = $(this).hasClass("col-12")
      //clear
      $('.user_loans_item.col-12').find(".loans_detail").html("");
      $('.user_loans_item small b').text('\u02C5')
      $('.user_loans_item.col-12').attr("class","user_loans_item col-xs-4 col-md-3 col-lg-2 col-xl");
      
      //load
      if (!only_close){
        $(this).attr("class", "user_loans_item col-12");
        $(this).find('small b').text('\u02C4')
        $(this).find(".loans_detail").html('<div class="loading mx-auto">&nbsp;</div>');
        $(this).find(".loans_detail").load( u +'.json', function(){ init_events_for_creditors(); });
      }
      
      event.preventDefault();
      return false;
   });

   $('.add_payment').off("click");
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

   $('.show_detail_loan').off("click");
   $('.show_detail_loan').click(function(event){
      f = $(this).data("loanpath")
      document.location = f;
      event.preventDefault();
      return false;
   });
}


$(function(){
   init_events_for_creditors();
});
