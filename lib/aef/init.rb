# encoding: UTF-8
=begin
Copyright Alexander E. Fischer <aef@raxys.net>, 2009-2013

This file is part of Init.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
=end

require 'set'
require 'pathname'
require 'aef/init/version'

# Namespace for projects of Alexander E. Fischer <aef@raxys.net>.
# 
# If you want to be able to simply type Example instead of Aef::Example to
# address classes in this namespace simply write the following before using the
# classes.
#
# @example Including the namespace
#   include Aef
# @author Alexander E. Fischer
module Aef

  # Clean and simple *nix init scripts with Ruby
  class Init

    VARIABLE_PREFIX = 'aef_init_variable'.freeze

    class << self

      # The default command to be called if no command is specified on the
      # commandline.
      #
      # @note This used to be implicitly set to "restart" but in practice
      #   caused far too much unwanted service restarts, so it is now not
      #   enabled by default.
      #
      # @return [Symbol] a command's name
      attr_writer :default_command

      # The default command to be called if no command is specified on the
      # commandline.
      #
      # @note This used to be implicitly set to "restart" but in practice
      #   caused far too much unwanted service restarts, so it is now not
      #   enabled by default.
      def default_command(command = false)
        if command.equal?(false)
          @default_command
        else
          @default_command = command.to_sym
        end
      end

      # The delay in seconds between the call of the stop and the start method
      # in the predefined restart method.
      #
      # @return [Float] time in seconds
      attr_writer :stop_start_delay

      # The delay in seconds between the call of the stop and the start method
      # in the predefined restart method.
      #
      # @param [Numeric, false] seconds time in seconds, if false is given,
      #   the value will be returned and not modified.
      # @return [Float] time in seconds
      def stop_start_delay(seconds = false)
        if seconds.equal?(false)
          @stop_start_delay ||= 0.0
        else
          @stop_start_delay = seconds.to_f
        end
      end

      # Call this to begin commandline parse.
      #
      # If an invalid command is specified on the commandline, a usage example
      # is displayed. If no command is specified, the default command is
      # started, if one is set.
      def parse
        command = ARGV.shift || :default
    
        valid_commands = []
    
        ancestors.each do |klass|
          valid_commands += klass.public_instance_methods(false)
          break if klass == Aef::Init
        end

        valid_commands = valid_commands.sort.map(&:to_sym)
        valid_commands.uniq!
    
        command = command.to_sym
    
        if command == :default && default_command
          new.send(default_command)
        elsif valid_commands.include?(command)
          new.send(command)
        else
          puts "Usage: #$PROGRAM_NAME {#{valid_commands.join('|')}}"
          exit false
        end
      end

      # Defines a lazy-evaluated class variable.
      #
      # @return [Proc] the given block
      def set(name, &block)
        instance_variable_set("@#{VARIABLE_PREFIX}_#{name}", block)
      end

      # Checks if a lazy-evaluated class variable is defined.
      #
      # @return [true, false] true if the variable is defined. false otherwise.
      def set?(name)
        !!find_variable_recursive(name)
      end

      # Evaluates a lazy-evaluated class variable.
      #
      # @return [Object] the result of the evaluated block
      def get(name)
        if klass = find_variable_recursive(name)
          block = klass.instance_variable_get("@#{VARIABLE_PREFIX}_#{name}")
          instance_eval &block
        else
          nil
        end
      end

      protected

      # Finds out which class in the class hierarchy defined a given variable,
      # if at all.
      #
      # @return [Class, false] if self contains the given variable self is
      #   returned, otherwise false
      def find_variable_recursive(name)
        if instance_variable_defined?("@#{VARIABLE_PREFIX}_#{name}")
          self
        elsif superclass.ancestors.include?(Init)
          superclass.find_variable_recursive(name)
        else
          false
        end
      end

      # Makes lazy-evaluated class variables available in public interface
      def method_missing(name, *arguments)
        if arguments.empty? && set?(name)
          get(name)
        else
          super
        end
      end

    end

    # The start method needs to be implemented in a subclass
    def start
      warn 'start method needs to be implemented'
      exit false
    end
  
    # The stop method needs to be implemented in a subclass
    def stop
      warn 'stop method needs to be implemented'
      exit false
    end
  
    # By default restart simply calls stop and then start
    def restart
      stop
      sleep self.class.stop_start_delay
      start
    end

    protected

    # Makes lazy-evaluated class variables available in the instance
    def method_missing(name, *arguments)
      if arguments.empty? && self.class.set?(name)
        self.class.get(name)
      else
        super
      end
    end

  end
end
