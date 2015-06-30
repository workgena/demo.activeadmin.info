ActiveAdmin.register Phone do
  permit_params :name, :diagonal, :vendor_id

  config.batch_actions = true

  scope :all, default: true
  scope('LG') { |scope| scope.where(vendor: Vendor.find(5)) }

  sidebar 'Batch operations',
          only: [:index],
          if: proc {
            active_admin_config.batch_actions.any? &&
                (params[:q] || params[:scope]) &&
                (authorized?(:batch_edit, resource_class) || authorized?(:batch_destroy, resource_class))
          }, class: 'sidebar_batch_actions_by_filters' do
    para 'This batch actions affect all records involved by current filters and scopes'
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

    button_to 'Delete',
              { action: 'batch_action', q: request.query_parameters[:q], scope: request.query_parameters[:scope] },
              { params: { batch_action: 'batch_destroy' },
                method: :post,
                data: { confirm: 'Are you sure?', disable_with: 'Loading...' } }
  end

  batch_action :batch_update, if: proc { false } do
    unless authorized?(:batch_edit, resource_class)
      redirect_to(:back, flash: {error: 'Access denied'}) and next
    end
    if !params.has_key?(:changes) || params[:changes].empty?
      redirect_to :back and next
    end
    permitted_changes = params.require(:changes).permit(:name, :vendor_id, :diagonal)
    errors = []
    batch_action_collection.each do |record|
      res = update_resource(record, [permitted_changes])
      errors << "#{record.id} | #{record.errors.full_messages.join('. ')}" unless res
    end
    if errors.empty?
      flash[:notice] = 'Batch update done'
    else
      flash[:error] = errors.join(". ")
    end
    redirect_to :back
  end


  batch_action :batch_destroy, if: proc { false } do
    authorize!(ActiveAdmin::Auth::BATCH_DESTROY, resource_class)
    unless authorized?(:batch_destroy, resource_class)
      redirect_to(:back, flash: {error: 'Access denied'}) and next
    end

    errors = []
    batch_action_collection.each do |record|
      res = destroy_resource(record)
      errors << "#{record.id} | Cant be destroyed}" unless res
    end
    if errors.empty?
      flash[:notice] = 'Batch destroy done'
    else
      flash[:error] = errors.join(". ")
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

