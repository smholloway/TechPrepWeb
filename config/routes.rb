InterviewFlashcards::Application.routes.draw do
	resources :pocketref
  resources :questions

  #get "pocketref/index"
  #get "pocketref/show"

  get "home/index"

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"
end
