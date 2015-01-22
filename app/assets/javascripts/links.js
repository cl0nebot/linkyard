$(function() {
  $("body.links").each(function() {
    $("#tags").tagit({
      availableTags: $("#link_submission_tags").data("tags"),
      singleField: true,
      singleFieldNode: $("#link_submission_tags")
    });
  });

  $("body.links-new").each(function() {
    function View() {
      var input = {
        title : $("#link_submission_title"),
        content : $("#link_submission_content")
      };

      this.url = $("#link_submission_url");

      this.update = function(title, content) {
        input.title.val(title);
        input.title.prop("disabled", false);
        input.content.val(content);
        input.content.prop("disabled", false);
      };

      this.loading = function() {
        input.title.prop("disabled", true);
        input.content.prop("disabled", true);
      };
    }

    function Controller(view) {
      var api = window.api_path + "/parse?url="
      var updateArticle = function() {
        if (!$(this).val()) return;

        view.loading();
        $.get(api + $(this).val())
          .done(function(data) { view.update(data.title, data.content); })
          .fail(function(error) { view.update("", ""); });
      };

      this.init = function() {
        view.url.focusout(updateArticle);
      };
    }

    var controller = new Controller(new View());
    controller.init();
  });
});
