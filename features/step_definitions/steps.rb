Given(/^the program has finished$/) do
  `make clean && make`
  @cucumber = `./hello`
end

Then(/^the output is hello world$/) do
  @cucumber.chop.should == 'Hello Vagrant!'
end
