#!/usr/bin/env ruby

require 'optparse'
require 'colorize'

options = Hash.new
options[:directory] = "./"

OptionParser.new do |parser|
	parser.banner = "Usage: puller [options]"

	# parser.on("-d", "--directory PATH", "Path where repositories exist. Defaults to current diurectory") do |d|
	# 	options[:directory] = defined? d
	# 	puts options[:directory]
	# end

	parser.on("-a", "--all", "Pull down all changes for repositories in a given directory") do ||
		options[:all] = true
	end

	parser.on("-n", "--name NAME", "The name of the person you'd like to greet") do |v|
		options[:name] = v
	end

	parser.on("-h", "--help", "Show help message") do ||
		puts parser
	end
end.parse!

directories = Dir.entries(options[:directory]).select { |entry| File.directory? File.join(options[:directory], entry) and !(entry == '.' || entry == '..') }

directories.each do |directory|
	Dir.chdir(directory)
	if Dir.glob(".git").length == 1
		directoryName = "#{directory}".blue
		puts "Pulling down #{directoryName}"
		system("git pull origin master")
	end
	puts "=============="
	Dir.chdir("..")
end
