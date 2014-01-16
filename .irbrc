require 'pp'
require 'irb/completion'

# wirble is amazing
require 'wirble'
Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true

class Object
  # get all the methods for an object that aren't basic methods from Object
  def my_methods
    (methods - Object.instance_methods).sort
  end
end

def rl(file_name = nil)
  if file_name.nil?
    if !@recent.nil?
      rl(@recent)
    else
      puts "No recent file to reload"
    end
  else
    file_name += '.rb' unless file_name =~ /\.rb/
    @recent = file_name
    load "#{file_name}"
  end
end

alias p=pp