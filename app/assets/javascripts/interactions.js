$(function() {
  $("#type").on("change", function(e) { loadInteractionTemplate($(e.currentTarget).val()); });
  $("#type").each(function() { loadInteractionTemplate($(this).val()); });

  function loadInteractionTemplate(type) {
    var container = $("#new-interaction-container");
    $.get("/interactions/new?type=" + type)
      .done(function(data) { container.html(data).removeClass("error"); })
      .fail(function(error) { 
        console.log(error);
        container.html("<h3>An error occurred</h3>" + error.responseText);
        container.addClass("error");
      });
  }
});
