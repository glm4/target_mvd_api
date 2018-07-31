ActiveAdmin.register Match do
  permit_params :last_message

  index do
    selectable_column
    id_column
    column 'Original Target' do |m|
      link_to m.original_target_id, admin_target_path(m.original_target_id)
    end
    column 'Matching Target' do |m|
      link_to m.matching_target_id, admin_target_path(m.matching_target_id)
    end
    column :last_message

    actions
  end

  filter :id
  filter :original_target_id
  filter :matching_target_id

  show do
    attributes_table do
      row :id
      row :original_target_id
      row :matching_target_id
      row :last_message
      row :unread_messages
      row :created_at
      row :updated_at
    end
  end
end
