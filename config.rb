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

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
