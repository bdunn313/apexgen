Given /^the file "([^"]*)" doesn't exist$/ do |file|
  FileUtils.rm(file) if File.exists? file
end

Given /^the file "([^"]*)" doesn't exist in my current directory$/ do |filename|
  step %(the file "#{ENV['PWD']}/#{filename}" doesn't exist)
end

Then /^a file named "([^"]*)" should exist in my current directory$/ do |filename|
  step %(a file named "#{ENV['PWD']}/#{filename}" should exist)
end

Then /^the file "([^"]*)" in my current directory should contain "(.*?)"$/ do |filename, matcher|
  step %(the file "#{ENV['PWD']}/#{filename}" should contain "#{matcher}")
end

# Then /^the file "([^"]*)" in my current directory should contain:$/ do |filename, partial_content|
#   check_file_content("#{ENV['PWD']}/#{filename}", partial_content, true)
# end