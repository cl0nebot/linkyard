$(function() {


  $("#interaction_type").on("change", function(e) { loadInteractionTemplate($(e.currentTarget).val()); });
  $("#interaction_type").each(function() { loadInteractionTemplate($(this).val()); });

  function loadInteractionTemplate(type) {
    var container = $("#new-interaction-container");
    container.load(window.location.href + "?type=" + type, function(response, status, request) {
      if (status == "error") {
        container.html("<p>An error occurred while trying to load a new interaction.</p>");
        container.addClass("error");
      } else {
        container.removeClass("error");
      }
    });
  }
});
