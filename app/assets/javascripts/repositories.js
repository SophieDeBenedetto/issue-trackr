$(function () {
 hideErrors();
})

function hideErrors(){
  $("#errors").on("click", $('[data-panel="close"]'), function(){
    $("#errors").html(" ");
  })
}