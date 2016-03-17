# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#myCarousel .carousel-inner > .item:first').addClass 'active'

$.fn.stars = ->
  $(this).each ->
    $(this).html $('<span />')
      .width(Math.max(0, Math.min(10, parseFloat($(this).html()))) * 16)

$ ->
  $('span.stars').stars()
