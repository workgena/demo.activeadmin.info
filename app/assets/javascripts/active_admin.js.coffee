#= require active_admin/base
#= require chosen-jquery

$(document).on 'ready page:load', ->

  $('body').on 'modal_dialog:before_open', (event, form)->
    console.log('Event modal_dialog:before_open')

  $('body.admin_dashboard').on 'modal_dialog:after_open', (event, form)->
    console.log('Event modal_dialog:after_open')
    $('form#dialog_confirm select').chosen()

  setTimeout( ->
    ActiveAdmin.modal_dialog 'Testing', { name: [['First', 1], ['Second', 2]] },
      (inputs)=>
        console.log('modal_dialog: OK pressed')
  , 2000)
