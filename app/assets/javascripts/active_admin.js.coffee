#= require active_admin/base
#= require active_admin_scoped_collection_actions
#= require active_admin_datetimepicker

$(document).ready ->
  $('body').on 'mass_update_modal_dialog:after_open', (e, form) ->
    $(form).find('input.datepicker').removeClass('datepicker').addClass('date-time-picker')
    setupDateTimePicker form