ActiveAdmin.register Topic do
  permit_params :name, :icon

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :icon, as: :file
    end

    actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :icon do |topic|
      image_tag topic.icon if topic.icon.present?
    end

    actions
  end

  filter :id
  filter :name

  show do
    attributes_table do
      row :id
      row :name
      row :icon
      row :created_at
      row :updated_at
    end
  end
end
