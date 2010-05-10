class TranslationsController < ApplicationController
  def index
    @keys = YAML::load(File.open("#{RAILS_ROOT}/config/locale_keys.yml"))
  end

  def edit
    key = [params[:id]].pack('H*')
    file_path = "#{RAILS_ROOT}/config#{key}"
    begin
      @keys = YAML::load(File.open("#{RAILS_ROOT}/config/locale_keys.yml"))
      @keys.reject!{|k, v| k != key}
      @keys
    rescue Exception => e
      flash[:error] = e
      redirect_to translations_path
    end
    @translations = {key => {}}
    for locale in I18n.backend.available_locales
      begin
        @translations[key].merge! YAML::load(File.open(file_path + "/#{locale.to_s}.yml"))
      rescue
        @translations[key].merge! locale.to_s =>  ''
      end
    end
  end

  def update
    begin
      file_path = "#{RAILS_ROOT}/config#{[params[:id]].pack('H*')}"
      FileUtils.mkdir_p file_path  unless File.exist?(file_path)

      for locale in I18n.backend.available_locales
        @translations = {locale.to_s => check_hash(params[locale])}
        File.open(file_path + "/#{locale.to_s}.yml", 'w'){ |f| f << YAML.dump(@translations) }
        @translations = nil
      end

    rescue Exception => e
      flash[:error] = e
    else
      flash[:message] = t('translations.flash.updated')
    end
    I18n.load_path += Dir[File.join(RAILS_ROOT, 'config', 'locales', '**', '*.{rb,yml}')]
    I18n.reload!

    redirect_to translations_path
  end

  def switch_language
    var = request.referer.split("/")
    if var[3] == I18n.locale.to_s
      var[3] = params[:switch_to]
      url = var.join('/')
    else
      var.insert(3, params[:switch_to])
      url = var.join('/')

    end
    redirect_to url
  end

  private

  def check_hash(h)
    h.each_pair do |k, v|
      if v.present?
        val = v.is_a?(Hash) ? check_hash(v) : v
        if val.present?
          k = val
        else
          h.delete k
        end
      else
        h.delete k
      end
    end
    h
  end
end
