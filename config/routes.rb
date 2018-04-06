Rails.application.routes.draw do
  
  # トップページ
  root to: 'toppages#index';
  
  # ログイン周り
  get    'login' , to: 'sessions#new';
  post   'login' , to: 'sessions#create';
  delete 'logout', to: 'sessions#destroy';

  # ユーザ周り
  get 'signup', to: 'users#new';
  resources :users, only: [:show, :new, :create];
  
end
