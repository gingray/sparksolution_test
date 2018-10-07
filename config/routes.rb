
Rails.application.routes.draw do
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  Spree::Core::Engine.routes.draw do
    namespace :admin, path: Spree.admin_path do

      resources :products do
        post :import_csv, on: :collection
        get :import, on: :collection
      end
    end
  end

  mount Spree::Core::Engine, at: '/'
end
