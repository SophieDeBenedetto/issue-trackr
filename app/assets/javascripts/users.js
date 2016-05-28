$(function () {
 togglePhoneEdit();
 submitPhoneEdit();
})

function togglePhoneEdit(){
  $("[data-select='phone-edit-parent']").on("click",  $("[data-select='phone-edit']"), function(e){
    e.stopImmediatePropagation();
    e.preventDefault();
    if ($(e.target).is('[data-select="phone-edit"]')) {      
      $("[data-id='phone-number']").html("<label>phone: </label><input type='phone' class='my-form-control' id='phone-form'>")
    }
  })
}

function submitPhoneEdit(){
  $("[data-id='phone-number']").keypress($("#phone-form"), function(e) {
    if(e.which == 13) {
      var num = $("#phone-form").val()
      if (num.match(/\d{3}-\d{3}-\d{4}/) == null){
        alert("phone number must be in xxx-xxx-xxxx format!")
      } else {
        var userId = $(this).data().user
        $.ajax({
          method: "PUT",
          url: "/users/" + userId,
          data: {user: {phone_number: num}}
        })
      }
    }
  })
  
}