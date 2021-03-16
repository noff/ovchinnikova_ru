Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  get 'about', to: 'welcome#about'
  get 'books', to: 'welcome#books'
  get 'book_mortal_kombat', to: 'welcome#book_mortal_kombat'
  get 'book_return', to: 'welcome#book_return'
  get 'book_zero', to: 'welcome#book_zero'
  get 'book_stories', to: 'welcome#book_stories'
  get 'book_twist', to: 'welcome#book_twist'
  get 'book_brick', to: 'welcome#book_brick'
  get 'book_vecherinka', to: 'welcome#book_vecherinka'
  get 'meeting', to: 'welcome#meeting'
  get 'news', to: 'welcome#news'
  get 'librarians', to: 'welcome#librarians'
  get 'read_free', to: 'welcome#read_free'
  get 'contacts', to: 'welcome#contacts'
  get 'audio_video', to: 'welcome#audio_video'

  root to: 'welcome#index'
end
