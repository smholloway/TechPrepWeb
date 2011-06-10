InterviewFlashcards::Application.routes.draw do
	#pocketref does not have all RESTful routes, but this provides more flexibility just in case
	resources :pocketref 

  resources :questions

  get "home/index"

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"
end
