ActiveAdmin.register Post do


  permit_params :title, :body

  form do |f|
    f.inputs 'Статья' do
      f.input :title
      f.input :body, as: :quill_editor
    end
    f.actions
  end
  
end
