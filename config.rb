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

set :index_file, 'index.html'
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
