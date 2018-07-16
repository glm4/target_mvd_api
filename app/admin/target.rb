ActiveAdmin.register Target do
  permit_params :title, :lat, :lng, :radius, :topic_id, :user_id

  form do |f|
    f.object.radius = 100
    f.inputs 'Details' do
      f.input :title
      f.input :lat
      f.input :lng
      f.input :radius
      f.input :user_id, as: :select, collection: User.all
      f.input :topic_id, as: :select, collection: Topic.all
    end

    actions
  end

  controller do
    def scoped_collection
      super.includes(:topic, :user)
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :lat
    column :lng
    column :radius
    column 'Topic' do |t|
      link_to t.topic.name, admin_topic_path(t.topic_id)
    end
    column 'Owner' do |t|
      link_to t.user.full_name, admin_user_path(t.user_id)
    end

    actions
  end

  filter :id
  filter :title
  filter :user_id

  show do
    attributes_table do
      row :id
      row :title
      row :lat
      row :lng
      row :radius
      row :user_id
      row :topic_id
      row :created_at
      row :updated_at
    end
  end
end
