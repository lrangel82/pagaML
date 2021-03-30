$(function(){
   //$('.show_detail_loan').off("click");
   $('.show_detail_loan').click(function(event){
      var f = $(this).data("loanpath")
      document.location = f;
      event.preventDefault();
      return false;
   });
});