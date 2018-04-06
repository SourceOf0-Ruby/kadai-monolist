Rails.application.routes.draw do
  
  # トップページ
  root to: 'toppages#index';
  
  # ユーザ周り
  get 'signup', to: 'users#new';
  resources :users, only: [:show, :new, :create];
  
end
