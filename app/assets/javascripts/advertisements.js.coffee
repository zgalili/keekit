# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.dropdown-toggle').dropdown()
  $(".carousel-inner .item:first").addClass("active")

  $("span.star-rating-control div.star-rating").click -> 
    $.ajax({
      type: "POST",
      dataType: "json",
      url: ($(this).parents("form").attr("action") + ".json"),
      data: { rating: { value: $(this).parents("form").find("[name='rating[value]']:checked").val() } },
      success: (obj) ->
        $("#car_item_" + obj.ad_id).find(".rating").text(obj.rating).removeClass("hidden")
        $("#car_item_" + obj.ad_id).find("div.field").text("Your rating: " + obj.your_rating).children().remove()
    })
