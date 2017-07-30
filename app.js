const sortedContainers = sortable(".js-sortable-items", {
  forcePlaceholderSize: true,
connectWith: "connected-items"
});


sortedContainers.forEach(function(element) {
  element.addEventListener("sortupdate", function(e) {
    console.log("We will learn how to save this dynamically");
    $("save").removeClass("hidden");
  });
});

var addItem = function(event){
  console.log("submitting the form", event.target);
  event.preventDefaul();
  $addForm = $(event.target);

  data = $addForm.serializeArray();
  console.log("submit", data);

$ajax({
  url: $addForm.attr("action"),
  method: $addForm.attr("method"),
  data: data 
  });
};

$(".add-list").click(function(){
 $(".add-list-form").removeClass("hidden");
 $("input:text").focus();
 $(".add-list").addClass("hidden");
})

$(".add-list-form").focusout(function(){
 $(".add-list-form").addClass("hidden");
  $(".add-list").removeClass("hidden");
})
 