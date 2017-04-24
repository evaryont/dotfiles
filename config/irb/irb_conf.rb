require 'logger'

begin
    def tramp_require(what, &block)
        loaded, require_result = false, nil

        begin
            require_result = require what
            loaded = true

        rescue Exception => ex
            puts "** Unable to require '#{what}'"
            puts "--> #{ex.class}: #{ex.message}"
        end

        yield if loaded and block_given?

        require_result
    end

    tramp_require 'irb/ext/save-history' do
        # Save history across sessions to a file
        IRB.conf[:HISTORY_FILE] = File.expand_path File.join(ENV['XDG_DATA_HOME'], "irb_history") # Where to store the history
        IRB.conf[:SAVE_HISTORY] = 500 # How many lines to save in the history
    end
    tramp_require 'irb/completion' # Tab complete objects/methods

    tramp_require 'rubygems'
    tramp_require 'rainbow'
    #tramp_require 'method_extensions' # Awesome extensions to Method
    #tramp_require 'method_extensions/method/super' # Mods core classes!
    tramp_require 'hirb'
    tramp_require 'net-http-spy' do # Spy on Net::HTTP requests
        # These logger settings need to be redefined
        # https://github.com/martinbtt/net-http-spy/issues/2
        if defined? Net::HTTP::Persistent::SSLReuse
            Net::HTTP::Persistent::SSLReuse.http_logger = Logger.new(STDOUT)
            Net::HTTP::Persistent::SSLReuse.http_logger_options = {:body => true, :verbose => true, :trace => true}
        end
    end
    tramp_require 'wirble' do
        Wirble.init
    end
    tramp_require File.join(File.dirname(__FILE__), 'irb_rocket.rb')
    tramp_require "ap"
    #tramp_require "looksee/shortcuts"
    if File.exists?(ENV['CONFIG_RU'] || "config.ru")
        tramp_require "racksh/init" do
            ENV['CONFIG_RU'] ||= 'config.ru'
            ENV['RACK_ENV'] ||= 'development'
            Rack::Shell.init
        end
    end

    Thread.abort_on_exception = true
    ARGV.concat ["--readline", "--prompt-mode", "simple"]

    IRB.conf[:USE_READLINE] = true # Use readline

    # http://ozmm.org/posts/time_in_irb.html
    def time(times = 1)
        return nil unless block_given?
        require 'benchmark'
        ret = nil
        Benchmark.bm { |x| x.report { times.times { ret = yield } } }
        ret
    end

    # thanks rtomayko
    def IRB.reload
        load __FILE__
    end

    def copy(str)
        IO.popen('xclip -i', 'w') { |f| f << str.to_s }
    end

    def paste
        `xclip -o`
    end

    def ep
        eval(paste)
    end

    HASH = { :red => "blue", "blue" => :green, 3 => "four" } unless defined?(HASH)
    ARRAY = HASH.keys unless defined?(ARRAY)
    STRING = "blue" unless defined?(STRING)
    SYMBOL = :green unless defined?(SYMBOL)

# Make some noise whenever there is an exception, of any kind.
# Otherwise IRB won't report any error and just stop executing irbrc, leaving me
# confused as to why some of the RC file hasn't been loaded.
rescue Exception => e
    puts Rainbow("Error!").red.italic.bold + " #{e.class} raised:"
    puts "> #{e.message}"
    puts e.backtrace.join("\n")
end
