Rails.application.routes.draw do
    scope PluginRoutes.system_info["relative_url_root"] do
      scope '(:locale)', locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
        # frontend
        resources :downloads, only: [:show]
        namespace :plugins do
          namespace 'camaleon_download' do
            resources :downloads, only: [:index]
            get 'index' => 'front#index'
          end
        end
      end

      #Admin Panel
      scope :admin, as: 'admin', path: PluginRoutes.system_info['admin_path_name'] do
        namespace 'plugins' do
          namespace 'camaleon_download' do
            resources :downloads do

            end

            controller :admin do
              get :index
              get :settings
              post :save_settings
            end
          end
        end
      end

      # main routes
      #scope 'camaleon_download', module: 'plugins/camaleon_download/', as: 'camaleon_download' do
      #  Here my routes for main routes
      #end
    end
  end
