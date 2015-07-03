ActiveAdmin.register Phone do
  permit_params :name, :diagonal, :vendor_id, :manufactured_at

  config.batch_actions = true

  scope :all, default: true
  scope('LG') { |scope| scope.where(vendor: Vendor.find(5)) }


  filtered_actions inputs: -> do
                     { name: 'text',
                       diagonal: 'text',
                       manufactured_at: 'datepicker',
                       vendor_id: Vendor.all.map { |region| [region.name, region.id] }
                     }
                   end
end
