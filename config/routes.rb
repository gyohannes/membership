Rails.application.routes.draw do
  resources :pages
  mount Thredded::Engine => '/forum'
  resources :support_requests
  resources :board_members_terms
  resources :association_details
  resources :event_applicants
  resources :events do
    member do
      get 'apply'
    end
  end
  resources :payments do
    collection do
      get 'member_fees'
    end
    member do
      get 'confirm'
    end
  end
  resources :mp_amount_settings
  resources :mp_years
  resources :membership_types
  resources :budget_years
  resources :training_materials
  resources :training_methods
  resources :training_funds do
    collection do
      get 'funding_by_area'
    end
  end
  resources :trainee_distributions
  resources :educations
  resources :work_experiences
  resources :trainer_profiles
  resources :languages
  resources :professions
  resources :profession_categories
  get 'reports/trainings'
  post 'reports/trainings'
  get 'reports/health_workers'
  post 'reports/health_workers'
  get 'reports/trainees'
  post 'reports/trainees'
  get 'reports/members'
  post 'reports/members'

  resources :trainees do
    collection do
      get 'load_trainees'
      get 'institution_trainees_by_area'
      get 'institution_trainees_by_region'
      get 'institution_trainees_by_year'

      get 'org_unit_trainees_by_area'
      get 'org_unit_trainees_by_year'
      get 'org_unit_trainees_by_category'
    end
  end
  resources :trainers
  resources :people do
    member do
      get 'membership_idcard'
      get 'confirm'
    end
    collection do
      get 'load_people'
      get 'load_professions'
      get 'members_by_type'
      get 'members_by_membership_type_and_payment_status'
      get 'members_paid'
      get 'load_members_paid'
      get 'members_not_paid'
      get 'load_members_not_paid'
    end
  end
  resources :facilities do
    collection do
      get 'load_facilities'
    end
  end
  resources :facility_types
  resources :trainings do
    collection do
      get 'load_distribution'
    end
    member do
      delete 'cancel'
      get 'undo_cancel'
    end
  end

  resources :training_titles do
    collection do
      get 'training_titles_by_area'
      get 'load_training_titles'
    end
  end

  resources :program_areas
  resources :institutions
  resources :institution_types
  resources :organization_units do
    collection do
      get 'load_tree'
      get 'load_sub_units'
      get 'org_unit_facilities'
    end
  end
  resources :organization_types
  resources :roles
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  scope "/admin" do
    resources :users do
      member do
        get 'confirm'
      end
      collection do
        get 'load_users'
        get 'institution_users'
        get 'new_institution_user'
        get 'edit_institution_user'
      end
    end
  end
  get 'home/index'
  get 'home/landing_page'
  get 'payment_dashboard', to: 'home#payment_dashboard'
  get 'training_dashboard', to: 'home#training_dashboard'
  get 'member_dashboard', to: 'home#member_dashboard'

  authenticated :user do
    root 'home#index', as: :authenticated_root
  end

  root to: "home#landing_page"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
