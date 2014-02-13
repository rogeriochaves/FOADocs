FOADocs::Application.routes.draw do

    get 'google_drive/:action' => 'google_drive'
    get 'google_drive' => 'google_drive#index'

  resources :notificacoes

  resources :comentarios

  resources :versoes

  resources :arquivos

  resources :projetos

	get 'banneres/ordenar' => 'banneres#ordenar'
	post 'banneres/ordenar' => 'banneres#ordenar'

  	resources :banneres, :path => "admin/banneres"


	# The priority is based upon order of creation:
    # first created -> highest priority.

    # Sample of regular route:
    #   match 'products/:id' => 'catalog#view'
    # Keep in mind you can assign values other than :controller and :action

    # Sample of named route:
    #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
    # This route can be invoked with purchase_url(:id => product.id)

    # Sample resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products

    # Sample resource route with options:
    #   resources :products do
    #     member do
    #       get 'short'
    #       post 'toggle'
    #     end
    #
    #     collection do
    #       get 'sold'
    #     end
    #   end

    # Sample resource route with sub-resources:
    #   resources :products do
    #     resources :comments, :sales
    #     resource :seller
    #   end

    # Sample resource route with more complex sub-resources
    #   resources :products do
    #     resources :comments
    #     resources :sales do
    #       get 'recent', :on => :collection
    #     end
    #   end

    # Sample resource route within a namespace:
    #   namespace :admin do
    #     # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
    #     resources :products
    #   end

    resources :editables
    namespace :admin do
        resources :usuarios do
        	collection do
        		get :change_password
        		put :change_password
        	end
        end
        resources :mensagens
        resources :paginas
    end

    get 'admin' => 'admin/admin#index'

    devise_for :usuarios, :path_names => { :sign_in => 'login', :sign_out => 'logout' }, controllers: { sessions: 'sessions' }

    post ':action' => 'page'
    get ':action' => 'page'

    # You can have the root of your site routed with "root"
    # just remember to delete public/index.html.
    root :to => 'page#index'

    # See how all your routes lay out with "rake routes"

    # This is a legacy wild controller route that's not recommended for RESTful applications.
    # Note: This route will make all actions in every controller accessible via GET requests.
    # match ':controller(/:action(/:id))(.:format)'
end
