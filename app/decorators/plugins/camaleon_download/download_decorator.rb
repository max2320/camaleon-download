class Plugins::CamaleonDownload::DownloadDecorator < CamaleonCms::PostDecorator
  def self.object_class_name
    'CamaleonCms::Post'
  end
end
