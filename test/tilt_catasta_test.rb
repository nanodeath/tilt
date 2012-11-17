require 'contest'
require 'tilt'

begin
  class ::MockError < NameError
  end

  require 'catasta'

  class CatastaTemplateTest < Test::Unit::TestCase
    test "registered for '.catasta' files" do
      assert_equal Tilt::CatastaTemplate, Tilt['test.cat']
    end

    test "preparing and evaluating templates on #render" do
      template = Tilt::CatastaTemplate.new { |t| "Hello World!" }
      assert_equal "Hello World!", template.render
    end

    test "can be rendered more than once" do
      template = Tilt::CatastaTemplate.new { |t| "Hello World!" }
      3.times { assert_equal "Hello World!", template.render }
    end

    test "passing locals" do
      template = Tilt::CatastaTemplate.new { <<-STR }
---
doctype: html5
parameters:
  name: str
---
target: Ruby
---
Hey {{= name }}!
      STR
      assert_equal "Hey Joe!", template.render(Object.new, :name => 'Joe')
    end

  #   test "evaluating in an object scope" do
  #     template = Tilt::HamlTemplate.new { "%p= 'Hey ' + @name + '!'" }
  #     scope = Object.new
  #     scope.instance_variable_set :@name, 'Joe'
  #     assert_equal "<p>Hey Joe!</p>\n", template.render(scope)
  #   end

  #   test "passing a block for yield" do
  #     template = Tilt::HamlTemplate.new { "%p= 'Hey ' + yield + '!'" }
  #     assert_equal "<p>Hey Joe!</p>\n", template.render { 'Joe' }
  #   end

  #   test "backtrace file and line reporting without locals" do
  #     data = File.read(__FILE__).split("\n__END__\n").last
  #     fail unless data[0] == ?%
  #     template = Tilt::HamlTemplate.new('test.haml', 10) { data }
  #     begin
  #       template.render
  #       fail 'should have raised an exception'
  #     rescue => boom
  #       assert_kind_of NameError, boom
  #       line = boom.backtrace.grep(/^test\.haml:/).first
  #       assert line, "Backtrace didn't contain test.haml"
  #       file, line, meth = line.split(":")
  #       assert_equal '12', line
  #     end
  #   end

  #   test "backtrace file and line reporting with locals" do
  #     data = File.read(__FILE__).split("\n__END__\n").last
  #     fail unless data[0] == ?%
  #     template = Tilt::HamlTemplate.new('test.haml') { data }
  #     begin
  #       res = template.render(Object.new, :name => 'Joe', :foo => 'bar')
  #     rescue => boom
  #       assert_kind_of MockError, boom
  #       line = boom.backtrace.first
  #       file, line, meth = line.split(":")
  #       assert_equal 'test.haml', file
  #       assert_equal '5', line
  #     end
  #   end
  # end

  # class CompiledHamlTemplateTest < Test::Unit::TestCase
  #   class Scope
  #   end

  #   test "compiling template source to a method" do
  #     template = Tilt::HamlTemplate.new { |t| "Hello World!" }
  #     template.render(Scope.new)
  #     method = template.send(:compiled_method, [])
  #     assert_kind_of UnboundMethod, method
  #   end

  #   test "passing locals" do
  #     template = Tilt::HamlTemplate.new { "%p= 'Hey ' + name + '!'" }
  #     assert_equal "<p>Hey Joe!</p>\n", template.render(Scope.new, :name => 'Joe')
  #   end

  #   test "evaluating in an object scope" do
  #     template = Tilt::HamlTemplate.new { "%p= 'Hey ' + @name + '!'" }
  #     scope = Scope.new
  #     scope.instance_variable_set :@name, 'Joe'
  #     assert_equal "<p>Hey Joe!</p>\n", template.render(scope)
  #   end

  #   test "passing a block for yield" do
  #     template = Tilt::HamlTemplate.new { "%p= 'Hey ' + yield + '!'" }
  #     assert_equal "<p>Hey Joe!</p>\n", template.render(Scope.new) { 'Joe' }
  #   end

  #   test "backtrace file and line reporting without locals" do
  #     data = File.read(__FILE__).split("\n__END__\n").last
  #     fail unless data[0] == ?%
  #     template = Tilt::HamlTemplate.new('test.haml', 10) { data }
  #     begin
  #       template.render(Scope.new)
  #       fail 'should have raised an exception'
  #     rescue => boom
  #       assert_kind_of NameError, boom
  #       line = boom.backtrace.grep(/^test\.haml:/).first
  #       assert line, "Backtrace didn't contain test.haml"
  #       file, line, meth = line.split(":")
  #       assert_equal '12', line
  #     end
  #   end

  #   test "backtrace file and line reporting with locals" do
  #     data = File.read(__FILE__).split("\n__END__\n").last
  #     fail unless data[0] == ?%
  #     template = Tilt::HamlTemplate.new('test.haml') { data }
  #     begin
  #       res = template.render(Scope.new, :name => 'Joe', :foo => 'bar')
  #     rescue => boom
  #       assert_kind_of MockError, boom
  #       line = boom.backtrace.first
  #       file, line, meth = line.split(":")
  #       assert_equal 'test.haml', file
  #       assert_equal '5', line
  #     end
  #   end
  end
rescue LoadError => boom
  warn "Tilt::CatastaTemplate (disabled) #{boom}"
end
