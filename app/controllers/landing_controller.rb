class LandingController < Devise::RegistrationsController
  def index
    build_resource
    render 'index', layout: "basic"
  end
end
