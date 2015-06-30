$(document).ready ->
  $('.show_form_mass_fields_update').click (e)->
    e.preventDefault()
    fields = JSON.parse( $(this).attr('data') )

    ActiveAdmin.dialog_mass_fields_update 'Mass records update by current filters', fields['inputs'],
      (inputs)=>
        url = window.location.pathname + '/batch_action' + window.location.search
        form_data = {
          changes: inputs,
          authenticity_token: $.parseJSON($(e.target).attr("data")).auth_token,
          batch_action: 'batch_update'
        }

        post_to_url(url, form_data)


  $('body').on('mass_update_modal_dialog:after_open', (e, form)->
    form.find('select[name=vendor_id]').chosen()
  )