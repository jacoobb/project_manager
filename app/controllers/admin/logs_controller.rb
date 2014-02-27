class Admin::LogsController < AdminController
  def index
    @policy = IO.read("#{Rails.root}/log/development.log")
  end
end