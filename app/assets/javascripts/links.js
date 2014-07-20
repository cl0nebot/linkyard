$(function() {
  $("body.links").each(function() {
    $("#tags").tagit({
      availableTags: $("#link_submission_tags").data("tags"),
      singleField: true,
      singleFieldNode: $("#link_submission_tags")
    });
  });
});
