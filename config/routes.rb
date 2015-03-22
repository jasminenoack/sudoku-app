Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    resources :puzzles
  end

  get 'puzzles/:id/solve' => 'puzzles#solve'
  get 'puzzles/:id/display_original' => 'puzzles#display_original'
  get 'puzzles/:id/display_solution' => 'puzzles#display_solution'
  get 'puzzles/:id/revert_puzzle' => 'puzzles#revert_puzzle'
  resources :puzzles
  root 'puzzles#index'

end
