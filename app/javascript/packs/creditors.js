require("jquery-ui")
require("custom/jquery.dataTables")


$(function(){
   
   $('#loanslisttable tr').click (function() {
       f = $(this).data("loanpath") + '.json'
       $.get( f , function(data) {
         //alert("response:" + data)
         $('#exampleModalCenter div.modal-body').html(data);
         $('#launchModalBtn').click();
         //$('#exampleModalCenter').modal('show')
       } , "text");
       //alert('Aqui' + this + ": path "+path); 
   });

   

   var table = $('#loanslisttable').DataTable( {
         paging: false
        //orderCellsTop: true,
        //fixedHeader: true
    } );

   $('#searchDelayed').click(function(){      table.search('Open delayed').draw();   });
   $('#searchAware').click(function(){        table.search('Open aware').draw();   });
   $('#searchPaied').click(function(){        table.search('Paid').draw();   });
   $('#searchClosed').click(function(){       table.search('Close Cancel').draw();   });
   

});
