$(function () {
 $("div[data-show='issue']").hide();
 hideErrors();
 toggleIssues();
})

function hideErrors(){
  $("#errors").on("click", $('[data-panel="close"]'), function(){
    $("#errors").html(" ");
  })
}

function toggleIssues(){
  $("[data-id='repo-list']").on("click", $("#issue-count"), function(e){
    repoId = e.toElement.dataset.repo
    $("[data-issue-repo='" + repoId + "']").slideToggle();
  })
}

