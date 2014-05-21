//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require toast
//= require confirmation
//= require_tree .

$(document).on "ready page:change", ->
  $('.navbar-nav > li > a').tooltip()
  $('.addtooltip').tooltip()
  resize()

$(window).resize ->
  resize()

resize = () ->
  $('.v-center').css('height',$(window).height())
