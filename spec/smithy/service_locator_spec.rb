require "smithy/service_locator"

describe Smithy::ServiceLocator do
  class Dependency
    def value
      :expected_result
    end
  end

  class ExampleServiceLocator
    include Smithy::ServiceLocator

    dependency :foo

    def test
      foo.value
    end
  end

  let(:container) { Smithy::Container.new }
  let(:test_object) { ExampleServiceLocator.new }

  before do
    container.register(:foo, Dependency)
    Smithy::ServiceLocator.register_container(container)
  end

  it "provides requested dependencies" do
    test_object.test.should == :expected_result
  end

  it "makes the dependencies private" do
    test_object.private_methods.should include("foo")
  end
end
