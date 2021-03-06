# method for adding gems without bundler restrictions
def add_gem_to_load_path gem_name
  if defined?(::Bundler)
    $LOAD_PATH.concat Dir.glob("#{Gem.path.first}/gems/#{gem_name}*/lib")
  end
end

# just tab complition in irb
require 'irb/completion'

# multiline indentation
IRB.conf[:AUTO_INDENT]=true

IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => "irb> ",
  :PROMPT_S => "%l> ",
  :PROMPT_C => ".. ",
  :PROMPT_N => ".. ",
  :RETURN => "=> %s\n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM

# irb history
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

if defined? ActiveRecord
  module ActiveRecord::IrbExt
    extend ActiveSupport::Concern

    module ClassMethods
      def random
        order('random()')
      end

      def sample
        random.first
      end
    end
  end

  ActiveRecord::Base.send(:include, ActiveRecord::IrbExt)

end
