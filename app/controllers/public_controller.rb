class PublicController < ApplicationController
  skip_before_action :ensure_signed_in

end
