module Api
  class ApiController < ApplicationController
    before_action :check_log_in
  end
end