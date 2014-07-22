$(function() {
  $("body.links").each(function() {
    console.log($("#link_submission_tags").data("tags"));
    $("#tags").tagit({
      availableTags: $("#link_submission_tags").data("tags"),
      singleField: true,
      singleFieldNode: $("#link_submission_tags")
    });
  });
});
