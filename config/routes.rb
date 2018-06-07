
Rails.application.routes.draw do
  
  get 'churches/Church'
    # Use for login and autorize all resource
  use_doorkeeper do
    # No need to register client application
    skip_controllers :applications, :authorized_applications
  end  


  scope module: :api, defaults: { format: :json }, path: 'api' do
    scope module: :v1 do
      devise_for :users, controllers: {
           registrations: 'api/v1/users/registrations',
       }, skip: [:sessions, :password]
    end

    resources :churches
    resources :masses

    get "masses/bychurch/:church_id", to: "masses#getMassesByChurch", as: "masses_bychurch"
    get "masses/bydate/:year/:month/:day", to: "masses#getMassesByDate", as: "masses_bydate"   
  end
        
end
