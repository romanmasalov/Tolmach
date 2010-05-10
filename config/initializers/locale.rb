I18n.load_path += Dir[File.join(RAILS_ROOT, 'config', 'locales', '**', '*.{rb,yml}')]
I18n.default_locale = :en
RoutingFilter::Locale.include_default_locale = false