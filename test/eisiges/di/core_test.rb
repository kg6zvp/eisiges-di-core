require 'test_helper'

class ServiceObject
	shareable :my_scope

	def get_Status
		"status: green"
	end
end

class DiExample
	#include Eisiges::DI::Core #not necessary because of inclusion in Ruby's Object class

	inject klasse: ServiceObject, as: :so
end
	

class Eisiges::DI::CoreTest < Minitest::Test
	def test__that_it_has_a_version_number
		refute_nil ::Eisiges::DI::Core::VERSION
	end

	def test__it_can_list_dependencies_in_example
		assert_equal({:so => ServiceObject}, DiExample.dependencies)
		assert_equal({:so => ServiceObject}, DiExample.get_injection_points)

		assert_equal({}, ServiceObject.dependencies)
		assert_equal({}, ServiceObject.get_injection_points)
	end

	def test__it_can_express_shareability
		refute_nil DiExample.shareable?
		refute_nil ServiceObject.shareable?

		refute DiExample.shareable?
		assert_equal :my_scope, ServiceObject.shareable?
	end
end
