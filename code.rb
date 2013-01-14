

str = 'abc@gmail.com'
puts str.gsub(/[@]/, '_at_').gsub(/[.]/,'_dot_')