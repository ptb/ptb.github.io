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

activate :blog do |blog|
  blog.prefix = 'blog'
  blog.layout = 'blog'

  blog.sources = ':title.html'
  blog.default_extension = '.slim'
  blog.summary_separator = /(READMORE)/

  blog.permalink = ':title.html'

  blog.tag_template = 'articles.html'
  blog.taglink = ':tag/index.html'

  blog.calendar_template = 'articles.html'
  blog.year_link = 'index.html'
  blog.month_link = ':year/:month/index.html'
  blog.day_link = ':year/:month/:day/index.html'

  blog.paginate = true
  blog.per_page = 3
  blog.page_link = 'page-:num'
end

Slim::Engine.set_options attr_quote: "'", :format => :xhtml, pretty: true, sort_attrs: true, shortcut: {'@' => {attr: 'role'}, '#' => {attr: 'id'}, '.' => {attr: 'class'}, '%' => {attr: 'itemprop'}, '&' => {tag: 'input', attr: 'type'}}

set :index_file, 'index.html'
set :relative_links, true
set :strip_index_file, false

activate :directory_indexes
activate :relative_assets

configure :development do
  set :sass, cache: false, line_comments: false, style: :expanded

  # activate :livereload
end

configure :build do
  Slim::Engine.set_options pretty: false

  # activate :minify_css
  set :sass, cache: false, line_comments: false, style: :compressed

  # activate :minify_javascript

  activate :asset_hash

  activate :minify_html, remove_quotes: false, simple_boolean_attributes: false
  # activate :gzip, exts: %w(.atom .css .html .js .rss .svg .txt .xhtml .xml .eot .otf .ttf)
end
