class DownloadsController < CamaleonCms::FrontendController
  include Plugins::CamaleonDownload::MainHelper
  before_action :is_authenticated?

  def index
    # actions for frontend module
  end

  # add custom methods below
  def show
    file_name = CamaleonCms::Post.find(params[:id]).decorate.the_field('downloads_file')
    f_path = CamaleonCmsLocalUploader::private_file_path(file_name, current_site)
    if File.exist?(f_path)
      Download.create({
        user_id: current_user.id,
        post_id: params[:id],
        metadata: {
          ip: request.ip,
          user_agent: request.user_agent,
          file_name: file_name
        }
      })

      send_file f_path, disposition: 'inline'
    else
      raise ActionController::RoutingError, 'File not found'
    end
  end

  private
  def is_authenticated?
    unless signin?
      redirect_to cama_admin_login_path(return_to: request.url)
    end
  end
end
