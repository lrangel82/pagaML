require("jquery-ui")
require("custom/jquery.dataTables")


$(function(){
   
   $('#loanslisttable tr').click (function() {
       f = $(this).data("dialogpath")
       if( f ){
          f = f + '.json'
          //$.get( f , function(data) {
          //  $('#exampleModalCenter div.modal-body').innerHTML(data);
          //  $('#launchModalBtn').click();
          //} , "text");
          $('#exampleModalCenter div.modal-body').load(f, function(){
            $('#launchModalBtn').click();
          });
       }else{
          f = $(this).data("loanpath")
          document.location = f;
       }
       //alert('Aqui' + this + ": path "+path); 
   });

   $('.datepicker').datepicker({dateFormat: "yy-mm-dd"});
   

   var table = $('#loanslisttable').DataTable( {
         paging: false
        //orderCellsTop: true,
        //fixedHeader: true
    } );

   $('.searchloantable').click(function(){    table.search($(this).data("searchtext")).draw();  });

});
