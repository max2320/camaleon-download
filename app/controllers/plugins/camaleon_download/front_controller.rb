class Plugins::CamaleonDownload::FrontController < CamaleonCms::Apps::PluginsFrontController
  include Plugins::CamaleonDownload::MainHelper
  before_action :is_authenticated?

  def index
    # actions for frontend module
  end

  # add custom methods below

  private
  def is_authenticated?
    unless signin?
      redirect_to cama_admin_login_path
    end
  end
end
