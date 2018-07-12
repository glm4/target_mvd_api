ActiveAdmin.register Target do
  permit_params :title, :lat, :lng, :radius, :topic_id

  form do |f|
    f.object.radius = 100
    f.inputs 'Details' do
      f.input :title
      f.input :lat
      f.input :lng
      f.input :radius
      f.input :topic_id, as: :select, collection: Topic.all
    end

    actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :radius
    column 'Topic' do |t|
      link_to t.topic_id, admin_topic_path(t.topic_id)
    end

    actions
  end

  filter :id
  filter :title

  show do
    attributes_table do
      row :id
      row :title
      row :lat
      row :lng
      row :radius
      row :topic_id
      row :created_at
      row :updated_at
    end
  end
end
