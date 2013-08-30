# Dir.glob("#{File.dirname(__FILE__)}/*.rb").each{ |file| require file }
require 'sinatra'
require 'json'
require 'better_errors'
require 'i18n'
# TODO: what fallbacks used for?
require 'i18n/backend/fallbacks'
require 'mongo'
require 'json/ext'
require 'mongoid'
$:.unshift File.expand_path('../../data', __FILE__)
require 'general_result'
require 'demo_result'
# TODO: choose 1 way from include extend self
include DemoResult
