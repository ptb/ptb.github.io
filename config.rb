Time.zone = 'America/New_York'

set :css_dir, 'css' if File.directory?('source/css/')
set :images_dir, 'img' if File.directory?('source/img/')
set :js_dir, 'js' if File.directory?('source/js/')

set :partials_dir, 'partials' if File.directory?('source/partials/')

ignore 'intros/*' if File.directory?('source/intros/')

# set :layout, 'minimum'
exts = %w[atom css json rss txt xml]
exts.each do |ext|
  page "*.#{ext}", layout: false
end

Slim::Engine.set_options attr_quote: "'", :format => :xhtml, pretty: true, sort_attrs: true, shortcut: {'@' => {attr: 'role'}, '#' => {attr: 'id'}, '.' => {attr: 'class'}, '%' => {attr: 'itemprop'}, '&' => {tag: 'input', attr: 'type'}}

# set :relative_links, true
activate :relative_assets
# activate :asset_hash

activate :directory_indexes
set :index_file, 'index.html'

# Reload the browser automatically whenever files change
configure :development do
  set :sass, cache: false, line_comments: false, style: :expanded
  
  activate :livereload
end

configure :build do
  Slim::Engine.set_default_options pretty: false

  # activate :minify_css
  set :sass, cache: false, line_comments: false, style: :compressed

  # activate :minify_javascript

  activate :asset_hash

  activate :minify_html, remove_quotes: false, simple_boolean_attributes: false
  # activate :gzip, exts: %w(.atom .css .html .js .rss .svg .txt .xhtml .xml .eot .otf .ttf)
end
