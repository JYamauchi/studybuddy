### I didn't write this! I found it here: http://makandracards.com/makandra/6087-ruby-indent-a-string

String.class_eval do

  def indent(count, char = ' ')
    gsub(/([^\n]*)(\n|$)/) do |match|
      last_iteration = ($1 == "" && $2 == "")
      line = ""
      line << (char * count) unless last_iteration
      line << $1
      line << $2
      line
    end

  end

end
