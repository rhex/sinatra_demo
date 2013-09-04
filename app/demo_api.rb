$:.unshift(File.dirname(__FILE__))
require 'app_helper'

# This is Demo
class Demo < Sinatra::Base
  puts "fileapp is #{app_file}, file is #{__FILE__}, $0 is #{$0}, rack_env is #{ENV['RACK_ENV']}"

  configure do
    set :port, 3004
    enable :logging, :dump_errors, :raise_errors
    # TODO: maybe I can use session to change scheduled sync time
    # same as set :sessions, true
    enable :sessions
    # I18n setup
    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    I18n.load_path += Dir[File.join(settings.root, 'locales', '*.yml')]
    I18n.backend.load_translations
    I18n.default_locale = :en
    set :foo => 'bar', :baz => proc { 'Hello ' + foo }
    # set :root, File.dirname(__FILE__)
    # public folder is default if created, or :static enabled
    # set :public_folder, Proc.new { File.join(root, "static") }
    # TODO: check true false diff
    set :run, false
    # set :server, %w[thin mongrel webrick]
  end

  # example usage
  # get '/foo' do
  #   session[:message] = 'Hello World!'
  #   redirect to('/bar')
  # end

  configure :development do
    # TODO: how to use this to localize
    # use Rack::Locale
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path('..', __FILE__)
    # if not localhost, TRUSTED_IP=192.168.1.11 shotgun
    # BetterErrors::Middleware.allow_ip! ENV['TRUSTED_IP'] if ENV['TRUSTED_IP']
    set :logging, 0
  end

#  use Rack::Auth::Basic do |username, password|
#      username == 'admin' && password == 'secret'
#  end

  before do
    locale = request.host.split('.')[0]
    I18n.locale = locale if locale != 'www'
    puts "##request is #{request}, ##params are #{params}"
  end

  before '/admin/*' do
#    authenticated!
  end

  helpers do
    def fun
      'fun'
    end
  end

  get '/foo' do
    "baz is #{settings.baz}"
  end

  get '/admin/info' do
    'after authentication, you are here in admin/info'
  end

  get '/better_errors' do
    raise 'Oops! See you are at the better error page'
  end

  get '/i18n' do
    puts "############I18n load path is #{I18n.load_path}"
    I18n.locale = :en
    a = "GOOD: #{I18n.t('hello')}, #{I18n.t('hello world')}, #{I18n.l(Time.now)}"
    I18n.backend.store_translations :en, :friend => {
    :one => '1 friend',
    :other => '%{count} friends'
    }
    b = I18n.translate :friend, :count => 2
    c = I18n.translate :friend, :count => 1
    "#{a},################, #{b}, #############, #{c}"
  end

  get '/i18n/subdomain' do
    I18n.t 'hello'
  end

  # splat shows *
  before '/i18n/:locale/*' do
    puts "##########{params.inspect}"
    I18n.locale = params[:locale]
    request.path_info = '/' + params[:splat][0]
  end

  get '/i18n/:locale' do
    puts "###############{params}"
    I18n.locale = params[:locale]
    # TODO: why wrong?
    # request.path_info = '/' + params[:splat][0]
    I18n.t 'hello'
  end

  get '/rss.xml' do
    builder do |xml|
      xml.instruct! :xml, :version => '1.0'
      xml.rss :version => '2.0' do
        xml.channel do
          xml.title 'Title'
          xml.description 'description'
          xml.link 'link'

          (1..2).each do |num|
            xml.item do
              xml.title 'hello'
              xml.link 'link'
              xml.description 'body'
              xml.pubDate Time.now
            end
          end
        end
      end
    end
  end

  get '/redirect' do
    redirect '/redirect_to'
  end

  get '/redirect_to' do
    'this is redirect to'
  end

  get '/coffee' do
    coffee :coffee
  end

  get '/session' do
    # seems not work well here
    session['counter'] ||= 0
    session['counter'] += 1
    "You have hit this page #{session['counter']} times!"
  end

  get '/fun' do
    fun
  end

  get '/' do
    erb :index
  end

  get '/erb' do
    @time = Time.now
    sass :sass, :style => :expanded
    erb :erb
  end

  get '/haml' do
    @time = Time.now
    haml :haml
  end

  get '/builder' do
    builder { |xml| xml.em 'xml builder' }
  end

  get '/nokogiri' do
    nokogiri { |xml| xml.em 'xml nokogiri' }
  end

  get '/hi' do
    logger.error 'get /hi'
    "Hello World!\n"
  end

  delete '/schedule' do
    puts "delete /schedule?id=#{params[:id]}"
    GeneralResult.ok.to_json
  end

  run! if app_file == $0
end
