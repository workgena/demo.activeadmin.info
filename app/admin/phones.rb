ActiveAdmin.register Phone do
  permit_params :name, :diagonal, :vendor_id

  sidebar "Mass update/delete" do
    button 'Edit', {
                     class: :show_form_mass_fields_update,
                     data: {
                         inputs: {
                             name: 'text',
                             diagonal: 'text',
                             vendor_id: Vendor.all.map { |region| [region.name, region.id] }
                         },
                         auth_token: form_authenticity_token.to_s
                     }.to_json
                 }
    # add confirm are you shore ?
    button 'Delete'
  end

  batch_action :batch_update, if: proc { false } do
    unless authorized?(:batch_edit, resource_class)
      flash[:error] = 'Access denied'
    else
      batch_action_collection.each do |record|
        update_resource(record, {diagonal: "5"})
      end
      flash[:notice] = 'Batch update done'
    end
    redirect_to :back
  end

end






  #todo if authorized?(:batch_edit, active_admin_config.resource_class) do
  #todo if authorized?(:batch_destroy, active_admin_config.resource_class) do

  # active_admin_import authorized?

  # два экшена

  # показывать сайдбра если можно хотябы дел или апдейт

  # добавить callbacks на диалог (opend, closed)

  # admin.batch_actions = false - значит не рендерим сайдбра

  # barch_update

  # batch_action :batch_update, if: proc{ authorized?(:batch_update, resource_class) } do |_|
  #
  #   #params["scope"] params["q"]
  #   #scope, filtrers, etc
  #
  #   batch_action_collection.each do |record|
  #
  #     # params[:changes] проверить что бы не было лишним от button 'Edit'
  #
  #
  #       authorize! ActiveAdmin::Auth::UPDATE, record
  #       update_resource(record, {})
  #     end
  #
  #
  # end

  # https://github.com/activeadmin-plugins/active_admin_import/blob/736cd4fd82d191f8ab6fe06d3dfee29fa3be1793/lib/active_admin_import/authorization.rb
  # only baych_update AND batch_destroy



  # batch_action :batch_destroy, if: proc{ authorized?(:batch_destroy, resource_class) } do |_|
  #
  #   #params["scope"] params["q"]
  #   #scope, filtrers, etc
  #
  #   batch_action_collection.each do |record|
  #
  #     # params[:changes] проверить что бы не было лишним от button 'Edit'
  #     authorize! ActiveAdmin::Auth::DESTROY, record
  #     destroy_resource(record, {})
  #   end


    #flash[]
  #
  # end

