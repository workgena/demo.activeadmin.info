ActiveAdmin.register Phone do
  permit_params :name, :diagonal, :vendor_id, :manufactured_at

  config.batch_actions = true

  scope :all, default: true
  scope('LG') { |scope| scope.where(vendor: Vendor.find(5)) }

  action_item :view, only: :index do
    link_to 'Import Phones', { action: :generate_phones }, method: :post
  end

  collection_action :generate_phones, method: :post do
    10.times do |n|
      vendor = Vendor.all.sample
      Phone.create(name: "Phone #{n} by #{vendor.name}", vendor: vendor, diagonal: rand(3...8))
    end
    redirect_to collection_path, notice: 'New phones was generated successfully!'
  end


  # scoped_collection_action :sms_send, { form: -> { {
  #                                diagonal: 'text',
  #                                vendor_id: Vendor.pluck(:name, :id) }
  #                            } } do |selection|
  #   flash[:notice] = "SMS sent successfully #{selection}."
  #   render nothing: true, status: :no_content
  # end

  # scoped_collection_action :batch_destroy

  scoped_collection_action :batch_update, form: -> do
                                          { name: 'text',
                                            diagonal: 'text',
                                            manufactured_at: 'datepicker',
                                            vendor_id: Vendor.all.map { |region| [region.name, region.id] },
                                            has_3g: [['Yes', 't'], ['No', 'f']]
                                          }
                                        end

end
