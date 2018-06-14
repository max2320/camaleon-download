module Plugins::CamaleonDownload::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  def camaleon_download_on_active(plugin)
    install
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def camaleon_download_on_inactive(plugin)
    uninstall
  end

  # here all actions to upgrade for a new version
  # plugin: plugin model
  def camaleon_download_on_upgrade(plugin)
  end

  # hook listener to add settings link below the title of current plugin (if it is installed)
  # args: {plugin (Hash), links (Array)}
  # permit to add unlimmited of links...
  def camaleon_download_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_camaleon_download_settings_path)
  end

  def camaleon_download_before_load
    pt = current_site.post_types.hidden_menu.where(slug: "downloads").first
    admin_menu_insert_menu_after("content", "downloads", {
      icon: "download",
      title: t('plugins.download.title', default: 'Downloads'),
      url: "",
      items: [
        {
          icon: "folder-open",
          title: "Arquivos",
          url: cama_admin_post_type_posts_path(pt.try(:id))
        }, {
          icon: "folder-open",
          title: "Downloads",
          url: admin_plugins_camaleon_download_downloads_path
        }
      ]

    })
  end

  def camaleon_download_add_shortcodes
    shortcode_add("download", lambda { |attrs, args| "<a href='/downloads/#{attrs['id']}' target='_blank'>#{attrs['label']}</a>" }, '[download id="<id do arquivo>" label="texto"]')
  end

  private
  def install
    get_post_type
    install_field_group
  end

  def get_post_type
    downloads = current_site.post_types.hidden_menu.where(slug: "downloads").first

    unless downloads.present?
      downloads = current_site.post_types.hidden_menu.new(slug: "downloads", name: "Downloads")

      if downloads.save
        downloads.set_options({
          has_category: false,
          has_tags: false,
          not_deleted: false,
          has_summary: false,
          has_content: false,
          has_comments: false,
          has_picture: false,
          has_template: false,
          has_featured: false,
          has_seo: false
        })
      end
    end

    downloads
  end


  def install_field_group
    downloads = get_post_type

    unless downloads.get_field_groups.where(slug: "plugin_downloads_file").present?
      downloads.get_field_groups.destroy_all

      group = downloads.add_custom_field_group({name: 'Arquvivo', slug: 'plugin_downloads_file'})
      group.add_manual_field({
        "name" => "t('plugins.downloads.product.file', default: 'Arquivo')",
        "slug" => "downloads_file"
      }, {
        field_key: "private_file",
        multiple: false,
        required: false,
        label_eval: true
      })
      group.add_manual_field({
        "name" => "Couter",
        "slug" => "downloads_file_counter"
      }, {
        field_key: "hidden",
        multiple: false,
        required: false,
        label_eval: false
      })
    end
  end

  def uninstall
    downloads = current_site.post_types.hidden_menu.where(slug: "downloads").first
    downloads.destroy if downloads
  end
end
