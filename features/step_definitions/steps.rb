Given(/^the program has finished$/) do
  `make clean && make`
  @cucumber = `./hello`
end

Then(/^the output is hello vagrant$/) do
  @cucumber.chop.should == 'Hello Vagrant!'
end
