$(function(){
   $('tr').click (function() {
       path = $(this).data("loanpath")
       alert('Aqui' + this + ": path "+path); 
   });
});
