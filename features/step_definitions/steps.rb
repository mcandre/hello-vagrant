Given(/^the program has finished$/) do
  `make clean && make`
  @cucumber = `./bin/hello`
end

Then(/^the output is hello vagrant$/) do
  @cucumber.chop.should == 'Hello Vagrant!'
end
