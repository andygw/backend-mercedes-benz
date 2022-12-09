Rails.application.routes.draw do
  get "/museums", to: "museums#home"
end
