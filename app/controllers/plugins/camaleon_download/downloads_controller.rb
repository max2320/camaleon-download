class Plugins::CamaleonDownload::DownloadsController < CamaleonCms::Apps::PluginsAdminController
  include Plugins::CamaleonDownload::MainHelper

  def index
    @downloads = Download.order(id: :desc)
  end

  # add custom methods below
  def show
  end
end
