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

Date::toDateInputValue = (->
  local = new Date(this)
  local.setMinutes @getMinutes() - @getTimezoneOffset()
  local.toJSON().slice 0, 10
)

$(document).ready ->
  $('.datepicker').val new Date().toDateInputValue()
