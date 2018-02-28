require 'test_helper'

class ServiceObject
	def get_Status
		"status: green"
	end
end

class DiExample
	include Eisiges::DI::Core

	inject klasse: ServiceObject, as: :so
end
	

class Eisiges::DI::CoreTest < Minitest::Test
	def test__that_it_has_a_version_number
		refute_nil ::Eisiges::DI::Core::VERSION
	end

	def test__it_can_list_dependencies_in_example
		assert_equal({:so => ServiceObject}, DiExample.dependencies)
		assert_equal({:so => ServiceObject}, DiExample.get_injection_points)
	end
end
