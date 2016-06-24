$(function() {
  $("body.links").each(function() {
    $("#tags").tagit({
      availableTags: $("#link_submission_tags").data("tags"),
      singleField: true,
      singleFieldNode: $("#link_submission_tags"),
      beforeTagAdded: function(e, ui) {
        if (!ui.duringInitialization) {
          var tags = ui.tagLabel.split(/[\s,]+/);
          if (tags.length > 1) {
            for (var i = 0; i < tags.length; i++) {
              $("#tags").tagit("createTag", tags[i]);
            }
            return false;
          }
        }
      },
    });
  });

  $("body.links-new").each(function() {
    $("#add-tracking").click(function() {
      var digest = $("#link_submission_digest").val();
      $("#link_submission_url").val($("#link_submission_url").val() + "?utm_source=" + digest + "digest&utm_medium=email&utm_campaign=sponsored");
    });

    function View() {
      var input = {
        url : $("#link_submission_url"),
        title : $("#link_submission_title"),
        content : $("#link_submission_content")
      };

      this.url = $("#link_submission_url");

      this.update = function(url, title, content) {
        input.url.val(url);
        input.url.prop("disabled", false);
        input.title.val(title);
        input.title.prop("disabled", false);
        input.content.val(content);
        input.content.prop("disabled", false);
      };

      this.loading = function() {
        input.url.prop("disabled", true);
        input.title.prop("disabled", true);
        input.content.prop("disabled", true);
      };
    }

    function Controller(view) {
      var api = "/api/links/new?remove_utm_params=false&url="
      var updateArticle = function() {
        if (!$(this).val()) return;

        view.loading();
        $.getJSON(api + encodeURIComponent($(this).val()))
          .done(function(data) { view.update(data.link_submission.url, data.link_submission.title, data.link_submission.content); })
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
