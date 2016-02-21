set :css_dir, 'css' if File.directory? 'source/css/'
set :images_dir, 'img' if File.directory? 'source/img/'
set :js_dir, 'js' if File.directory? 'source/js/'

ignore 'intros/*' if File.directory? 'source/intros/'
ignore 'partials/*' if File.directory? 'source/partials/'

# set :layout, '_auto_layout'
%w[atom css json rss txt xml].each do |ext|
  page "*.#{ext}", layout: false
end

Time.zone = 'America/New_York'

# activate :autoprefixer, browsers: ['last 2 versions'], cascade: false

activate :blog do |blog|
  # blog.name = nil
  # blog.prefix = nil

  # blog.custom_collections = {}
  # blog.publish_future_dated = false
  # blog.preserve_locale = false

  blog.sources = 'blog/{title}.html'
  blog.default_extension = '.slim'
  # blog.summary_separator = /(READMORE)/

  blog.layout = 'blog'

  blog.permalink = '{title}.html'

  # blog.generate_tag_pages = true
  blog.tag_template = 'tag.html'
  blog.taglink = '{tag}.html'

  blog.generate_year_pages = false
  blog.generate_month_pages = false
  blog.generate_day_pages = false

  # blog.calendar_template = nil
  # blog.year_template = nil
  # blog.month_template = nil
  # blog.day_template = nil

  blog.year_link = nil
  blog.month_link = nil
  blog.day_link = nil

  # blog.summary_generator = nil
  # blog.summary_length = 250

  blog.paginate = true
  blog.per_page = 3
  blog.page_link = 'page/{num}.html'
end

# set :index_file, 'index.html'
activate :directory_indexes

configure :development do
  # activate :livereload, apply_js_live: false, no_swf: true
  set :port, 5000
  set :sass_source_maps, false
  set :sass, cache: false, line_comments: false, style: :expanded
  set :slim,
    attr_quote: "'",
    format: :xhtml,
    pretty: true,
    sort_attrs: true,
    shortcut: {
      '@' => { attr: 'role' },
      '#' => { attr: 'id' },
      '.' => { attr: 'class' },
      '%' => { attr: 'itemprop' },
      '&' => { attr: 'type', tag: 'input' } }
  set :strip_index_file, false

  # url_for('/blog/file.html') or url_for(sitemap.resources[0])
  # Example: style[link="#{url_for('/css/style.css')}" rel='stylesheet']
  set :relative_links, true
  activate :relative_assets
end

configure :production do
  set :port, 5001
  set :sass, cache: false, line_comments: false, style: :compressed
  set :slim,
    attr_quote: "'",
    format: :xhtml,
    pretty: false,
    sort_attrs: true,
    shortcut: {
      '@' => { attr: 'role' },
      '#' => { attr: 'id' },
      '.' => { attr: 'class' },
      '%' => { attr: 'itemprop' },
      '&' => { attr: 'type', tag: 'input' } }

  activate :asset_hash
  activate :minify_css
  activate :minify_html, remove_quotes: false, simple_boolean_attributes: false
  activate :minify_javascript
end
